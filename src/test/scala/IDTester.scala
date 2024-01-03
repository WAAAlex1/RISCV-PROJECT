import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IDTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "ID stage" should "pass" in {
    test(new IDModule) { dut =>
      //Input
      dut.io.pcIn.poke(0.U)
      dut.io.writeRegAddr.poke(0.U)
      dut.io.writeRegData.poke(0.U)
      dut.io.regWriteIn.poke(false.B)
      dut.io.instr.poke("hf150_8113".U) //addi x2, x1, -235

      dut.clock.step(1) //clock because regs on the inputs

      //Expected outputs:
      dut.io.pcOut.expect(0.U)
      dut.io.rs1data.expect(0.U) //check if x1 resets/starts at zero
      dut.io.imm.expect(-235.S)
      dut.io.rd.expect(2.U)
    }
  }
}