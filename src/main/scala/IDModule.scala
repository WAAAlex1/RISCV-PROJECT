import chisel3._
import chisel3.util._
class IDModule extends Module {
  val io = IO(new Bundle{
    val pcIn          = Input(UInt(32.W))
    val writeRegAddr  = Input(UInt(5.W))
    val regWriteIn    = Input(Bool())
    val writeRegData  = Input(SInt(32.W))
    val instr         = Input(UInt(32.W))

    val rs1data       = Output(SInt(32.W))
    val rs2data       = Output(SInt(32.W))
    val pcOut         = Output(UInt(32.W))
    val rd            = Output(UInt(5.W))
    val aluControl    = Output(UInt(4.W))
    val imm           = Output(SInt(32.W))

    //Control signals?:
    val aluSRC        = Output(Bool())
    val aluOP         = Output(UInt(2.W))
    val branch        = Output(Bool())
    val memRead       = Output(Bool())
    val memWrite      = Output(Bool())
    val regWriteOut   = Output(Bool())
    val memToReg      = Output(Bool())
  })

  //-----------------------------------------------------------------------------

  //Pipeline Registers
  val pcIn = RegNext(io.pcIn)
  val writeRegAddr = RegNext(io.writeRegAddr)
  val regWriteIn = RegNext(io.regWriteIn)
  val writeRegData = RegNext(io.writeRegData)
  val instr = RegNext(io.instr)

  //RegisterFile
  val registerFile = Reg(Vec(32,SInt(32.W)))
  registerFile(0) := 0.S //x0 = 0

  //control signals base-case:
  io.aluOP := 2.U
  io.aluSRC := false.B
  io.branch := false.B
  io.memRead := false.B
  io.memWrite := false.B
  io.regWriteOut := false.B
  io.memToReg := false.B

  // IMM GEN
  //When Extract Opcode - LSB of Opcode always 1 in this set, so we ignore it.
  //When processing J-TYPE - ignore first 2 bits as the least value we increment PC by is 4.
  //(Allows for minimal synthesis of opcode using a single 6-bit LUT)
  io.imm := 0.S //INIT io.imm default value 0
  switch(instr(6,1)) {
    is (25.U) { //R-TYPE (NO IMM)
      //Control signals:
      io.aluOP := 2.U
      io.aluSRC := false.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := false.B
    }
    is (9.U)  { //I-TYPE imm[11:0] / normal imm instructions
      io.imm := ((instr(31,20) ## "hFFFFF".U).asSInt >> 20)
      //Control signals:
      io.aluOP := 2.U
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := false.B
    }
    is (1.U)  { //I-TYPE imm[11:0] / load instructions
      io.imm := (instr(31,20) ## "hFFFFF".U).asSInt >> 20
      //Control signals:
      io.aluOP := 0.U
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := true.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := true.B
    }
    is (57.U) { //I-TYPE imm[11:0]
      io.imm := ( instr(31,20) ## "hFFFFF".U ).asSInt >> 20
    }
    is (51.U) { //I-TYPE imm[11:0]
      io.imm := ( instr(31,20) ## "hFFFFF".U ).asSInt >> 20
    }
    is (17.U) {  //S-TYPE imm[11:5][4:0] / save instruction
      io.imm := ( instr(31,25) ## instr(11,7) ## "hFFFFF".U ).asSInt >> 20
      //Control signals:
      io.aluOP := 0.U
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := true.B
      io.regWriteOut := false.B
      io.memToReg := false.B //dont care
    }
    is (49.U) { //B-TYPE imm[12|10:5][4:1|11] / save instruction
      io.imm := ( instr(31) ## instr(7) ## instr(30,25) ## instr(11,8) ## "hFFFFF".U ).asSInt >> 19
      //Control signals:
      io.aluOP := 1.U
      io.aluSRC := false.B
      io.branch := true.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := false.B
      io.memToReg := false.B //dont care
    }
    is (55.U) { io.imm := ( instr(31) ## instr(19,12) ## instr(20) ## instr(30,22) ## "hFFF1".U ).asSInt >> 11} //J-TYPE
    is (27.U) { io.imm := ( instr | "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12]
    is (11.U) { io.imm := ( instr | "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12]
  }

  //Reg write
  when(regWriteIn){
    registerFile(writeRegAddr) := writeRegData
  }

  //IO
  io.pcOut := pcIn
  io.rs1data := registerFile(instr(19,15))
  io.rs2data := registerFile(instr(24,20))
  io.rd := instr(11,7)
  io.aluControl := instr(30) ## instr(14,12) //bit 30 is used for funct7, the rest is funct3
}