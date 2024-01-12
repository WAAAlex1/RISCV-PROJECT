import chisel3.{ChiselEnum, _}
import chisel3.util._

object AluOperations extends ChiselEnum {
  val ADD, SUB, XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU, JAL, LUI, AUIPC = Value
}

import AluOperations._

//-----------------------------------------------------------------------------

class IDModule extends Module {
  val io = IO(new Bundle{
    //Data in
    val pcIn          = Input(UInt(32.W))
    val writeRegIdx  = Input(UInt(5.W))
    val regWriteIn    = Input(Bool())
    val writeRegData  = Input(SInt(32.W))
    val instr         = Input(UInt(32.W))

    //Data Out
    val rs1data       = Output(SInt(32.W))
    val rs2data       = Output(SInt(32.W))
    val pcOut         = Output(UInt(32.W))
    val rd            = Output(UInt(5.W))
    val imm           = Output(SInt(32.W))
    val regFile       = Output(Vec(32,SInt(32.W)))
    val branchAddr    = Output(UInt(32.W))
    val pcSrc         = Output(Bool())

    //Forwarding signals in:
    val resEX = Input(SInt(32.W))
    val resMEM = Input(SInt(32.W))
    val forward1 = Input(UInt(2.W))
    val forward2 = Input(UInt(2.W))

    //Control signals Out
    val exControl = Output(new EXBundle)

    //Temp outputs for testing
    val aluControl = Output(UInt(4.W)) //MSB is used for funct7, the rest is funct3
    val aluOPType = Output(UInt(2.W))
  })

  //-----------------------------------------------------------------------------
  //Pipeline Registers
  val pcIn = RegNext(io.pcIn)
  val instr = RegNext(io.instr)

  //RegisterFile
  val registerFile = RegInit(VecInit(Seq.fill(32)(0.S(32.W)))) //reset to nop instructions
  val rs1data = Mux(io.forward1(0),io.resEX,Mux(io.forward1(1),io.resMEM,registerFile(instr(19, 15)))) //forwarding
  val rs2data = Mux(io.forward2(0),io.resEX,Mux(io.forward2(1),io.resMEM,registerFile(instr(24, 20)))) //forwarding
  io.exControl.rs1Idx := instr(19, 15)
  io.exControl.rs2Idx := instr(24, 20)

  //BranchCheck logic. (this just assumes branch and checks for the conditions)
  val branchCheck = WireDefault(false.B)
  switch(instr(14,12))
  {
    is(0.U){ //beq
      branchCheck := (rs1data === rs2data)
    }
    is(1.U){ //bne
      branchCheck := (rs1data =/= rs2data)
    }
    is(4.U){ //blt
      branchCheck := (rs1data < rs2data)
    }
    is(5.U){ //bge
      branchCheck := (rs1data >= rs2data)
    }
    is(6.U){ //bltu
      branchCheck := (rs1data.asUInt < rs2data.asUInt)
    }
    is(7.U){ //bgeu
      branchCheck := (rs1data.asUInt >= rs2data.asUInt)
    }
  }


