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
  })
  // ------------------------------------------------------------------------------
  //Initialize toplevel io (temp):
  val mmUart = MemoryMappedUart(
    100000000,
    115200,
    txBufferDepth = 8,
    rxBufferDepth = 8
  ) //clockFreq = 100MHz, baud = 115200, bufferDepths = 8?

  // ------------------------------------------------------------------------------
  //Connect everything:
  val ifModule = Module(new IFModule) //change to IFModuleTest for hardcoding
  val idModule = Module(new IDModule)
  val exModule = Module(new EXModule)
  val memModule = Module(new MEMModule)
  val forwardingModule = Module(new ForwardingModule)
  val serialPort = Module(new SerialPort)

  val runningReg = RegInit(false.B)
  val wrAddr = WireDefault(0.U(10.W))
  val wrData  = WireDefault(0.U(32.W))
  val wrEna   = WireDefault(false.B)

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

  //Connect toplevel IO: (comment out for hardcode)

  ifModule.io.wrAddr := wrAddr
  ifModule.io.wrData := wrData
  ifModule.io.wrEna  := wrEna
  ifModule.io.running := runningReg

  //Serial Port connections:
  val instrAddrReg = RegInit(0.U(10.W))
  instrAddrReg := Mux(serialPort.io.instrValid,instrAddrReg + 1.U,instrAddrReg)
  serialPort.io.running := runningReg //running should start false
  when(serialPort.io.readyToRun){
    runningReg := true.B
  } .elsewhen(idModule.io.halt){
    runningReg := false.B //ecall stop running
    idModule.io.instr := "h00000013".U //flush instruction fetched after ecall
  }
  wrEna := serialPort.io.instrValid
  wrData := serialPort.io.instr
  wrAddr := instrAddrReg
  serialPort.io.wrEna := memModule.io.ioWrite.wrEna
  serialPort.io.wrData := memModule.io.ioWrite.wrData

  //REAL IO Connections:
  io.ioLED := memModule.io.ioWrite.ioLED
  serialPort.io.port <> mmUart.io.port
  io.uart <> mmUart.io.pins
  // ------------------------------------------------------------------------------
}

object TopLevel extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TopLevel)
}