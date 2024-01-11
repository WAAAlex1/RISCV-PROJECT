import chisel3._

class IFModuleTest extends Module {
  val io = IO(new Bundle{
    val pcSrc         = Input(Bool())
    val branchAddr    = Input(UInt(32.W))

    val instruction   = Output(UInt(32.W))
    val pc            = Output(UInt(32.W))

    //Signals for writing to instr-mem, currently only used in tests to fill the instr-mem
  })

  //-----------------------------------------------------------------------------
  //INITIALIZE WIRES AND MODULES
  val pc = RegInit(0.U(32.W))

  //hardcode for testing : test = blinking led
  val hardCodeInstr = Wire(Vec(11,UInt(32.W)))
  hardCodeInstr(0) := ("h04f000b7".U) //lui x1 0x4f00
  hardCodeInstr(1) := ("h001001b3".U) //add x3 x0 x1
  hardCodeInstr(2) := ("hfff08093".U) //addi x1 x1 -1           [<cntdown>]
  hardCodeInstr(3) := ("hfe009ee3".U) //bne x1 x0 -4 <cntdown>
  hardCodeInstr(4) := ("h00100113".U) //addi x2 x0 1
  hardCodeInstr(5) := ("h40202023".U) //sw x2 1024 x0
  hardCodeInstr(6) := ("h00108093".U) //addi x1 x1 1            [<cntup>]
  hardCodeInstr(7) := ("hfe309ee3".U) //bne x1 x3 -4  <cntup>
  hardCodeInstr(8) := ("h00000113".U) //addi x2 x0 0
  hardCodeInstr(9) := ("h40202023".U) //sw x2 1024 x0
  hardCodeInstr(10) := ("hfe0000e3".U) //beq x0 x0 -32 <cntdown>


  //adder wire
  val pcAdded = WireDefault(0.U(32.W))
  pcAdded := pc + 1.U

  //Mux
  val pcMux = WireDefault(0.U(32.W))
  pcMux := Mux(io.pcSrc, io.branchAddr >> 2, pcAdded) //Divide branchaddr by 4 because 4 times too big
  pc := pcMux

  //INITIALIZE Outputs
  io.instruction :=  Mux(io.pcSrc,"h00000013".U,hardCodeInstr(pc)) //for hardcode testing


  //SHIFT PC 2 (time it by 4)
  io.pc := pc << 2
}