import chisel3._

class TopG extends Module {
  val io = IO(new Bundle {
    val Instruction = Input(UInt(32.W))
    val tx = Output(Bool())
  })

}
// ------------------------------------------------------------------------------

// generate Verilog
object TopG extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new TopG)
}