import chisel3._
import chisel3.util._
import Import.Bus

class MEMModule extends Module {
  val io = IO(new Bundle {
    //Data in
    val aluResult    = Input(SInt(32.W))
    val rs2Data      = Input(SInt(32.W))
    val rdIn         = Input(UInt(5.W))

    //Data out
    val regWriteData = Output(SInt(32.W))
    val rdOut        = Output(UInt(5.W))

    //Control signals:
    //In
    val memControl   = Input(new MEMBundle)

    //Out
    val regWriteOut  = Output(Bool())
    val ioWrite      = Output(new IOBundle)

    //UART
    val port = Bus.RequestPort() // bus port
  })

  //Registers on the inputs that dont go through memory:
  val rdIn      = RegNext(io.rdIn)
  val aluResult = RegNext(io.aluResult) //Both through memory AND past it in parallel
  //Registers on control signals that dont go through memory (cant RegNext all signals)
  val regWrite  = RegNext(io.memControl.regWrite)
  val memToReg  = RegNext(io.memControl.memToReg)
  val memSize   = RegNext(io.memControl.memSize) //Regnext because its needed after memory is done fetching
  val memWrite  = RegNext(io.memControl.memWrite) //regnext for use in IO stuff
  val rs2Data = RegNext(io.rs2Data) //for io stuff

  io.port.init()

  //On chip memory:
  val memory    = Module(new Memory(4096,32)) //4096 sized memory
  val memOutput = WireDefault(0.S(32.W))

  //Control signals for our memory
  memory.io.rdAddr  := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrAddr  := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrData  := io.rs2Data.asUInt //non-regnext'ed
  memory.io.wrEna   := io.memControl.memWrite //non-regnext'ed because goes through memory

  //Special case when storing / loading MEM - we need to be able to store both in memory and to send to IO.
  //When we would write, but our memory address is too large for mem, we use IO
  val ioLED = RegInit(0.U(16.W))
  ioLED := ioLED //keep its value
  val ioOut = RegInit(0.S(32.W)) //sends 1 byte at a time but still 32.W

  //All these signals should NOT be reg-nexted because uart takes 1 cycle to do stuff
  switch(io.aluResult){
    is(4096.S){
      when(io.memControl.memWrite){
        ioLED := io.rs2Data(15, 0) //regnexted already
      }
    }
    is(4097.S){ //read write adress for uart
      when(io.memControl.memWrite) {
        io.port.writeRequest(0.U,io.rs2Data.asUInt(7,0))
      } .otherwise {
        io.port.readRequest(0.U)
        ioOut := io.port.rdData.asSInt
        //memOutput := ioOut
      }
    }
    is(4098.S){ //status bits address for uart
      when(!io.memControl.memWrite) {
        io.port.readRequest(1.U)
        ioOut := io.port.rdData.asSInt
        //memOutput := ioOut
      }
    }
    //More io...
  }

  /*
  //Output of our memory
  memOutput := memory.io.rdData.asSInt
  */
  memOutput := Mux(aluResult >= 4096.S,ioOut,memory.io.rdData.asSInt)

  //Control whether we're loading byte, halfword or word and whether unsigned or not.
  val sizedMemOutput = WireDefault(0.S(32.W))
  switch(memSize)
  {
    is(0.U){sizedMemOutput := Mux(memOutput(7) === 1.U,"hFFFFFF".U ## memOutput(7,0),"h000000".U ## memOutput(7,0)).asSInt}//sign extended byte
    is(1.U){sizedMemOutput := Mux(memOutput(15) === 1.U,"hFFFF".U ## memOutput(15,0),"h0000".U ## memOutput(15,0)).asSInt}//sign extended halfword
    is(2.U){sizedMemOutput := memOutput} //word
    is(4.U){sizedMemOutput := ("h000000".U ## memOutput(7,0)).asSInt} //byte unsigned
    is(5.U){sizedMemOutput := ("h0000".U ## memOutput(15,0)).asSInt} //halfword unsigned
  }

  //Write back:
  io.regWriteData := Mux(memToReg,sizedMemOutput,aluResult) //regnext'ed aluresult

  //Other outputs:
  io.rdOut := rdIn
  io.regWriteOut := regWrite

  //IO:
  io.ioWrite.ioLED := ioLED
}
