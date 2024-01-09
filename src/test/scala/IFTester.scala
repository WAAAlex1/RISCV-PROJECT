import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IFTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "IF stage" should "pass" in {
    test(new IFModule) { dut =>
      dut.io.pcSrc.poke(false.B)
      dut.io.branchAddr.poke(0.U)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke(1.U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke(2.U)
      dut.io.instruction.expect(1.U)
      println("pc after 1 clockcycles is:" + dut.io.pc.peekInt())

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.io.instruction.expect(2.U)
      dut.clock.step(1)
      println("pc after 3 clockcycles is:" + dut.io.pc.peekInt())
    }
  }
}
class IFTester2 extends AnyFlatSpec with
  ChiselScalatestTester {
  "IF stage" should "pass" in {
    test(new IFModule) { dut =>
      dut.io.pcSrc.poke(true.B)
      dut.io.branchAddr.poke(400.U)
      dut.io.wrAddr.poke(100.U)
      dut.io.wrData.poke(4.U)
      dut.io.wrEna.poke(true.B)
      dut.clock.step(1)
      dut.io.pcSrc.poke(false.B)
      dut.io.wrEna.poke(false.B)
      println("pc after branch is:" + dut.io.pc.peekInt())
      println("Instruction after branch is (expect 4):" + dut.io.instruction.peekInt())
      dut.io.instruction.expect(4.U)
    }
  }
}
