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

  /*hardcode for testing : test = bool.s
  val hardCodeInstr = Wire(Vec(16,UInt(32.W)))
  hardCodeInstr(0) := ("h123452b7".U) //lui t0 x12345
  hardCodeInstr(1) := ("h00000013".U) //nop
  hardCodeInstr(2) := ("h00000013".U) //nop
  hardCodeInstr(3) := ("h67828293".U) //addi x5 x5 1656
  hardCodeInstr(4) := ("habcdf337".U) //lui x6 0xabcdf
  hardCodeInstr(5) := ("h00000013".U) //nop
  hardCodeInstr(6) := ("h00000013".U) //nop
  hardCodeInstr(7) := ("hfab30313".U) //addi x6 x6 -85
  hardCodeInstr(8) := ("h00000013".U) //nop
  hardCodeInstr(9) := ("h00000013".U) //nop
  hardCodeInstr(10) := ("h0062c5b3".U) //xor x11 x5 x6
  hardCodeInstr(11) := ("h0062e633".U) //or x12 x5 x6
  hardCodeInstr(12) := ("h0062f6b3".U) //and x13 x5 x6
  hardCodeInstr(13) := ("h5212c713".U) //xori x14 x5 1313
  hardCodeInstr(14) := ("h5212e793".U) //ori x15 x5 1313
  hardCodeInstr(15) := ("h5212f813".U) //andi x16 x5 1313
  */

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
  //io.instruction := instrMem.io.rdData //no need to flush?
  io.instruction := Mux(io.pcSrc,"h00000013".U,instrMem.io.rdData) //flush if branch is decoded

  //SHIFT PC 2 (time it by 4)
  io.pc := pc << 2
}