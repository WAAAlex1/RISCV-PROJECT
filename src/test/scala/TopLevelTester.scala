import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class TopLevelTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      println("pc at cycle 0 is: " + dut.io.pc.peekInt())
      dut.io.wrData.poke("h00100093".U) //addi x1 x0 1
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      //Instruction is read into IF
      //pc = 1

      dut.clock.step(1)
      //ID
      //pc = 2

      dut.clock.step(1)
      //EX
      //pc = 3

      dut.clock.step(1)
      //MEM
      //pc = 4

      println("x1 value during MEM is: " + dut.io.regFile(1).peekInt())
      dut.clock.step(1)

      //Writing to the registers becomes visible now because it takes 1 extra cycle for reg changes to be visible.
      println("x1 value 1 cycle after MEM is: " + dut.io.regFile(1).peekInt())
      dut.clock.step(1)

      println("x1 value 2 cycles after MEM is: " + dut.io.regFile(1).peekInt())
      dut.io.regFile(1).expect(1.S)
    }
  }
}

class TopLevelTester2 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00300093".U) //addi x1 x0 3
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00200113".U) //addi x2 x0 2

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop


      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h402080b3".U) //sub x1 x1 x2

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(4)
      dut.io.regFile(1).expect(1.S)
    }
  }
}

//bool.s
class TopLevelTester3 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h123452b7".U) //lui t0 x12345
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h67828293".U) //addi x5 x5 1656

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("habcdf337".U) //lui x6 0xabcdf

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("hfab30313".U) //addi x6 x6 -85

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h0062c5b3".U) //xor x11 x5 x6

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h0062e633".U) //or x12 x5 x6

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h0062f6b3".U) //and x13 x5 x6

      dut.clock.step(1)
      dut.io.wrAddr.poke(14.U)
      dut.io.wrData.poke("h5212c713".U) //xori x14 x5 1313

      dut.clock.step(1)
      dut.io.wrAddr.poke(15.U)
      dut.io.wrData.poke("h5212e793".U) //ori x15 x5 1313

      dut.clock.step(1)
      dut.io.wrAddr.poke(16.U)
      dut.io.wrData.poke("h5212f813".U) //andi x16 x5 1313

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(4)
      dut.io.regFile(5).expect(305419896.S) //0x12345678
      dut.io.regFile(6).expect(-1412567125.S) //0xabcdefab
      dut.io.regFile(11).expect(-1174816301.S) //0xB9F9B9D3
      dut.io.regFile(12).expect(-1140981765.S) //0xbbfbdfffb
      dut.io.regFile(13).expect(33834536.S) //0x02044628
      dut.io.regFile(14).expect(305419097.S) //0x12345359
      dut.io.regFile(15).expect(305420153.S) //0x12345779
      dut.io.regFile(16).expect(1056.S) //0x00000420
    }
  }
}

class TopLevelTester4 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("habcdf337".U) //lui x6 0xabcdf
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("hfab30313".U) //addi x6 x6 -85

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(4)
      dut.io.regFile(6).expect(-1412567125.S)
    }
  }
}

//test: branchcnt.s
class TopLevelTester5 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00000513".U) //addi x10 x0 0
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00a00593".U) //addi x11 x0 10

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00150513".U) //addi x10 x10 1

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("hfeb51ae3".U) //bne x10 x11 -12

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("hfeb542e3".U) //blt x10 x11 -28

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("hfea5c0e3".U) //blt x11 x10 -32

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00050613".U) //addi x12 x10 0

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(70)
      dut.io.regFile(10).expect(10.S) //0x0000000a
      dut.io.regFile(11).expect(10.S) //0x0000000a
      dut.io.regFile(12).expect(10.S) //0x0000000a
    }
  }
}

//mini mem test
class TopLevelTester6 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h02a00093".U) //addi x1 x0 42
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00a00113".U) //addi x2 x0 10

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00112023".U) //sw x1 0 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00012183".U) //lw x3 0 x2

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(5)
      dut.io.regFile(3).expect(42.S)
    }
  }
}

//mini mem test
class TopLevelTester7 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h040000b7".U) //lui x1 0x4000
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h3ff00113".U) //addi x2 x0 1023

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00112023".U) //sw x1 0 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000013".U) //nop
      
      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00012503".U) //lw x10 0 x2

      dut.clock.step(1)

      dut.io.wrEna.poke(false.B)
      println("x1 is" + dut.io.regFile(1).peekInt())
      println("x2 is" + dut.io.regFile(2).peekInt())
      dut.clock.step(4)
      dut.io.regFile(10).expect(67108864.S)
    }
  }
}

//Tests loading and storing byte, hw and unsigned bytes and hws.
class TopLevelTester8 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruction into the instruction memory:
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h666690b7".U) //lui x1 0x66669
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h88808093".U) //addi x1 x1 -1912

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00c00113".U) //addi x2 x0 12

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00110023".U) //sb x1 0 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h001110a3".U) //sh x1 1 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00010183".U) //lb x3 0 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h00111203".U) //lh x4 1 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h00014283".U) //lbu x5 0 x2

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h00115303".U) //lhu x6 1 x2

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(5)
      dut.io.regFile(3).expect(-120.S) //expect lb to sign extend
      dut.io.regFile(4).expect(-30584.S) //expect lh to sign extend
      dut.io.regFile(5).expect(136.S) //expect lbu to zero extend
      dut.io.regFile(6).expect(34952.S) //expect lhu to zero extend
    }
  }
}

/*
//Test blinking LEDoutput for hardcoding
class TopLevelTester9 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      dut.clock.step(6)
      dut.io.regFile2bit1.expect(false.B)
      dut.clock.step(490)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())
      dut.clock.step(1)
      println("reg2bit1 er: " + dut.io.regFile2bit1.peekInt())
      println("counteren er: " + dut.io.regFile1.peekInt())




    }
  }
}
*/