import chisel3.{ChiselEnum, _}
import chisel3.util._

object AluOperations extends ChiselEnum {
  val ADD, SUB, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU, JAL, LUI, AUIPC = Value
}

import AluOperations._

//-----------------------------------------------------------------------------

class IDModule extends Module {
  val io = IO(new Bundle{
    val pcIn          = Input(UInt(32.W))
    val writeRegIdx  = Input(UInt(5.W))
    val regWriteIn    = Input(Bool())
    val writeRegData  = Input(SInt(32.W))
    val instr         = Input(UInt(32.W)) //dont regNext because from memory

    val rs1data       = Output(SInt(32.W))
    val rs2data       = Output(SInt(32.W))
    val pcOut         = Output(UInt(32.W))
    val rd            = Output(UInt(5.W))
    val imm           = Output(SInt(32.W))
    val aluOpSelect   = Output(AluOperations())
    val pcSelect      = Output(Bool()) //Control signal for PC adder (true only if JALR)
    val regFile       = Output(Vec(32,SInt(32.W)))

    //Control signals?
    val aluSRC        = Output(Bool())
    val branch        = Output(Bool())
    val memRead       = Output(Bool())
    val memWrite      = Output(Bool())
    val regWriteOut   = Output(Bool())
    val memToReg      = Output(Bool())
    val branchCheck   = Output(Bool())
    val memSize       = Output(UInt(3.W))

    //Temp outputs for testing
    val aluControl = Output(UInt(4.W)) //MSB is used for funct7, the rest is funct3
    val aluOPType = Output(UInt(2.W))
  })

  //-----------------------------------------------------------------------------
  //Pipeline Registers
  val pcIn = RegNext(io.pcIn)

  //RegisterFile
  val registerFile = Reg(Vec(32,SInt(32.W)))
  registerFile(0) := 0.S //x0 = 0
  val rs1data = registerFile(io.instr(19, 15))
  val rs2data = registerFile(io.instr(24, 20))

  //control signals base-case:
  io.aluSRC := false.B
  io.branch := false.B
  io.memRead := false.B
  io.memWrite := false.B
  io.regWriteOut := true.B
  io.memToReg := false.B
  io.pcSelect := false.B
  io.memSize := 0.U

  //ADDED FOR TESTING, REMOVE
  io.aluControl := 0.U
  io.aluOPType := 0.U
  //ALU control stuff
  //Encoding of aluOP:
  //  0 = arithmetic&logic R instructions and imm arithmetic&logic I instructions
  //  1 = Load I instructions and store S instructions
  val aluOPType = WireDefault(0.U(2.W))


