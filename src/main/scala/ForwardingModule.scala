import chisel3._
import chisel3.util._
import AluOperations._

class ForwardingModule extends Module{
  val io = IO(new Bundle{
    //Control input
    //Register indexes:
    val rs1IdxID = Input(UInt(5.W))
    val rs1IdxEX = Input(UInt(5.W))
    val rs2IdxID = Input(UInt(5.W))
    val rs2IdxEX = Input(UInt(5.W))

    val rdEX = Input(UInt(5.W))
    val rdMEM = Input(UInt(5.W))

    val regWriteEX = Input(Bool())
    val regWriteMEM = Input(Bool())

    //Control out
    val branchControl1 = Output(UInt(2.W)) // Three options - normal, blue, green, see figure
    val branchControl2 = Output(UInt(2.W)) // Three options - normal, blue, green, see figure
    val aluControl1 = Output(Bool()) // Two options - either load the value from registerfile (normal, 0) or load writeback value from previous instruction (forwarding, 1)
    val aluControl2 = Output(Bool()) // Two options - either load the value from registerfile (normal, 0) or load writeback value from previous instruction (forwarding, 1)
  })

  //Base case (no forwarding):
  io.branchControl1 := 0.U
  io.branchControl2 := 0.U
  io.aluControl1 := false.B
  io.aluControl2 := false.B

  //Decoding:
  //ALU Control signals for forwarding
  //when rd of mem stage is the same as rs1 of ex stage (while we are meant to save the value from mem (regWriteMEM = true)
  //then we should choose the value from mem stage
  when((io.rs1IdxEX === io.rdMEM) & io.regWriteMEM){
    io.aluControl1 := true.B
  }
  //when rd of mem stage is the same as rs2 of ex stage (while we are meant to save the value from mem (regWriteMEM = true)
  //then we should choose the value from mem stage
  when((io.rs2IdxEX === io.rdMEM) & io.regWriteMEM){
    io.aluControl2 := true.B
  }

  //Branch check stuff
  //when we are meant to save the value calculated in EX and rd of EX stage is the same as rs1Idx of the ID stage
  when(io.regWriteEX & (io.rdEX === io.rs1IdxID)){
    io.branchControl1 := 1.U
  }

  //same as before but for rs2Idx of the ID stage
  when(io.regWriteEX & (io.rdEX === io.rs2IdxID)){
    io.branchControl2 := 1.U
  }

  //when we are meant to save the value from MEM and rd of MEM-stage is equal to rs1Idx of the ID stage.
  when(io.regWriteMEM & (io.rdMEM === io.rs1IdxID)){
    io.branchControl1 := 2.U
  }

  //same as previous but for rs2Idx of the ID stage
  when(io.regWriteMEM & (io.rdMEM === io.rs2IdxID)){
    io.branchControl2 := 2.U
  }
}
