import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IFTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "IF stage" should "pass" in {
    test(new IFModule) { dut =>
      dut.io.PCScr.poke(false.B)
      dut.io.BranchAddr.poke(0.U)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke(1.U)
      dut.io.wrEna.poke(true.B)
      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke(2.U)
      println("pc after 1 clockcycles is:" + dut.io.PC.peekInt())
      dut.clock.step(1)
      dut.io.Instruction.expect(1.U) // (pc is incremented, then another cycle for read) = 1 cycle delay
      dut.clock.step(1)
      println("pc after 3 clockcycles is:" + dut.io.PC.peekInt())
      dut.io.Instruction.expect(2.U)
    }
  }
}
class IFTester2 extends AnyFlatSpec with
  ChiselScalatestTester {
  "IF stage" should "pass" in {
    test(new IFModule) { dut =>
      dut.io.PCScr.poke(true.B)
      dut.io.BranchAddr.poke(100.U)
      dut.io.wrAddr.poke(100.U)
      dut.io.wrData.poke(4.U)
      dut.io.wrEna.poke(true.B)
      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      println("pc after branch is:" + dut.io.PC.peekInt())
      println("Instruction after branch is (expect 0):" + dut.io.Instruction.peekInt())
      dut.clock.step(1)
      dut.io.Instruction.expect(4.U)
    }
  }
}
