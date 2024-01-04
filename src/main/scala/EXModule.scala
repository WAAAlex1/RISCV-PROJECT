import chisel3._
import chisel3.util._

class EXModule extends Module {
  val io = IO(new Bundle{

    //Data Signals
    //In
    val rs1data     = Input(SInt(32.W))
    val rs2dataIn   = Input(SInt(32.W))
    val pc          = Input(UInt(32.W))
    val rdIn        = Input(UInt(5.W))
    val imm         = Input(SInt(32.W))
    val aluOpSelect  = Input(UInt(4.W))

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

    //Out
    val branchOut   = Output(Bool())
    val memReadOut  = Output(Bool())
    val memWriteOut = Output(Bool())
    val regWriteOut = Output(Bool())
    val memToRegOut = Output(Bool())
    val branchCheck = Output(Bool())
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

  // Logic ----------------------------------------------------------------------------
  //AddSum (Calculate branch address
  io.branchAddr := (pc.asSInt + imm).asUInt

  //Mux on ALU second input
  val muxALUinput = WireDefault(0.S(32.W))
  muxALUinput := Mux(aluSRC,imm,rs2dataIn)

  //ALU
  //io.branchCheck := false.B
  //io.aluResult := 0.S
  io.aluResult := 0.U
  io.branchCheck := false.B
  switch(aluOpSelect) //mvp for now with bge, sw, addi and nop(add)
  {
    is(0.U){
      io.aluResult := rs1data + muxALUinput
    }
    is(12.U){
      io.branchCheck := (rs1data >= muxALUinput)
    }
  }


  //Outputs ----------------------------------------------------------------------------
  //Control signals:
  io.branchOut := branchIn
  io.memReadOut := memReadIn
  io.memWriteOut := memWriteIn
  io.regWriteOut := regWriteIn
  io.memToRegOut := memToRegIn

  //Data signals:
  io.rdOut := rdIn
  io.rs2DataOut := rs2dataIn
}