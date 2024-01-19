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
  val hardCodeInstr = Wire(Vec(30,UInt(32.W)))
  //<main>
  hardCodeInstr(0) := ("h00100193".U) //addi x3 x0 1
  hardCodeInstr(1) := ("h00000113".U) // addi x2 x0 0
  hardCodeInstr(2) := ("h00500293".U) //addi x5 x0 5
  hardCodeInstr(3) := ("h01f00f93".U) //addi x31 x0 31
  hardCodeInstr(4) := ("h00100f13".U) //addi x30 x0 1
  hardCodeInstr(5) := ("h00001eb7".U) //lui x29 0x1
  hardCodeInstr(6) := ("h00c0006f".U) //jal x0 12 <fibo>
  //<end>
  hardCodeInstr(7) := ("h00a00893".U) //addi x17 x0 10
  hardCodeInstr(8) := ("h00000073".U) //ecall
  //<fibo>
  hardCodeInstr(9) := ("h00218133".U) //add x2 x3 x2
  hardCodeInstr(10) := ("h018003ef".U) //jal x7 24 <checkStatus1>
  hardCodeInstr(11) := ("h003101b3".U) //add x3 x2 x3
  hardCodeInstr(12) := ("h028003ef".U) //jal x7 40 <checkStatus2>
  hardCodeInstr(13) := ("h00120213".U) //addi x4 x4 1
  hardCodeInstr(14) := ("hfe5216e3".U) //bne x4 x5 -20 <fibo>
  hardCodeInstr(15) := ("h0340006f".U) //jal x0 52 <LED>
  //<checkStatus1>
  hardCodeInstr(16) := ("h002eae03".U) //lw x28 2 x29
  hardCodeInstr(17) := ("h01fe1e13".U) //slli x28 x28 31
  hardCodeInstr(18) := ("h01fe5e13".U) //srli x28 x28 31
  hardCodeInstr(19) := ("hffee1ae3".U) //bne x28 x30 -12 <checkStatus1>
  hardCodeInstr(20) := ("h002ea0a3".U) //sw x2 1 x29
  hardCodeInstr(21) := ("h00038067".U) //jalr x0 x7 0
  //<checkStatus2>
  hardCodeInstr(22) := ("h002eae03".U) //lw x28 2 x29
  hardCodeInstr(23) := ("h01fe1e13".U) //slli x28 x28 31
  hardCodeInstr(24) := ("h01fe5e13".U) //srli x28 x28 31
  hardCodeInstr(25) := ("hffee1ae3".U) //bne x28 x30 -12 <checkStatus2>
  hardCodeInstr(26) := ("h003ea0a3".U) //sw x3 1 x29
  hardCodeInstr(27) := ("h00038067".U) //jalr x0 x7 0
  //<LED>
  hardCodeInstr(28) := ("h003ea023".U) //sw x3 0 x29
  hardCodeInstr(29) := ("hfa9ff06f".U) //jal x0 -88 <end>
  */

  val hardCodeInstr = Wire(Vec(31,UInt(32.W)))
  //<main>
  hardCodeInstr(0) := ("h00000893".U) // addi x17 x0 0
  hardCodeInstr(1) := ("h00100193".U) // addi x3 x0 1
  hardCodeInstr(2) := ("h00000113".U) //addi x2 x0 0
  hardCodeInstr(3) := ("h00500293".U) //addi x5 x0 5
  hardCodeInstr(4) := ("h01f00f93".U) //addi x31 x0 31
  hardCodeInstr(5) := ("h00100f13".U) //addi x30 x0 1
  hardCodeInstr(6) := ("h00001eb7".U) //lui x29 0x1
  hardCodeInstr(7) := ("h04000337".U) //lui x6 0x4000
  hardCodeInstr(8) := ("h00000213".U) //addi x4 x0 0
  hardCodeInstr(9) := ("h0040006f".U) //jal x0 4 <fibo>
  //<fibo>
  hardCodeInstr(10) := ("h00218133".U) //add x2 x3 x2
  hardCodeInstr(11) := ("h018003ef".U) //jal x7 24 <checkStatus1>
  hardCodeInstr(12) := ("h003101b3".U) //add x3 x2 x3
  hardCodeInstr(13) := ("h024003ef".U) //jal x7 36 <checkStatus2>
  hardCodeInstr(14) := ("h00120213".U) //addi x4 x4 1
  hardCodeInstr(15) := ("hfe5216e3".U) //bne x4 x5 -20 <fibo>
  hardCodeInstr(16) := ("h02c0006f".U) //jal x0 44 <LED>
  //<checkStatus1>
  hardCodeInstr(17) := ("h002eae03".U) //lw x28 2 x29
  hardCodeInstr(18) := ("h01ee7e33".U) //and x28 x28 x30
  hardCodeInstr(19) := ("hffee1ce3".U) //bne x28 x30 -8 <checkStatus1>
  hardCodeInstr(20) := ("h002ea0a3".U) //sw x2 1 x29
  hardCodeInstr(21) := ("h00038067".U) //jalr x0 x7 0
  //<checkStatus2>
  hardCodeInstr(22) := ("h002eae03".U) //lw x28 2 x29
  hardCodeInstr(23) := ("h01ee7e33".U) //and x28 x28 x30
  hardCodeInstr(24) := ("hffee1ce3".U) //bne x28 x30 -8 <checkStatus2>
  hardCodeInstr(25) := ("h003ea0a3".U) //sw x3 1 x29
  hardCodeInstr(26) := ("h00038067".U) //jalr x0 x7 0
  //<LED>
  hardCodeInstr(27) := ("h003ea023".U) //sw x3 0 x29
  hardCodeInstr(28) := ("hfff30313".U) //addi x6 x6 -1
  hardCodeInstr(29) := ("hffe31ee3".U) //bne x6 x30 -4
  hardCodeInstr(30) := ("hf89ff06f".U) //jal x0 -120 <main>


  /*
  //Simple test of uart and led through memmapped outputting ! to uart
  val hardCodeInstr = Wire(Vec(9,UInt(32.W)))

  hardCodeInstr(0) := ("h02100093".U) //addi x1 x0 33
  hardCodeInstr(1) := ("h00100113".U) // addi x2 x0 1
  hardCodeInstr(2) := ("h000011b7".U) //lui x3 0x1
  //[<loop>]
  hardCodeInstr(3) := ("h0021a203".U) //lw x4 2 x3
  hardCodeInstr(4) := ("h00227233".U) //and x4 x4 x2
  hardCodeInstr(5) := ("hfe221ce3".U) //bne x4 x2 -8 <loop>
  hardCodeInstr(6) := ("h0011a0a3".U) //sw x1 1 x3
  hardCodeInstr(7) := ("h0021a023".U) //sw x2 0 x3
  hardCodeInstr(8) := ("hfedff06f".U) //jal x0 -20 <loop>
  */

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