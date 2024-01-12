package Import

import chisel3._
import chisel3.util._

import MemoryMappedUart._
import StringStreamer._

class SerialPort(freq: Int, baud: Int) extends Module {
  val io = IO(new Bundle {
    val uart = UartPins()
  })

  val stringStreamer = StringStreamer("Hello World!\n")

  val mmUart = MemoryMappedUart(
    freq,
    baud,
    txBufferDepth = 8,
    rxBufferDepth = 8
  )

  stringStreamer.io.port <> mmUart.io.port
  io.uart <> mmUart.io.pins
}