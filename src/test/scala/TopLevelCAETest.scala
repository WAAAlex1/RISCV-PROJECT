import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

//t1 = shift2.s
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

//t2 = bool.s
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

//t3 = set.s
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

//t4 = addlarge.s
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

//t5 = addneg.s
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

//t6 = addpos.s
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

//t7 = shift.s
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

//t8 = branchtrap.s
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

//t9 = branchcht.s
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

//t10 = branchMany.s
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

//t11 = width.s
class TopLevelCAETest11 extends AnyFlatSpec with // WILL FAIL - t11 /
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

//t12 = loop.s
class TopLevelCAETest12 extends AnyFlatSpec with
  ChiselScalatestTester {
  "TopLevel" should "pass" in {
    test(new TopLevelSim) { dut =>
      dut.io.running.poke(false.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h3ff00113".U)
      dut.io.wrEna.poke(true.B)

      dut.clock.step(1)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke("h078000ef".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(2.U)
      dut.io.wrData.poke("h00a00893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(3.U)
      dut.io.wrData.poke("h00000073".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("hfd010113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h02812623".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(6.U)
      dut.io.wrData.poke("h03010413".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(7.U)
      dut.io.wrData.poke("hfca42e23".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(8.U)
      dut.io.wrData.poke("hfcb42c23".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(9.U)
      dut.io.wrData.poke("hfe042623".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(10.U)
      dut.io.wrData.poke("hfe042423".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(11.U)
      dut.io.wrData.poke("h0300006f".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(12.U)
      dut.io.wrData.poke("hfe842783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(13.U)
      dut.io.wrData.poke("h00279793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(14.U)
      dut.io.wrData.poke("hfdc42703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(15.U)
      dut.io.wrData.poke("h00f707b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(16.U)
      dut.io.wrData.poke("h0007a783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(17.U)
      dut.io.wrData.poke("hfec42703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(18.U)
      dut.io.wrData.poke("h00f707b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(19.U)
      dut.io.wrData.poke("hfef42623".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(20.U)
      dut.io.wrData.poke("hfe842783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(21.U)
      dut.io.wrData.poke("h00178793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(22.U)
      dut.io.wrData.poke("hfef42423".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(23.U)
      dut.io.wrData.poke("hfe842703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(24.U)
      dut.io.wrData.poke("hfd842783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(25.U)
      dut.io.wrData.poke("hfcf746e3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(26.U)
      dut.io.wrData.poke("hfec42783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(27.U)
      dut.io.wrData.poke("h00078513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(28.U)
      dut.io.wrData.poke("h02c12403".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(29.U)
      dut.io.wrData.poke("h03010113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(30.U)
      dut.io.wrData.poke("h00008067".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(31.U)
      dut.io.wrData.poke("hfe010113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(32.U)
      dut.io.wrData.poke("h00112e23".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(33.U)
      dut.io.wrData.poke("h00812c23".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(34.U)
      dut.io.wrData.poke("h00912a23".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(35.U)
      dut.io.wrData.poke("h02010413".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(36.U)
      dut.io.wrData.poke("h00010313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(37.U)
      dut.io.wrData.poke("h00030493".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(38.U)
      dut.io.wrData.poke("h06400313".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(39.U)
      dut.io.wrData.poke("hfe642423".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(40.U)
      dut.io.wrData.poke("hfe842303".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(41.U)
      dut.io.wrData.poke("hfff30e13".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(42.U)
      dut.io.wrData.poke("hffc42223".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(43.U)
      dut.io.wrData.poke("h00030e13".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(44.U)
      dut.io.wrData.poke("h000e0813".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(45.U)
      dut.io.wrData.poke("h00000893".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(46.U)
      dut.io.wrData.poke("h01b85e13".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(47.U)
      dut.io.wrData.poke("h00589693".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(48.U)
      dut.io.wrData.poke("h00de66b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(49.U)
      dut.io.wrData.poke("h00581613".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(50.U)
      dut.io.wrData.poke("h00030693".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(51.U)
      dut.io.wrData.poke("h00068513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(52.U)
      dut.io.wrData.poke("h00000593".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(53.U)
      dut.io.wrData.poke("h01b55693".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(54.U)
      dut.io.wrData.poke("h00559793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(55.U)
      dut.io.wrData.poke("h00f6e7b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(56.U)
      dut.io.wrData.poke("h00551713".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(57.U)
      dut.io.wrData.poke("h00030793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(58.U)
      dut.io.wrData.poke("h00279793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(59.U)
      dut.io.wrData.poke("h00f78793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(60.U)
      dut.io.wrData.poke("h0047d793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(61.U)
      dut.io.wrData.poke("h00479793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(62.U)
      dut.io.wrData.poke("h40f10133".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(63.U)
      dut.io.wrData.poke("h00010793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(64.U)
      dut.io.wrData.poke("h00378793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(65.U)
      dut.io.wrData.poke("h0027d793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(66.U)
      dut.io.wrData.poke("h00279793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(67.U)
      dut.io.wrData.poke("hfef42023".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(68.U)
      dut.io.wrData.poke("hfe042623".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(69.U)
      dut.io.wrData.poke("h0280006f".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(70.U)
      dut.io.wrData.poke("hfe042703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(71.U)
      dut.io.wrData.poke("hfec42783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(72.U)
      dut.io.wrData.poke("h00279793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(73.U)
      dut.io.wrData.poke("h00f707b3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(74.U)
      dut.io.wrData.poke("hfec42703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(75.U)
      dut.io.wrData.poke("h00e7a023".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(76.U)
      dut.io.wrData.poke("hfec42783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(77.U)
      dut.io.wrData.poke("h00178793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(78.U)
      dut.io.wrData.poke("hfef42623".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(79.U)
      dut.io.wrData.poke("hfec42703".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(80.U)
      dut.io.wrData.poke("hfe842783".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(81.U)
      dut.io.wrData.poke("hfcf74ae3".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(82.U)
      dut.io.wrData.poke("hfe842583".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(83.U)
      dut.io.wrData.poke("hfe042503".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(84.U)
      dut.io.wrData.poke("h00000097".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(85.U)
      dut.io.wrData.poke("hec0080e7".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(86.U)
      dut.io.wrData.poke("h00050793".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(87.U)
      dut.io.wrData.poke("h00048113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(88.U)
      dut.io.wrData.poke("h00078513".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(89.U)
      dut.io.wrData.poke("hfe040113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(90.U)
      dut.io.wrData.poke("h01c12083".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(91.U)
      dut.io.wrData.poke("h01812403".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(92.U)
      dut.io.wrData.poke("h01412483".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(93.U)
      dut.io.wrData.poke("h02010113".U)

      dut.clock.step(1)
      dut.io.wrAddr.poke(94.U)
      dut.io.wrData.poke("h00008067".U)



      dut.clock.step(1)
      dut.io.wrEna.poke(false.B)
      dut.clock.step(1)
      dut.io.running.poke(true.B)
      dut.clock.step(1)
      dut.clock.setTimeout(0)
      dut.clock.step(50000)

      dut.io.regFile(0).expect(0.S)
      dut.io.regFile(1).expect(8.S)

      dut.io.regFile(3).expect(0.S) //ripes changes this but the code shouldnt
      dut.io.regFile(4).expect(0.S)
      dut.io.regFile(5).expect(0.S)
      dut.io.regFile(6).expect(100.S)
      dut.io.regFile(7).expect(0.S)
      dut.io.regFile(8).expect(0.S)
      dut.io.regFile(9).expect(0.S)
      dut.io.regFile(10).expect(1920142429.S)
      dut.io.regFile(11).expect(100.S)
      dut.io.regFile(12).expect(3200.S)
      dut.io.regFile(13).expect(0.S)
      dut.io.regFile(14).expect(100.S)
      dut.io.regFile(15).expect(1920142429.S)
      dut.io.regFile(16).expect(100.S)
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
      dut.io.regFile(2).expect(1023.S)
    }
  }
}