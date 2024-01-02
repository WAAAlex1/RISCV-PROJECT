import chisel3._

class IFModule extends Module {
  val io = IO(new Bundle{
    val PCScr = Input(Bool())
    val BranchAddr = Input(UInt(32.W))
    val Instruction = Output(UInt(32.W))
    val PC = Output(UInt(32.W))

    val wrAddr = Input(UInt(10.W))
    val wrData = Input(UInt(32.W))
    val wrEna = Input(Bool())
  })

  //-----------------------------------------------------------------------------
  //INITIALIZE WIRES AND MODULES
  val pc = RegInit(0.U(32.W))
  val instrMem = Module(new InstrMemModule)
  instrMem.io.wrEna := io.wrEna
  instrMem.io.wrAddr := io.wrAddr
  instrMem.io.wrData := io.wrData

  //USE MEM
  instrMem.io.rdAddr := pc

  //Mux
  pc := Mux(io.PCScr, io.BranchAddr, (pc + 1.U))

  //INITIALIZE Outputs
  io.Instruction := instrMem.io.rdData
  //SHIFT PC 2 (times by 4)
  io.PC := pc
}