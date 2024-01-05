import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MEMTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "MEM stage" should "pass" in {
    test(new MEMModule) { dut =>
      





    }
  }
}