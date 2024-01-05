import chisel3._

//This is pretty much copied from the chisel book chapter on memory but its easy to understand
class Memory(size: Int,elSize: Int) extends Module {
  val io = IO(new Bundle {
    val rdAddr = Input(UInt(10.W))
    val rdData = Output(UInt(32.W))
    val wrAddr = Input(UInt(10.W))
    val wrData = Input(UInt(32.W))
    val wrEna = Input(Bool())
  })

  val mem = SyncReadMem(size, UInt ((elSize).W))

  io.rdData := mem.read(io.rdAddr)

  when(io.wrEna) {
    mem.write(io.wrAddr, io. wrData)
  }
}
