import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import AluOperations._

class ForwardingTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "Forwarding module" should "pass" in {
    test(new ForwardingModule) { dut =>
      dut.io.rs1IdxID.poke(1.U)
      dut.io.rs2IdxID.poke(2.U)
      dut.io.rs1IdxEX.poke(3.U)
      dut.io.rs2IdxEX.poke(4.U)
      dut.io.rdEX.poke(1.U)
      dut.io.rdMEM.poke(10.U)
      dut.io.regWriteEX.poke(true.B)
      dut.io.regWriteMEM.poke(false.B)
      dut.io.branchControl1.expect(1.U)
      dut.io.branchControl2.expect(0.U)
      dut.io.aluControl1.expect(0.U)
      dut.io.aluControl2.expect(0.U)
    }
  }
}

class ForwardingTester2 extends AnyFlatSpec with
  ChiselScalatestTester {
  "Forwarding module" should "pass" in {
    test(new ForwardingModule) { dut =>
      dut.io.rs1IdxID.poke(1.U)
      dut.io.rs2IdxID.poke(2.U)
      dut.io.rs1IdxEX.poke(3.U)
      dut.io.rs2IdxEX.poke(4.U)
      dut.io.rdEX.poke(5.U)
      dut.io.rdMEM.poke(3.U)
      dut.io.regWriteEX.poke(false.B)
      dut.io.regWriteMEM.poke(true.B)
      dut.io.branchControl1.expect(0.U)
      dut.io.branchControl2.expect(0.U)
      dut.io.aluControl1.expect(true.B)
      dut.io.aluControl2.expect(false.B)
    }
  }
}