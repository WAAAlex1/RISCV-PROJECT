import chisel3._

class TopLevel extends Module {
  val io = IO(new Bundle {
    val tx = Output(Bool())

    //Instruction mem filling stuff:
    val wrAddr  = Input(UInt(10.W))
    val wrData  = Input(UInt(32.W))
    val wrEna   = Input(Bool())

    val regFile = Output(Vec(32,SInt(32.W)))
    val pc      = Output(UInt(32.W))
  })
  // ------------------------------------------------------------------------------
  // Clk

  //Initialize toplevel io (temp):
  io.tx := false.B


  // ------------------------------------------------------------------------------
  //Connect everything:
  val ifModule = Module(new IFModule)
  val idModule = Module(new IDModule)
  val exModule = Module(new EXModule)
  val memModule = Module(new MEMModule)

  //IF inputs:
  ifModule.io.pcSrc := memModule.io.pcSrc
  ifModule.io.branchAddr := memModule.io.branchAddrOut

  //ID inputs:
  idModule.io.pcIn := ifModule.io.pc
  idModule.io.writeRegIdx := memModule.io.rdOut
  idModule.io.regWriteIn := memModule.io.regWriteOut
  idModule.io.writeRegData := memModule.io.regWriteData
  idModule.io.instr := ifModule.io.instruction

  //EX inputs:
  exModule.io.rs1data := idModule.io.rs1data
  exModule.io.rs2dataIn := idModule.io.rs2data
  exModule.io.pc := idModule.io.pcOut
  exModule.io.rdIn := idModule.io.rd
  exModule.io.imm := idModule.io.imm
  exModule.io.aluOpSelect := idModule.io.aluOpSelect
  exModule.io.pcSelect := idModule.io.pcSelect
  exModule.io.aluSRC := idModule.io.aluSRC
  exModule.io.branchIn := idModule.io.branch
  exModule.io.memReadIn := idModule.io.memRead
  exModule.io.memWriteIn := idModule.io.memWrite
  exModule.io.regWriteIn := idModule.io.regWriteOut
  exModule.io.memToRegIn := idModule.io.memToReg
  exModule.io.branchCheckIn := idModule.io.branchCheck
  exModule.io.memSizeIn := idModule.io.memSize

  //MEM inputs:
  memModule.io.branchAddrIn := exModule.io.branchAddr
  memModule.io.aluResult := exModule.io.aluResult
  memModule.io.rs2Data := exModule.io.rs2DataOut
  memModule.io.rdIn := exModule.io.rdOut
  memModule.io.branch := exModule.io.branchOut
  memModule.io.memRead := exModule.io.memReadOut
  memModule.io.memWrite := exModule.io.memWriteOut
  memModule.io.regWriteIn := exModule.io.regWriteOut
  memModule.io.memToReg := exModule.io.memToRegOut
  memModule.io.branchCheck := exModule.io.branchCheckOut
  memModule.io.memSize := exModule.io.memSizeOut


  //Connect toplevel IO:
  ifModule.io.wrAddr := io.wrAddr
  ifModule.io.wrData := io.wrData
  ifModule.io.wrEna  := io.wrEna

  io.regFile := idModule.io.regFile
  io.pc      := ifModule.io.pc //for debugging

  // ------------------------------------------------------------------------------
}

object TopLevel extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TopLevel)
}