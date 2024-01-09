import chisel3._
import chisel3.util._

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
    val memControl = Input(new MEMBundle)

    //Out
    val regWriteOut  = Output(Bool())

  })

  //Registers on the inputs that dont go through memory:
  val rdIn = RegNext(io.rdIn)
  val aluResult = RegNext(io.aluResult) //Both through memory AND past it in parallel
  //Registers on control signals that dont go through memory (cant RegNext all signals)
  val regWrite = RegNext(io.memControl.regWrite)
  val memToReg = RegNext(io.memControl.memToReg)
  val memSize = RegNext(io.memControl.memSize) //Regnext because its needed after memory is done fetching

  //On chip memory:
  val memory = Module(new Memory(1024,32))
  memory.io.rdAddr := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrAddr := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrData := io.rs2Data.asUInt //non-regnext'ed
  memory.io.wrEna := io.memControl.memWrite //non-regnext'ed because goes through memory
  val memOutput = WireDefault(0.S(32.W))
  memOutput := memory.io.rdData.asSInt

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
}
