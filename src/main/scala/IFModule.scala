import chisel3._

class IFModule extends Module {
  val io = IO(new Bundle{
    val pcSrc         = Input(Bool())
    val branchAddr    = Input(UInt(32.W))

    val instruction   = Output(UInt(32.W))
    val pc            = Output(UInt(32.W))

    //Signals for writing to instr-mem, currently only used in tests to fill the instr-mem
    val wrAddr        = Input(UInt(10.W))
    val wrData        = Input(UInt(32.W))
    val wrEna         = Input(Bool())

  })

  //-----------------------------------------------------------------------------
  //INITIALIZE WIRES AND MODULES
  val pc = RegInit(0.U(32.W))
  val instrMem = Module(new Memory(1024,32))
  instrMem.io.wrEna := io.wrEna
  instrMem.io.wrAddr := io.wrAddr
  instrMem.io.wrData := io.wrData

  //adder wire
  val pcAdded = WireDefault(0.U(32.W))
  pcAdded := pc + 1.U

  //Mux
  val pcMux = WireDefault(0.U(32.W))
  pcMux := Mux(io.pcSrc, io.branchAddr >> 2, pcAdded) //Divide branchaddr by 4 because 4 times too big
  pc := pcMux

  //USE MEM
  instrMem.io.rdAddr := pcMux

  //INITIALIZE Outputs
  io.instruction := Mux(io.pcSrc,"h00000013".U,instrMem.io.rdData) //flush if branch is decoded (normal line)

  //SHIFT PC 2 (time it by 4)
  io.pc := pc << 2
}