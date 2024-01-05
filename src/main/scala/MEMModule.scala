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

    //Out
    val regWriteOut  = Output(Bool())

  })

  //Registers on the inputs that dont go through memory:
  val aluResult = RegNext(io.aluResult) //Both through memory AND past it in parallel
  val rdIn = RegNext(io.rdIn)
  val branchCheck = RegNext(io.branchCheck)
  val branch = RegNext(io.branch)
  val regWriteIn = RegNext(io.regWriteIn) //
  val memToReg = RegNext(io.memToReg)
  val branchAddrIn = RegNext(io.branchAddrIn)

  //pcSrc:
  io.pcSrc := (branch & branchCheck)

  //On chip memory:
  val memory = Module(new Memory(1024,8))
  memory.io.rdAddr := io.aluResult //connect to non-regnext'ed aluresult
  memory.io.wrAddr := io.aluResult //connect to non-regnext'ed aluresult
  memory.io.wrData := io.rs2Data //non-regnext'ed ?? idk which one, maybe should be good
  memory.io.wrEna := io.memWrite
  val memOutput = WireDefault(0.S(32.W))
  memOutput := memory.io.rdData

  //Write back:
  io.regWriteData := Mux(memToReg,memOutput,aluResult) //regnext'ed aluresult

  //Other outputs:
  io.rdOut := rdIn
  io.regWriteOut := regWriteIn
  io.branchAddrOut := branchAddrIn
}
