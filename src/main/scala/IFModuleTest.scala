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
  val hardCodeInstr = Wire(Vec(17,UInt(32.W)))
  hardCodeInstr(0) := ("h04f000b7".U) //lui x1 0x4f00
  hardCodeInstr(1) := ("h00000013".U) //nop
  hardCodeInstr(2) := ("h00000013".U) //nop
  hardCodeInstr(3) := ("h001001b3".U) //add x3 x0 x1
  hardCodeInstr(4) := ("h00000013".U) //nop
  hardCodeInstr(5) := ("h00000013".U) //nop
  hardCodeInstr(6) := ("hfff08093".U) //addi x1 x1 -1   [<cntdown>]
  hardCodeInstr(7) := ("h00000013".U) //nop
  hardCodeInstr(8) := ("h00000013".U) //nop
  hardCodeInstr(9) := ("hfe009ae3".U) //bne x1 x0 -12 <cntdown>
  hardCodeInstr(10) := ("h00100113".U) //addi x2 x0 1
  hardCodeInstr(11) := ("h00108093".U) //addi x1 x1 1    [<cntup>]
  hardCodeInstr(12) := ("h00000013".U) //nop
  hardCodeInstr(13) := ("h00000013".U) //nop
  hardCodeInstr(14) := ("hfe309ae3".U) //bne x1 x3 -12 <cntup>
  hardCodeInstr(15) := ("h00000113".U) //addi x2 x0 0
  hardCodeInstr(16) := ("hfc000ce3".U) //beq x0 x0 <cntdown>


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