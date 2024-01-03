FIRRTL version 1.1.0
circuit EXModule :
  module EXModule :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1data : SInt<32>
    input io_rs2dataIn : SInt<32>
    input io_pc : UInt<32>
    input io_rdIn : UInt<5>
    input io_aluControl : UInt<4>
    input io_imm : SInt<32>
    output io_branchAddr : UInt<32>
    output io_aluResult : SInt<32>
    output io_rs2DataOut : SInt<32>
    output io_rdOut : UInt<5>
    input io_aluSRC : UInt<1>
    input io_aluOP : UInt<2>
    input io_branchIn : UInt<1>
    input io_memReadIn : UInt<1>
    input io_memWriteIn : UInt<1>
    input io_regWriteIn : UInt<1>
    input io_memToRegIn : UInt<1>
    output io_branchOut : UInt<1>
    output io_memReadOut : UInt<1>
    output io_memWriteOut : UInt<1>
    output io_regWriteOut : UInt<1>
    output io_memToRegOut : UInt<1>
    output io_branchCheck : UInt<1>

    reg rs1data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1data) @[EXModule.scala 43:28]
    reg rs2dataIn : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs2dataIn) @[EXModule.scala 44:28]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[EXModule.scala 45:28]
    reg rdIn : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdIn) @[EXModule.scala 46:28]
    reg aluControl : UInt<4>, clock with :
      reset => (UInt<1>("h0"), aluControl) @[EXModule.scala 47:28]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[EXModule.scala 48:28]
    reg aluSRC : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aluSRC) @[EXModule.scala 50:28]
    reg aluOP : UInt<2>, clock with :
      reset => (UInt<1>("h0"), aluOP) @[EXModule.scala 51:28]
    reg branchIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchIn) @[EXModule.scala 52:28]
    reg memReadIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memReadIn) @[EXModule.scala 53:28]
    reg memWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memWriteIn) @[EXModule.scala 54:28]
    reg regWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regWriteIn) @[EXModule.scala 55:28]
    reg memToRegIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memToRegIn) @[EXModule.scala 56:28]
    node _io_branchAddr_T = asSInt(pc) @[EXModule.scala 60:24]
    node _io_branchAddr_T_1 = add(_io_branchAddr_T, imm) @[EXModule.scala 60:31]
    node _io_branchAddr_T_2 = tail(_io_branchAddr_T_1, 1) @[EXModule.scala 60:31]
    node _io_branchAddr_T_3 = asSInt(_io_branchAddr_T_2) @[EXModule.scala 60:31]
    node _io_branchAddr_T_4 = asUInt(_io_branchAddr_T_3) @[EXModule.scala 60:38]
    node _muxALUinput_T = mux(aluSRC, imm, rs2dataIn) @[EXModule.scala 64:21]
    node muxALUinput = _muxALUinput_T @[EXModule.scala 63:32 64:15]
    io_branchAddr <= _io_branchAddr_T_4 @[EXModule.scala 60:17]
    io_aluResult <= SInt<32>("h0") @[EXModule.scala 68:16]
    io_rs2DataOut <= rs2dataIn @[EXModule.scala 81:17]
    io_rdOut <= rdIn @[EXModule.scala 80:12]
    io_branchOut <= branchIn @[EXModule.scala 73:16]
    io_memReadOut <= memReadIn @[EXModule.scala 74:17]
    io_memWriteOut <= memWriteIn @[EXModule.scala 75:18]
    io_regWriteOut <= regWriteIn @[EXModule.scala 76:18]
    io_memToRegOut <= memToRegIn @[EXModule.scala 77:18]
    io_branchCheck <= UInt<1>("h0") @[EXModule.scala 67:18]
    rs1data <= io_rs1data @[EXModule.scala 43:28]
    rs2dataIn <= io_rs2dataIn @[EXModule.scala 44:28]
    pc <= io_pc @[EXModule.scala 45:28]
    rdIn <= io_rdIn @[EXModule.scala 46:28]
    aluControl <= io_aluControl @[EXModule.scala 47:28]
    imm <= io_imm @[EXModule.scala 48:28]
    aluSRC <= io_aluSRC @[EXModule.scala 50:28]
    aluOP <= io_aluOP @[EXModule.scala 51:28]
    branchIn <= io_branchIn @[EXModule.scala 52:28]
    memReadIn <= io_memReadIn @[EXModule.scala 53:28]
    memWriteIn <= io_memWriteIn @[EXModule.scala 54:28]
    regWriteIn <= io_regWriteIn @[EXModule.scala 55:28]
    memToRegIn <= io_memToRegIn @[EXModule.scala 56:28]
