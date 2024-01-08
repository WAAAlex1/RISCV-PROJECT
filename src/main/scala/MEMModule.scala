import chisel3._
import chisel3.util._

class MEMModule extends Module {
  val io = IO(new Bundle {
    //Data in
    val branchAddrIn = Input(UInt(32.W))
    val aluResult    = Input(SInt(32.W))
    val rs2Data      = Input(SInt(32.W))
    val rdIn         = Input(UInt(5.W))

    //Data out
    val regWriteData = Output(SInt(32.W))
    val rdOut        = Output(UInt(5.W))
    val branchAddrOut = Output(UInt(32.W))
    val pcSrc        = Output(Bool())

    //Control signals:
    //In
    val branch       = Input(Bool())
    val memRead      = Input(Bool()) //maybe not needed?
    val memWrite     = Input(Bool())
    val regWriteIn   = Input(Bool())
    val memToReg     = Input(Bool())
    val branchCheck  = Input(Bool())
    val memSize      = Input(UInt(3.W))
    */
    //Replace with Bundle:
    val memControl = Input(new MEMBundle)

    //Out
    val regWriteOut  = Output(Bool())

  })

  //Registers on the inputs that dont go through memory:
  val rdIn = RegNext(io.rdIn)
  val aluResult = RegNext(io.aluResult) //Both through memory AND past it in parallel
  val regWrite = RegNext(io.memControl.regWrite) //
  val memToReg = RegNext(io.memControl.memToReg)
  val memSize = RegNext(io.memControl.memSize) //Regnext because its needed after memory is done fetching

  //On chip memory:
  val memory = Module(new Memory(1024,8))
  memory.io.rdAddr := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrAddr := io.aluResult.asUInt //connect to non-regnext'ed aluresult
  memory.io.wrData := io.rs2Data.asUInt(7,0) //non-regnext'ed ?? idk which one, maybe should be good
  memory.io.wrEna := io.memWrite
  val memOutput = WireDefault(0.S(32.W))
  memOutput := memory.io.rdData.asSInt

  //Write back:
  io.regWriteData := Mux(memToReg,memOutput,aluResult) //regnext'ed aluresult

  //Other outputs:
  io.rdOut := rdIn
  io.regWriteOut := regWrite
}
