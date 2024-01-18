import Import.Bus

import chisel3._
import chisel3.util._

/*
  * Module for reading instructions from the port and
  * writing ecall messages back to the p
 */
class SerialPort extends Module {
  val io = IO(new Bundle {
    val running = Input(Bool())
    val wrEna   = Input(Bool())
    val wrData  = Input(UInt(8.W))

    val readyToRun = Output(Bool())

    val instr      = Output(UInt(32.W))
    val instrValid = Output(Bool())

    val port = Bus.RequestPort()
  })

  object State extends ChiselEnum {
    val staReq, // initiate status read
    recvSta, // receive on readstatus
    readByte, // read byte1 of the instruction
    wb
    = Value
  }

  val instrByteVec = RegInit(VecInit(Seq.fill(4)(0.U(8.W)))) //byte3 = MSB, byte0 = LSB
  val idxReg = RegInit(3.U(2.W))
  val stateReg = RegInit(State.staReq)



  val wrEnaReg  = RegNext(io.wrEna)
  val wrDataReg = RegNext(io.wrData)
  val wrEnaRegDelayed = RegNext(wrEnaReg)
  val wrDataRegDelayed = RegNext(wrDataReg) //these should solve the issues with write timing

  //Base cases of outputs:
  io.instrValid := false.B
  io.instr := "h00000013".U //nop
  io.readyToRun := false.B

  switch(stateReg)
  {
    is(State.staReq){
      io.port.readRequest(1.U) //read status
      stateReg := State.recvSta
    }
    is(State.recvSta){
      when(io.running){
        when(io.port.rdData(0) & wrEnaReg) {
          io.port.writeRequest(0.U, wrDataReg)
        } .elsewhen(io.port.rdData(0) & wrEnaRegDelayed){
          io.port.writeRequest(0.U, wrDataRegDelayed)
        }
        stateReg := State.staReq
      } .otherwise {
        stateReg := Mux(io.port.rdData(1),State.readByte,State.staReq)
        io.port.readRequest(0.U) //request read of data even if not needed
      }
    }
    is(State.readByte){
      instrByteVec(idxReg) := io.port.rdData //read byte of instr
      io.port.readRequest(1.U) //request status read
      idxReg := idxReg - 1.U
      stateReg := Mux(idxReg === 0.U,State.wb,State.staReq)
    }
    is(State.wb){
      when((instrByteVec(3) ## instrByteVec(2) ## instrByteVec(1) ## instrByteVec(0)) === "h10000000".U){ //0x1000000 is our run instruction
        io.readyToRun := true.B
        stateReg := State.staReq //return to base state
      } .otherwise {
        io.instr := (instrByteVec(3) ## instrByteVec(2) ## instrByteVec(1) ## instrByteVec(0)) //send instruction
        io.instrValid := true.B
        stateReg := State.staReq //return to base state
      }
    }
  }
}