  //control signals base-case:
  val branch = WireDefault(false.B)
  val pcSelect = WireDefault(false.B) //Control signal for PC adder (true only if JALR)
  io.exControl.aluSRC := false.B
  io.exControl.sigBundle.memWrite := false.B
  io.exControl.sigBundle.regWrite := true.B
  io.exControl.sigBundle.memToReg := false.B
  io.exControl.sigBundle.memSize := 2.U //word

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
  switch(instr(6,1)) {
    is (25.U) { //R-TYPE 011001 (NO IMM) / Normal add, sub, xor ... instructions
      aluOPType := 0.U //alu control signal

      //Control signals:
      io.exControl.aluSRC := false.B
      branch := false.B
      io.exControl.sigBundle.memWrite := false.B
      io.exControl.sigBundle.regWrite := true.B
      io.exControl.sigBundle.memToReg := false.B
    }
    is (9.U)  { //I-TYPE imm[11:0] 001001 / normal imm instructions
      io.imm := ((instr(31,20) ## "hFFFFF".U).asSInt >> 20)
      aluOPType := 1.U//alu control signal

      //Control signals:
      io.exControl.aluSRC := true.B
      branch := false.B
      io.exControl.sigBundle.memWrite := false.B
      io.exControl.sigBundle.regWrite := true.B
      io.exControl.sigBundle.memToReg := false.B
    }
    is (1.U)  { //I-TYPE imm[11:0] 000001 / load instructions
      io.imm := (instr(31,20) ## "hFFFFF".U).asSInt >> 20
      aluOPType := 2.U//alu control signal

      //Control signals:
      io.exControl.aluSRC := true.B
      branch := false.B
      io.exControl.sigBundle.memWrite := false.B
      io.exControl.sigBundle.regWrite := true.B
      io.exControl.sigBundle.memToReg := true.B
    }
    is (57.U) { //I-TYPE imm[11:0] 111001 / ecall / ebreak
      //No ALU control needed in this case
      io.imm := ( instr(31,20) ## "hFFFFF".U ).asSInt >> 20
    }
    is (51.U) { //I-TYPE imm[11:0] 110011 / jalr
      //No ALU control needed in this case
      io.imm := ( instr(31,20) ## "hFFFFF".U ).asSInt >> 20
      pcSelect := true.B //Control signal for PC adder in case of JALR
      branchCheck := true.B //yes we branching
      branch := true.B //yes we branching
    }
    is (17.U) {  //S-TYPE imm[11:5][4:0] 010001 / save instruction
      io.imm := ( instr(31,25) ## instr(11,7) ## "hFFFFF".U ).asSInt >> 20
      aluOPType := 2.U//alu control signal

      //Control signals:
      io.exControl.aluSRC := true.B
      branch := false.B
      io.exControl.sigBundle.memWrite := true.B
      io.exControl.sigBundle.regWrite := false.B
      io.exControl.sigBundle.memToReg := false.B //dont care
    }
    is (49.U) { //B-TYPE imm[12|10:5][4:1|11] 110001 / branch instruction
      io.imm := ( instr(31) ## instr(7) ## instr(30,25) ## instr(11,8) ## "hFFFFF".U ).asSInt >> 19

      //Control signals:
      io.exControl.aluSRC := false.B
      branch := true.B
      io.exControl.sigBundle.memWrite := false.B
      io.exControl.sigBundle.regWrite := false.B
      io.exControl.sigBundle.memToReg := false.B //dont care
    }
    is (55.U) { //J-TYPE jal
      io.imm := ( instr(31) ## instr(19,12) ## instr(20) ## instr(30,21) ## "b0".U ).asSInt
      branchCheck := true.B //always branching
      branch := true.B //always branching
    }
    is (27.U) { io.imm := ( instr & "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12] 011011 / lui
    is (11.U) { io.imm := ( instr & "hFFFFF000".U ).asSInt } //U-TYPE imm[31:12] 001011 / auipc
  }

  //ALU control
  io.exControl.aluOpSelect := ADD
  switch(aluOPType){
    is(0.U){ //normal arithmetic&logic R
      switch(instr(30) ## instr(14,12)){ //switch on 6th bit of funct7 and funct3
        is("b0000".U){io.exControl.aluOpSelect := ADD}
        is("b1000".U){io.exControl.aluOpSelect := SUB}
        is("b0100".U){io.exControl.aluOpSelect := XOR}
        is("b0110".U){io.exControl.aluOpSelect := OR }
        is("b0111".U){io.exControl.aluOpSelect := AND}
        is("b0001".U){io.exControl.aluOpSelect := SLL}
        is("b0101".U){io.exControl.aluOpSelect := SRL}
        is("b1101".U){io.exControl.aluOpSelect := SRA}
        is("b0010".U){io.exControl.aluOpSelect := SLT}
        is("b0011".U){io.exControl.aluOpSelect := SLTU}
      }
    }
    is(1.U){ //I-Instructions arithmetic&logic
      switch(instr(14,12)){ //switch on funct3
        is("b000".U){io.exControl.aluOpSelect := ADD}
        is("b100".U){io.exControl.aluOpSelect := XOR}
        is("b110".U){io.exControl.aluOpSelect := OR }
        is("b111".U){io.exControl.aluOpSelect := AND}
        is("b001".U){io.exControl.aluOpSelect := Mux(io.imm(11,5) === "b0000000".U, SLL, ADD)}//false=error
        is("b101".U){io.exControl.aluOpSelect := Mux(io.imm(11,5) === "b0000000".U, SRL, Mux(io.imm(11,5)==="b0100000".U, SRA, ADD))} //false=error
        is("b010".U){io.exControl.aluOpSelect := SLT}
        is("b011".U){io.exControl.aluOpSelect := SLTU}
      }
    }
    is(2.U){ //LOAD AND STORE Instructions
      io.exControl.aluOpSelect := ADD
      io.exControl.sigBundle.memSize := instr(14,12) //decides if mem takes byte, halfword or word
      //memSize: 0=Byte, 1=Halfword, 2=Word, 4=ByteUnsigned, 5=halfwordUnsigned
    }
  }
  //Special cases - found easiest from opcode
  switch(instr(6,1)){
    is("b110111".U){io.exControl.aluOpSelect := JAL}
    is("b110011".U){io.exControl.aluOpSelect := JAL}
    is("b011011".U){io.exControl.aluOpSelect := LUI}
    is("b001011".U){io.exControl.aluOpSelect := AUIPC}
  }

  //Reg write
  when(io.regWriteIn){
    registerFile(io.writeRegIdx) := io.writeRegData
  }

  //AddSum (Calculate branch address)
  io.branchAddr := Mux(pcSelect, rs1data + io.imm, pcIn.asSInt + io.imm).asUInt

  //pcSrc:
  io.pcSrc := (branch & branchCheck)

  //IO
  io.pcOut := pcIn
  io.rs1data := rs1data
  io.rs2data := rs2data
  io.rd := instr(11,7)

  registerFile(0) := 0.S //x0 = 0
  io.regFile := registerFile

  //ADDED FOR TESTING, REMOVE
  io.aluControl := instr(30) ## instr(14,12)
  io.aluOPType := aluOPType
}