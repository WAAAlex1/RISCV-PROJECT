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
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00200113".U) //addi x2 x0 2

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000013".U) //nop

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h402080b3".U) //sub x1 x1 x2

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(4)
      dut.io.regFile(1).expect(1.S)
    }
  }
}

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