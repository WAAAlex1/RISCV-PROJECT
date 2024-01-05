import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class TopLevelTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevel) { dut =>
      //Insert instruciton into the instruction memory:
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00100093".U) //addi x1 x0 1
      dut.io.wrEna.poke(true.B)
      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      //Instruction is read into IF
      dut.clock.step(1)
      //ID
      dut.clock.step(1)
      //EX
      dut.clock.step(1)
      //MEM
      println("x1 value during MEM is: " + dut.io.regFile(1).peekInt())
      dut.clock.step(1)
      //Writing to the registers becomes visible now?
      dut.clock.step(1)
      dut.io.regFile(1).expect(1.S)
    }
  }
}