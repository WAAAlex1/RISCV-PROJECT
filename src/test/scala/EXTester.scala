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
      dut.io.aluOpSelect.poke(0.U)
      dut.io.imm.poke(-50.S)
      dut.clock.step(1)
      dut.io.branchAddr.expect(50.U)
      dut.clock.step(1)
    }
  }
}

class EXTester2 extends AnyFlatSpec with
  ChiselScalatestTester {
  "EX stage" should "pass" in {
    test(new EXModule) { dut =>
      dut.io.rs1data.poke(1.S)
      dut.io.rs2dataIn.poke(0.S)
      dut.io.pc.poke(0.U)
      dut.io.rdIn.poke(0.U)
      dut.io.aluOpSelect.poke(0.U)
      dut.io.imm.poke(3.S)
      dut.io.aluSRC.poke(true.B)
      dut.io.branchIn.poke(false.B)
      dut.io

      dut.clock.step(1)

    }
  }
}