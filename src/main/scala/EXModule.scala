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

    //Out
    val aluResult   = Output(SInt(32.W))
    val rs2DataOut  = Output(SInt(32.W))
    val rdOut       = Output(UInt(5.W))

    //Control signals:
    //In
    val exControl = Input(new EXBundle)

    //Out
    //Replace with Bundle:
    val memControl = Output(new MEMBundle)
  })

  // Pipeline Registers: --------------------------------------------------------
  // For data Signals
  val rs1data     = RegNext(io.rs1data)
  val rs2dataIn   = RegNext(io.rs2dataIn)
  val pc          = RegNext(io.pc)
  val rdIn        = RegNext(io.rdIn)
  val imm         = RegNext(io.imm)

  //for control signals
  val exControl = RegNext(io.exControl) //This does indeed also regnext the inner sigbundle
  // Logic ----------------------------------------------------------------------------

  //Mux on ALU second input
  val muxALUinput = WireDefault(0.S(32.W))
  muxALUinput := Mux(exControl.aluSRC,imm,rs2dataIn)

  //ALU
  io.aluResult := 0.S
  switch(exControl.aluOpSelect) //enum
  {
    is(ADD){io.aluResult := rs1data + muxALUinput}
    is(SUB){io.aluResult := rs1data - muxALUinput}
    is(XOR){io.aluResult := rs1data ^ muxALUinput}
    is(OR) {io.aluResult := rs1data | muxALUinput}
    is(AND){io.aluResult := rs1data & muxALUinput}
    is(SLL){io.aluResult := rs1data << ((muxALUinput.asUInt)(4,0))} //fixed here
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
    is(LUI){io.aluResult := imm}
    is(AUIPC){io.aluResult := (pc.asSInt + imm)}
  }

  //Outputs ----------------------------------------------------------------------------
  //Control signals:
  io.memControl := exControl.sigBundle

  //Data signals:
  io.rdOut := rdIn
  io.rs2DataOut := rs2dataIn
}