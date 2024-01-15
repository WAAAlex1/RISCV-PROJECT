import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SerialPortTester extends AnyFlatSpec with
  ChiselScalatestTester {
  "SerialPort" should "pass" in {
    test(new SerialPort) { dut =>
      dut.io.running.poke(false.B)
      //man kan jo ikke teste uart stuff...

    }
  }
}