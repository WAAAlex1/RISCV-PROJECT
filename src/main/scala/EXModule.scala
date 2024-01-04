import chisel3._
import chisel3.util._
import AluOperations._

class EXModule extends Module {
  val io = IO(new Bundle{

    //Data Signals
    //In
    val rs1data     = Input(SInt(32.W))
    val rs2dataIn   = Input(SInt(32.W))
    val pc          = Input(UInt(32.W))
    val rdIn        = Input(UInt(5.W))
    val imm         = Input(SInt(32.W))
    val aluOpSelect = Input(AluOperations())
    val pcSelect    = Input(Bool()) //Control signal for PC adder (true only if JALR)

    //Out
    val branchAddr  = Output(UInt(32.W))
    val aluResult   = Output(SInt(32.W))
    val rs2DataOut  = Output(SInt(32.W))
    val rdOut       = Output(UInt(5.W))

    //Control signals:
    //In
    val aluSRC      = Input(Bool())     //not passed further
    val branchIn    = Input(Bool())
    val memReadIn   = Input(Bool())
    val memWriteIn  = Input(Bool())
    val regWriteIn  = Input(Bool())
    val memToRegIn  = Input(Bool())
    val branchCheckIn = Input(Bool())

    //Out
    val branchOut   = Output(Bool())
    val memReadOut  = Output(Bool())
    val memWriteOut = Output(Bool())
    val regWriteOut = Output(Bool())
    val memToRegOut = Output(Bool())
    val branchCheckOut = Output(Bool())
  })

  // Pipeline Registers: --------------------------------------------------------
  val rs1data     = RegNext(io.rs1data)
  val rs2dataIn   = RegNext(io.rs2dataIn)
  val pc          = RegNext(io.pc)
  val rdIn        = RegNext(io.rdIn)
  val imm         = RegNext(io.imm)
  val aluOpSelect  = RegNext(io.aluOpSelect)

  val aluSRC      = RegNext(io.aluSRC)
  val branchIn    = RegNext(io.branchIn)
  val memReadIn   = RegNext(io.memReadIn)
  val memWriteIn  = RegNext(io.memWriteIn)
  val regWriteIn  = RegNext(io.regWriteIn)
  val memToRegIn  = RegNext(io.memToRegIn)
  val branchCheckIn = RegNext(io.branchCheckIn)

  // Logic ----------------------------------------------------------------------------
  //AddSum (Calculate branch address
  io.branchAddr := Mux( io.pcSelect, pc.asSInt + imm, rs1data + imm).asUInt

  //Mux on ALU second input
  val muxALUinput = WireDefault(0.S(32.W))
  muxALUinput := Mux(aluSRC,imm,rs2dataIn)

  //ALU
  io.aluResult := 0.S
  switch(aluOpSelect) //enum
  {
    is(ADD){io.aluResult := rs1data + muxALUinput}
    is(SUB){io.aluResult := rs1data - muxALUinput}
    is(XOR){io.aluResult := rs1data ^ muxALUinput}
    is(OR) {io.aluResult := rs1data | muxALUinput}
    is(AND){io.aluResult := rs1data & muxALUinput}
    is(SLL){io.aluResult := rs1data << muxALUinput.asUInt} //SInt intepreted as UInt is big and shift too much
    is(SRL){io.aluResult := ((rs1data.asUInt) >> muxALUinput.asUInt).asSInt} //no msb extend
    is(SRA){io.aluResult := rs1data >> muxALUinput.asUInt} //msb extend
    is(SLT){
      when(rs1data < muxALUinput){
        io.aluResult := 1.S
      }.otherwise {
        io.aluResult := 0.S
      }
    }
    is(SLTU){
      when(rs1data.asUInt < muxALUinput.asUInt){
        io.aluResult := 1.S
      }.otherwise {
        io.aluResult := 0.S
      }
    }
    is(JAL){ io.aluResult := (pc + 4.U).asSInt}
    is(LUI){ io.aluResult := imm}
    is(AUIPC){ io.aluResult := (pc.asSInt + imm)}
  }


  //Outputs ----------------------------------------------------------------------------
  //Control signals:
  io.branchOut := branchIn
  io.branchCheckOut := branchCheckIn
  io.memReadOut := memReadIn
  io.memWriteOut := memWriteIn
  io.regWriteOut := regWriteIn
  io.memToRegOut := memToRegIn

  //Data signals:
  io.rdOut := rdIn
  io.rs2DataOut := rs2dataIn
}