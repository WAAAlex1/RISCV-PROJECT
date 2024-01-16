import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
class TopLevelCAETest1 extends AnyFlatSpec with // t1 & shift2.s
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h00100293".U) // addi x5 x0 1
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("habcdf5b7".U) // lui x11 0xabcdf

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("hfab58593".U) // addi x11 x11 -85

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00559633".U) // sll x12 x11 x5

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h0055d6b3".U) //srl x13 x11 x5

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h4055d733".U) // sra x14 x11 x5

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00359793".U) // slli x15 x11 3

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h0035d813".U) // srli x16 x11 3

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h4035d513".U) // srai x10 x11 3

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00a00893".U) // addi x17 x0 10

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00000073".U) // ecall

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(1.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(-176570891.S)
      dut.io.regFile(11).expect(-1412567125.S)
      dut.io.regFile(12).expect(1469833046.S)
      dut.io.regFile(13).expect(1441200085.S)
      dut.io.regFile(14).expect(-706283563.S)
      dut.io.regFile(15).expect(1584364888.S)
      dut.io.regFile(16).expect(360300021.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest2 extends AnyFlatSpec with // t2 & bool.s
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h123452b7".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h67828293".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("habcdf337".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("hfab30313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h0062c5b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h0062e633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h0062f6b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h5212c713".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h5212e793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h5212f813".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h00000073".U) // ecall

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(305419896.S)
      dut.io.regFile(6).expect(-1412567125.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(0.S)
      dut.io.regFile(11).expect(-1174816301.S)
      dut.io.regFile(12).expect(-1140981765.S)
      dut.io.regFile(13).expect(33834536.S)
      dut.io.regFile(14).expect(305419097.S)
      dut.io.regFile(15).expect(305420153.S)
      dut.io.regFile(16).expect(1056.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest3 extends AnyFlatSpec with // t3 & set.s
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h12300293".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h45600313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h006285b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h40628633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h0062a6b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h0062b733".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("hadf2a793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("hadf2b813".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(291.S)
      dut.io.regFile(6).expect(1110.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(0.S)
      dut.io.regFile(11).expect(1401.S)
      dut.io.regFile(12).expect(-819.S)
      dut.io.regFile(13).expect(1.S)
      dut.io.regFile(14).expect(1.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(1.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest4 extends AnyFlatSpec with // t4 & addlarge.s
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h80000537".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00150513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h800005b7".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("hffe58593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00b50633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(-2147483647.S)
      dut.io.regFile(11).expect(2147483646.S)
      dut.io.regFile(12).expect(-1.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)
    }
  }
}
class TopLevelCAETest5 extends AnyFlatSpec with // t5 & addneg.s
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("hfe000513".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("hfc000593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00b50633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(-32.S)
      dut.io.regFile(11).expect(-64.S)
      dut.io.regFile(12).expect(-96.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)
    }
  }
}
class TopLevelCAETest6 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h00500513".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00600593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00b50633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(5.S)
      dut.io.regFile(11).expect(6.S)
      dut.io.regFile(12).expect(11.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)
    }
  }
}
class TopLevelCAETest7 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("hff000537".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00050513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h0ff00593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h40855513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00859593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h0ff58593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00b50633".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(-65536.S)
      dut.io.regFile(11).expect(65535.S)
      dut.io.regFile(12).expect(-1.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest8 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("hf8500293".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("hf8500313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h07a00393".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h02628263".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00200613".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00734a63".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00400713".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h0053e263".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00500793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h02737a63".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00300693".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("hfe53d6e3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h00100593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("hfc729ee3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(14.U)
      dut.io.wrData.poke("h00000513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(15.U)
      dut.io.wrData.poke("h00000593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(16.U)
      dut.io.wrData.poke("h00000613".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(17.U)
      dut.io.wrData.poke("h00000693".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(18.U)
      dut.io.wrData.poke("h00000713".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(19.U)
      dut.io.wrData.poke("h00000793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(20.U)
      dut.io.wrData.poke("h00000813".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(21.U)
      dut.io.wrData.poke("h00000893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(22.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(23.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(-123.S)
      dut.io.regFile(6).expect(-123.S)
      dut.io.regFile(7).expect(122.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(0.S)
      dut.io.regFile(11).expect(1.S)
      dut.io.regFile(12).expect(2.S)
      dut.io.regFile(13).expect(3.S)
      dut.io.regFile(14).expect(4.S)
      dut.io.regFile(15).expect(5.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest9 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h00000513".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h00a00593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00150513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("hfeb51ee3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("hfeb548e3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("hfea5c6e3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00050613".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00a58693".U) //Extra addi operation on register a3 to check whether ecall in fact kills the program
                                        //Used to find bug where ECALL did not flush pipeline, meaning all operations already in
                                        //Would be executed
      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(10.S)
      dut.io.regFile(11).expect(10.S)
      dut.io.regFile(12).expect(10.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest10 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h00a00513".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h01400593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h02b50063".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00b54863".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h00300513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h00400593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00b54c63".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00b54463".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("hfeb548e3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("hfeb54ee3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00100513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h00200593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h00050613".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(14.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(0.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(3.S)
      dut.io.regFile(11).expect(4.S)
      dut.io.regFile(12).expect(3.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(0.S)
      dut.io.regFile(15).expect(0.S)
      dut.io.regFile(16).expect(0.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest11 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("habcdf2b7".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("hfab28293".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h07f00313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00530023".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h005310a3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h005321a3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00030583".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00131603".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00332683".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00034703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00135783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h00032803".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(-1412567125.S)
      dut.io.regFile(6).expect(127.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(0.S)
      dut.io.regFile(11).expect(-85.S)
      dut.io.regFile(12).expect(-4181.S)
      dut.io.regFile(13).expect(-1412567125.S)
      dut.io.regFile(14).expect(171.S)
      dut.io.regFile(15).expect(61355.S)
      dut.io.regFile(16).expect(-1410356309.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}
class TopLevelCAETest12 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("habcdf2b7".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("hfab28293".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h07f00313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00530023".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h005310a3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h005321a3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h00030583".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("h00131603".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("h00332683".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("h00034703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("h00135783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h00032803".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.running.poke(true.B)

      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(100)
      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(0.S)
      dut.io.regFile(2).expect(0.S)
      dut.io.regFile(3).expect(0.S)
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(-1412567125.S)
      dut.io.regFile(6).expect(127.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(3.S)
      dut.io.regFile(11).expect(-85.S)
      dut.io.regFile(12).expect(-4181.S)
      dut.io.regFile(13).expect(-1412567125.S)
      dut.io.regFile(14).expect(171.S)
      dut.io.regFile(15).expect(61355.S)
      dut.io.regFile(16).expect(-1410356309.S)
      dut.io.regFile(17).expect(10.S)
      dut.io.regFile(18).expect(0.S)
      dut.io.regFile(19).expect(0.S)
      dut.io.regFile(20).expect(0.S)
      dut.io.regFile(21).expect(0.S)
      dut.io.regFile(22).expect(0.S)
      dut.io.regFile(23).expect(0.S)
      dut.io.regFile(24).expect(0.S)
      dut.io.regFile(25).expect(0.S)
      dut.io.regFile(26).expect(0.S)
      dut.io.regFile(27).expect(0.S)
      dut.io.regFile(28).expect(0.S)
      dut.io.regFile(29).expect(0.S)
      dut.io.regFile(30).expect(0.S)
      dut.io.regFile(31).expect(0.S)

    }
  }
}