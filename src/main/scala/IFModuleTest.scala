import chisel3._

class IFModuleTest extends Module {
  val io = IO(new Bundle{
    val pcSrc         = Input(Bool())
    val branchAddr    = Input(UInt(32.W))

    val instruction   = Output(UInt(32.W))
    val pc            = Output(UInt(32.W))

    //Control signal for program execution:
    val running = Input(Bool())
  })

  //-----------------------------------------------------------------------------
  //INITIALIZE WIRES AND MODULES
  val pc = RegInit(0.U(32.W))

  //hardcode for printing fibo num to uart
  /*
  val hardCodeInstr = Wire(Vec(16,UInt(32.W)))
  //[<main>]
  hardCodeInstr(0) := ("h00100193".U) //addi x3 x0 1
  hardCodeInstr(1) := ("h00000113".U) //addi x2 x0 0
  hardCodeInstr(2) := ("h00500293".U) //addi x5 x0 5         [<cntdown>]
  hardCodeInstr(3) := ("h028003ef".U) //jal x7 40 <printNum>
  hardCodeInstr(4) := ("h00c000ef".U) //jal x1 12 <fibo>
  hardCodeInstr(5) := ("h00a00893".U) //addi x17 x0 10
  hardCodeInstr(6) := ("h00000073".U) //ecall
  //[<fibo>]
  hardCodeInstr(7) := ("h00218133".U) //add x2 x3 x2
  hardCodeInstr(8) := ("h003101b3".U) //add x3 x2 x3
  hardCodeInstr(9) := ("h010003ef".U) //jal x7 16 <printNum>
  hardCodeInstr(10) := ("h00120213".U) //addi x4 x4 1
  hardCodeInstr(11) := ("hfe5218e3".U) //bne x4 x5 -16 <fibo>
  hardCodeInstr(12) := ("h000080e7".U) //jalr x1 x1 0
  //[<printnum>]
  hardCodeInstr(13) := ("h402020a3".U) //sw x2 1025 x0
  hardCodeInstr(14) := ("h403020a3".U) //sw x3 1025 x0
  hardCodeInstr(15) := ("h00038067".U) //jalr x0 x7 0
  */
  //test of uart program:
  val hardCodeInstr = Wire(Vec(6,UInt(32.W)))
  hardCodeInstr(0) := ("h03100193".U) //addi x3 x0 49 //49=1 in ASCII
  hardCodeInstr(1) := ("h03200213".U) //addi x4 x0 50 //50=2 in ASCII
  hardCodeInstr(2) := ("h403020a3".U) //sw x3 1025 x0
  hardCodeInstr(3) := ("h404020a3".U) //sw x4 1025 x0
  hardCodeInstr(4) := ("h00a00513".U) //addi x10 x0 10
  hardCodeInstr(5) := ("h00000073".U) //ecall

  //adder wire
  val pcAdded = WireDefault(0.U(32.W))
  pcAdded := Mux(io.running,pc + 1.U,pc)

  //Mux
  val pcMux = WireDefault(0.U(32.W))
  pcMux := Mux(io.pcSrc, io.branchAddr >> 2, pcAdded) //Divide branchaddr by 4 because 4 times too big
  pc := pcMux

  //INITIALIZE Outputs
  io.instruction := Mux(io.running,Mux(io.pcSrc,"h00000013".U,hardCodeInstr(pc)),"h00000013".U) //flush if branch is decoded (normal line)


  //SHIFT PC 2 (time it by 4)
  io.pc := pc << 2
}