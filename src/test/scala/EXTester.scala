import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import AluOperations._

class EXTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "EX stage" should "pass" in {
    test(new EXModule) { dut =>
      dut.io.rs1data.poke(0.S)
      dut.io.rs2dataIn.poke(0.S)
      dut.io.pc.poke(100.U)
      dut.io.rdIn.poke(0.U)
      //dut.io.aluOpSelect.poke(0.U)
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
      dut.io.rs2dataIn.poke(2.S)
      dut.io.pc.poke(8.U)
      dut.io.rdIn.poke(0.U)
      dut.io.imm.poke(3.S)
      dut.io.aluOpSelect.poke(ADD)

      dut.io.aluSRC.poke(true.B) //use imm
      dut.io.branchIn.poke(false.B)
      dut.io.memReadIn.poke(false.B)
      dut.io.memWriteIn.poke(false.B)
      dut.io.regWriteIn.poke(false.B)
      dut.io.memToRegIn.poke(false.B)
      dut.io.branchCheckIn.poke(false.B)

      dut.clock.step(1)
      dut.io.aluResult.expect(4.S)
      dut.io.rs2DataOut.expect(2.S)
      dut.io.branchAddr.expect(5.U)
    }
  }
}