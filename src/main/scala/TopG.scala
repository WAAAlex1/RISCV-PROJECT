import chisel3._

class TopG extends Module {
  val io = IO(new Bundle {
    val tx = Output(Bool())
  })

}
// ------------------------------------------------------------------------------
// Clk


// ------------------------------------------------------------------------------





// ------------------------------------------------------------------------------

object TopG extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TopG)
}