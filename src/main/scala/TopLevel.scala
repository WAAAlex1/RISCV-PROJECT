import chisel3._


class TopLevel extends Module {
  val io = IO(new Bundle {
    val tx = Output(Bool())

    //Instruction mem filling stuff:

    val wrAddr  = Input(UInt(10.W)) //comment out for hardcode
    val wrData  = Input(UInt(32.W)) //comment out for hardcode
    val wrEna   = Input(Bool()) //comment out for hardcode

    val regFile = Output(Vec(32,SInt(32.W))) //comment out for hardcode testing
    //val regFile2bit1 = Output(Bool()) //for hardcoding
    val pc      = Output(UInt(32.W)) //comment out for hardcode testing
  })
  // ------------------------------------------------------------------------------
  // Clk

  //Initialize toplevel io (temp):
  io.tx := false.B


  // ------------------------------------------------------------------------------
  //Connect everything:
  val ifModule = Module(new IFModule) //change to IFModuleTest for hardcoding
  val idModule = Module(new IDModule)
  val exModule = Module(new EXModule)
  val memModule = Module(new MEMModule)
  val forwardingModule = Module(new ForwardingModule)

  //IF inputs:
  ifModule.io.pcSrc := idModule.io.pcSrc
  ifModule.io.branchAddr := idModule.io.branchAddr

  //ID inputs:
  idModule.io.pcIn := ifModule.io.pc
  idModule.io.writeRegIdx := memModule.io.rdOut
  idModule.io.regWriteIn := memModule.io.regWriteOut
  idModule.io.writeRegData := memModule.io.regWriteData
  idModule.io.instr := ifModule.io.instruction
  idModule.io.resEX := exModule.io.aluResult
  idModule.io.resMEM := memModule.io.regWriteData
  idModule.io.forward1 := forwardingModule.io.branchControl1
  idModule.io.forward2 := forwardingModule.io.branchControl2

  //EX inputs:
  exModule.io.rs1data := idModule.io.rs1data
  exModule.io.rs2dataIn := idModule.io.rs2data
  exModule.io.pc := idModule.io.pcOut
  exModule.io.rdIn := idModule.io.rd
  exModule.io.imm := idModule.io.imm
  exModule.io.exControl := idModule.io.exControl
  exModule.io.resMEM := memModule.io.regWriteData //for forwarding
  exModule.io.forward1 := forwardingModule.io.aluControl1
  exModule.io.forward2 := forwardingModule.io.aluControl2

  //MEM inputs:
  memModule.io.aluResult := exModule.io.aluResult
  memModule.io.rs2Data := exModule.io.rs2DataOut
  memModule.io.rdIn := exModule.io.rdOut
  memModule.io.memControl := exModule.io.memControl

  //Forwarding inputs:
  forwardingModule.io.rdEX := exModule.io.rdOut
  forwardingModule.io.rdMEM := memModule.io.rdOut
  forwardingModule.io.regWriteEX := exModule.io.exControl.sigBundle.regWrite
  forwardingModule.io.regWriteMEM := memModule.io.memControl.regWrite
  forwardingModule.io.rs1IdxEX := exModule.io.exControl.rs1Idx
  forwardingModule.io.rs2IdxEX := exModule.io.exControl.rs2Idx
  forwardingModule.io.rs1IdxID := idModule.io.exControl.rs1Idx
  forwardingModule.io.rs2IdxID := idModule.io.exControl.rs2Idx

  //Connect toplevel IO: (comment out for hardcode)
  ifModule.io.wrAddr := io.wrAddr
  ifModule.io.wrData := io.wrData
  ifModule.io.wrEna  := io.wrEna


  io.regFile := idModule.io.regFile //comment out for hardcode
  //io.regFile2bit1 := idModule.io.regFile(2)(0) //for hardcoding
  io.pc := ifModule.io.pc //comment out for hardcoding

  // ------------------------------------------------------------------------------
}

object TopLevel extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TopLevel)
}