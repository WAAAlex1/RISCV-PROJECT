import chisel3._

class IFModule {
  val io = IO(new Bundle{
    val PCScr = Input(Bool())
    val BranchAddr = Input(UInt(32.W))
    val Instruction = Output(UInt(32.W))
    val PC = Output(UInt(32.W))
  })

  //-----------------------------------------------------------------------------
  //INITIALIZE WIRES AND MODULES
  val pc = WireDefault(0.U(32.W))
  val instrMem = Module(new InstrMemModule)

  //USE MEM
  instrMem.io.rdAddr := pc

  //Mux
  pc := Mux(io.PCScr, io.BranchAddr, (pc + 4.U))

  //INITIALIZE Outputs
  io.Instruction := instrMem.io.rdData
  io.PC := pc

}