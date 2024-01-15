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
    val readyToRun = Output(Bool())

    val instr = Output(UInt(32.W))
    val instrValid = Output(Bool())

    val port = Bus.RequestPort() // bus port
  })

  object State extends ChiselEnum {
    val staReq, // initiate status read
    recvSta, // receive on readstatus
    readByte1, // read byte1 of the instruction
    readByte2, // read byte2 of the instruction
    readByte3, // read byte3 of the instruction
    readByte4, // read byte4 of the instruction
    wb
    = Value
  }

  val instrReg = RegInit(0.U(32.W))
  instrReg := instrReg
  val stateReg = RegInit(State.staReq)

  io.port.init()

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
        //write stuff
        stateReg := State.staReq //just go back for now
      } .otherwise {
        stateReg := Mux(io.port.rdData(1),State.readByte1,State.staReq)
        io.port.readRequest(0.U) //request read of data even if not needed
      }
    }
    is(State.readByte1){
      instrReg(31,24) := io.port.rdData //read top byte of instr
      io.port.readRequest(0.U) //request next byte
      stateReg := State.readByte2
    }
    is(State.readByte2){
      instrReg(23,16) := io.port.rdData //read next byte of instr
      io.port.readRequest(0.U) //request next byte
      stateReg := State.readByte3
    }
    is(State.readByte3){
      instrReg(15,8) := io.port.rdData //read next byte of instr
      io.port.readRequest(0.U) //request next byte
      stateReg := State.readByte4
    }
    is(State.readByte4){
      instrReg(7,0) := io.port.rdData //read last byte of instr
      stateReg := State.wb //next state = writeback
    }
    is(State.wb){
      when(instrReg === "h10000000"){ //h1000000 is our run instruction
        io.readyToRun := true.B
        stateReg := State.staReq //return to base state
      } .otherwise {
        io.instr := instrReg //send instruction
        io.instrValid := true.B
        stateReg := State.staReq //return to base state
      }
    }

  }

}
