import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import AluOperations._

class IDTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "ID stage" should "pass" in {
    test(new IDModule) { dut =>
      //Input
      dut.io.pcIn.poke(0.U)
      dut.io.writeRegIdx.poke(0.U)
      dut.io.writeRegData.poke(0.S)
      dut.io.regWriteIn.poke(false.B)
      dut.io.instr.poke("hf150_8113".U) //addi x2, x1, -235

      dut.clock.step(1) //clock because regs on the inputs

      println("aluControl is (expect 0):" + dut.io.aluControl.peekInt())
      println("instr is (expect 4048584979 ):" + dut.io.instr.peekInt())
      println("aluOPType is:" + dut.io.aluOPType.peekInt())
      //Expected outputs:
      dut.io.pcOut.expect(0.U)
      dut.io.rs1data.expect(0.S) //check if x1 resets/starts at zero
      dut.io.imm.expect(-235.S)
      dut.io.rd.expect(2.U)
      dut.io.pcSelect.expect(false.B)
      dut.io.aluOpSelect.expect(ADD)
    }
  }
}