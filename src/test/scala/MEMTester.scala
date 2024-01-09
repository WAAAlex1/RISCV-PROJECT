import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MEMTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "MEM stage" should "pass" in {
    test(new MEMModule) { dut =>
      dut.io.aluResult.poke(42.S)
      dut.io.rs2Data.poke(10.S)
      dut.io.rdIn.poke(11.U)
      dut.io.memControl.memWrite.poke(true.B)
      dut.io.memControl.regWrite.poke(false.B)
      dut.io.memControl.memToReg.poke(false.B)

      dut.clock.step(1)

      dut.io.aluResult.poke(42.S)
      dut.io.rs2Data.poke(7.S)
      dut.io.rdIn.poke(15.U)
      dut.io.memControl.memWrite.poke(false.B)
      dut.io.memControl.regWrite.poke(true.B)
      dut.io.memControl.memToReg.poke(true.B)

      dut.clock.step(1)

      //Change in values that shouldn't affect result:
      dut.io.aluResult.poke(48.S)

      //Expects:
      dut.io.regWriteData.expect(10.S)
      dut.io.rdOut.expect(15.U)
      dut.io.regWriteOut.expect(true.B)
    }
  }
}