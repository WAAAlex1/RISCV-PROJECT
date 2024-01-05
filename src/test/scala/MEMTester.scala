import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MEMTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "MEM stage" should "pass" in {
    test(new MEMModule) { dut =>
      dut.io.branchAddrIn.poke(12.U)
      dut.io.aluResult.poke(42.S)
      dut.io.rs2Data.poke(10.S)
      dut.io.rdIn.poke(11.U)
      dut.io.branch.poke(false.B)
      dut.io.memWrite.poke(true.B)
      dut.io.regWriteIn.poke(false.B)
      dut.io.memToReg.poke(false.B)
      dut.io.branchCheck.poke(true.B)

      dut.clock.step(1)

      dut.io.branchAddrIn.poke(12.U)
      dut.io.aluResult.poke(42.S)
      dut.io.rs2Data.poke(7.S)
      dut.io.rdIn.poke(15.U)
      dut.io.branch.poke(false.B)
      dut.io.memWrite.poke(false.B)
      dut.io.regWriteIn.poke(true.B)
      dut.io.memToReg.poke(true.B)
      dut.io.branchCheck.poke(true.B)

      dut.clock.step(1)

      //Change in values that shouldnt affect result:
      dut.io.aluResult.poke(48.S)

      //Expects:
      dut.io.regWriteData.expect(10.S)
      dut.io.rdOut.expect(15.U)
      dut.io.branchAddrOut.expect(12.U)
      dut.io.pcSrc.expect(false.B)
      dut.io.regWriteOut.expect(true.B)
    }
  }
}