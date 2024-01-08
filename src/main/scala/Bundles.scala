import chisel3._
import AluOperations._
class MEMBundle extends Bundle{
  //CONTROL SIGNALS
  val memRead     = Bool() //maybe not needed?
  val memWrite    = Bool()
  val regWrite    = Bool()
  val memToReg    = Bool()
  val memSize     = UInt(3.W)
}

class EXBundle extends Bundle {

  //Control signals which are part of EX but also passed to MEM
  val sigBundle = new MEMBundle

  //Control signals which are NOT passed to MEM
  val aluSRC = Bool() //not passed further
  val aluOpSelect = AluOperations()
}




