import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import AluOperations._


class EXTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "EX stage" should "pass" in {
    test(new EXModule) { dut =>
      dut.io.rs1data.poke(1.S)
      dut.io.rs2dataIn.poke(2.S)
      dut.io.pc.poke(8.U)
      dut.io.rdIn.poke(0.U)
      dut.io.imm.poke(3.S)
      dut.io.exControl.aluOpSelect.poke(ADD)

      dut.io.exControl.aluSRC.poke(false.B) //use rs2
      dut.io.exControl.sigBundle.memWrite.poke(false.B)
      dut.io.exControl.sigBundle.regWrite.poke(false.B)
      dut.io.exControl.sigBundle.memToReg.poke(false.B)

      dut.clock.step(1)

      dut.io.aluResult.expect(3.S)
      dut.io.rs2DataOut.expect(2.S)
    }
  }
}