  // IMM GEN
  //When Extract Opcode - LSB of Opcode always 1 in this set, so we ignore it.
  //When processing J-TYPE - ignore first 2 bits as the least value we increment PC by is 4.
  //(Allows for minimal synthesis of opcode using a single 6-bit LUT)
  io.imm := 0.S //INIT io.imm default value 0
  switch(io.instr(6,1)) {
    is (25.U) { //R-TYPE 011001 (NO IMM) / Normal add, sub, xor ... instructions
      aluOPType := 0.U //alu control signal

      //Control signals:
      io.aluSRC := false.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := false.B
    }
    is (9.U)  { //I-TYPE imm[11:0] 001001 / normal imm instructions
      io.imm := ((io.instr(31,20) ## "hFFFFF".U).asSInt >> 20)
      aluOPType := 1.U//alu control signal

      //Control signals:
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := false.B
    }
    is (1.U)  { //I-TYPE imm[11:0] 000001 / load instructions
      io.imm := (io.instr(31,20) ## "hFFFFF".U).asSInt >> 20
      aluOPType := 2.U//alu control signal

      //Control signals:
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := true.B
      io.memWrite := false.B
      io.regWriteOut := true.B
      io.memToReg := true.B
    }
    is (57.U) { //I-TYPE imm[11:0] 111001 / ecall / ebreak
      //No ALU control needed in this case
      io.imm := ( io.instr(31,20) ## "hFFFFF".U ).asSInt >> 20
    }
    is (51.U) { //I-TYPE imm[11:0] 110011 / jalr
      //No ALU control needed in this case
      io.imm := ( io.instr(31,20) ## "hFFFFF".U ).asSInt >> 20
      io.pcSelect := true.B //Control signal for PC adder in case of JALR
    }
    is (17.U) {  //S-TYPE imm[11:5][4:0] 010001 / save instruction
      io.imm := ( io.instr(31,25) ## io.instr(11,7) ## "hFFFFF".U ).asSInt >> 20
      aluOPType := 2.U//alu control signal

      //Control signals:
      io.aluSRC := true.B
      io.branch := false.B
      io.memRead := false.B
      io.memWrite := true.B
      io.regWriteOut := false.B
      io.memToReg := false.B //dont care
    }
    is (49.U) { //B-TYPE imm[12|10:5][4:1|11] 110001 / branch instruction
      io.imm := ( io.instr(31) ## io.instr(7) ## io.instr(30,25) ## io.instr(11,8) ## "hFFFFF".U ).asSInt >> 19

      //Control signals:
      io.aluSRC := false.B
      io.branch := true.B
      io.memRead := false.B
      io.memWrite := false.B
      io.regWriteOut := false.B
      io.memToReg := false.B //dont care
    }
    is (55.U) { //J-TYPE jal
      io.imm := ( io.instr(31) ## io.instr(19,12) ## io.instr(20) ## io.instr(30,22) ## "hFFF1".U ).asSInt >> 11
    }
    is (27.U) { io.imm := ( io.instr & "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12] 011011 / lui
    is (11.U) { io.imm := ( io.instr & "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12] 001011 / auipc
  }

  //ALU control
  io.aluOpSelect := ADD
  switch(aluOPType){
    is(0.U){ //normal arithmetic&logic R
      switch(io.instr(30) ## io.instr(14,12)){ //switch on 6th bit of funct7 and funct3
        is("b0000".U){io.aluOpSelect := ADD}
        is("b1000".U){io.aluOpSelect := SUB}
        is("b0100".U){io.aluOpSelect := XOR}
        is("b0110".U){io.aluOpSelect := OR }
        is("b0111".U){io.aluOpSelect := AND}
        is("b0001".U){io.aluOpSelect := SLL}
        is("b0101".U){io.aluOpSelect := SRL}
        is("b1101".U){io.aluOpSelect := SRA}
        is("b0010".U){io.aluOpSelect := SLT}
        is("b0011".U){io.aluOpSelect := SLTU}
      }
    }
    is(1.U){ //I-Instructions arithmetic&logic
      switch(io.instr(14,12)){ //switch on funct3
        is("b000".U){io.aluOpSelect := ADD}
        is("b100".U){io.aluOpSelect := XOR}
        is("b110".U){io.aluOpSelect := OR }
        is("b111".U){io.aluOpSelect := AND}
        is("b001".U){io.aluOpSelect := Mux(io.imm(11,5) === "b0000000".U, SLL, ADD)}//false=error
        is("b101".U){io.aluOpSelect := Mux(io.imm(11,5) === "b0000000".U, SRL, Mux(io.imm(11,5)==="b0100000".U, SRA, ADD))} //false=error
        is("b010".U){io.aluOpSelect := SLT}
        is("b011".U){io.aluOpSelect := SLTU}
      }
    }
    is(2.U){ //LOAD AND STORE Instructions
      io.aluOpSelect := ADD
      io.memSize := io.instr(14,12) //decides if mem takes byte, halfword or word
    }
  }
  //Special cases - found easiest from opcode
  switch(io.instr(6,1)){
    is("b110111".U){io.aluOpSelect := JAL}
    is("b110011".U){io.aluOpSelect := JAL}
    is("b011011".U){io.aluOpSelect := LUI}
    is("b001011".U){io.aluOpSelect := AUIPC}
  }

  //BranchCheck logic. (this just assumes branch and checks for the conditions)
  io.branchCheck := false.B
  switch(io.instr(14,12))
  {
    is(0.U){ //beq
      io.branchCheck := (rs1data === rs2data)
    }
    is(1.U){
      io.branchCheck := (rs1data =/= rs2data)
    }
    is(4.U){
      io.branchCheck := (rs1data < rs2data)
    }
    is(5.U){
      io.branchCheck := (rs1data >= rs2data)
    }
    is(6.U){
      io.branchCheck := (rs1data.asUInt < rs2data.asUInt)
    }
    is(7.U){
      io.branchCheck := (rs1data.asUInt >= rs2data.asUInt)
    }
  }

  //Reg write
  when(io.regWriteIn){
    registerFile(io.writeRegIdx) := io.writeRegData
  }

  //IO
  io.pcOut := pcIn
  io.rs1data := rs1data
  io.rs2data := rs2data
  io.rd := io.instr(11,7)
  io.regFile := registerFile

  //ADDED FOR TESTING, REMOVE
  io.aluControl := io.instr(30) ## io.instr(14,12)
  io.aluOPType := aluOPType
}