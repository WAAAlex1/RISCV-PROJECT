import Import.MemoryMappedUart
import Import.MemoryMappedUart.UartPins
import Import.Bus

import chisel3._


//Toplevel module with UART
class TopLevel extends Module {
  val io = IO(new Bundle {
    //REAL IO:
    val ioLED = UInt(16.W)
    val uart = UartPins()

    //FOR TESTING
    val running = Input(Bool())
    val regFile = Output(Vec(32,SInt(32.W)))
    val wrAddr  = Input(UInt(10.W))
    val wrData  = Input(UInt(32.W))
    val wrEna   = Input(Bool())

  })
  // ------------------------------------------------------------------------------
  //Initialize toplevel io (temp):
  val mmUart = MemoryMappedUart(
    60000000,
    9600,
    txBufferDepth = 16,
    rxBufferDepth = 16
  ) //clockFreq = 60MHz, baud = 9600, bufferDepths = 16

  // ------------------------------------------------------------------------------
  //Connect everything:
  val ifModule = Module(new IFModule) //change to IFModuleTest for hardcoding instructions
  val idModule = Module(new IDModule)
  val exModule = Module(new EXModule)
  val memModule = Module(new MEMModule)
  val forwardingModule = Module(new ForwardingModule)

  val halted = RegInit(false.B)
  halted := halted
  val runningReg = RegInit(false.B) //true.B for hardcoding, false.B for testing
  //runningReg := runningReg //For hardcoding
  runningReg := io.running //For testing
  when(halted){
    runningReg := false.B
  }

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
  idModule.io.ldBraHazard := forwardingModule.io.ldBraHazard
  idModule.io.ecallForward := forwardingModule.io.ecallForward

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
  memModule.io.memControl := exModule.io.memControl.sigBundle

  //Forwarding inputs:
  forwardingModule.io.rdEX := exModule.io.rdOut
  forwardingModule.io.rdMEM := memModule.io.rdOut
  forwardingModule.io.regWriteEX := exModule.io.memControl.sigBundle.regWrite
  forwardingModule.io.regWriteMEM := memModule.io.regWriteOut
  forwardingModule.io.rs1IdxEX := exModule.io.memControl.rs1Idx
  forwardingModule.io.rs2IdxEX := exModule.io.memControl.rs2Idx
  forwardingModule.io.rs1IdxID := idModule.io.exControl.rs1Idx
  forwardingModule.io.rs2IdxID := idModule.io.exControl.rs2Idx
  forwardingModule.io.exHasLoad := exModule.io.memControl.sigBundle.memToReg

  //Connect toplevel IO: (comment out for hardcode)
  ifModule.io.wrAddr := io.wrAddr
  ifModule.io.wrData := io.wrData
  ifModule.io.wrEna  := io.wrEna
  io.regFile := idModule.io.regFile //comment out for hardcode

  ifModule.io.running := runningReg

  when(idModule.io.halt){
    halted := true.B //ecall stop running - COMMENT FOR TESTING(why?)
    idModule.io.instr := "h00000013".U //flush instruction fetched after ecall
  }

  //REAL IO Connections:
  io.ioLED := memModule.io.ioWrite.ioLED
  memModule.io.port <> mmUart.io.port
  io.uart <> mmUart.io.pins
  // ------------------------------------------------------------------------------
}
