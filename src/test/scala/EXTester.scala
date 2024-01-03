import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class EXTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "EX stage" should "pass" in {
    test(new EXModule) { dut =>
      dut.io.rs1data.poke(0.S)
      dut.io.rs2dataIn.poke(0.S)
      dut.io.pc.poke(100.U)
      dut.io.rdIn.poke(0.U)
      dut.io.aluControl.poke(0.U)
      dut.io.imm.poke(-50.S)
      dut.clock.step(1)
      dut.io.branchAddr.expect(50.U)
      dut.clock.step(1)
    }
  }
}