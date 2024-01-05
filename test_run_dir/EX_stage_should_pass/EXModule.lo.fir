FIRRTL version 1.1.0
circuit EXModule :
  module EXModule :
    input clock : Clock
    input reset : UInt<1>
    input io_rs1data : SInt<32>
    input io_rs2dataIn : SInt<32>
    input io_pc : UInt<32>
    input io_rdIn : UInt<5>
    input io_imm : SInt<32>
    input io_aluOpSelect : UInt<4>
    input io_pcSelect : UInt<1>
    output io_branchAddr : UInt<32>
    output io_aluResult : SInt<32>
    output io_rs2DataOut : SInt<32>
    output io_rdOut : UInt<5>
    input io_aluSRC : UInt<1>
    input io_branchIn : UInt<1>
    input io_memReadIn : UInt<1>
    input io_memWriteIn : UInt<1>
    input io_regWriteIn : UInt<1>
    input io_memToRegIn : UInt<1>
    input io_branchCheckIn : UInt<1>
    output io_branchOut : UInt<1>
    output io_memReadOut : UInt<1>
    output io_memWriteOut : UInt<1>
    output io_regWriteOut : UInt<1>
    output io_memToRegOut : UInt<1>
    output io_branchCheckOut : UInt<1>

    reg rs1data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1data) @[EXModule.scala 44:28]
    reg rs2dataIn : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs2dataIn) @[EXModule.scala 45:28]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[EXModule.scala 46:28]
    reg rdIn : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdIn) @[EXModule.scala 47:28]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[EXModule.scala 48:28]
    reg aluOpSelect : UInt<4>, clock with :
      reset => (UInt<1>("h0"), aluOpSelect) @[EXModule.scala 49:29]
    reg aluSRC : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aluSRC) @[EXModule.scala 51:28]
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
    reg branchCheckIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchCheckIn) @[EXModule.scala 57:30]
    reg pcSelect : UInt<1>, clock with :
      reset => (UInt<1>("h0"), pcSelect) @[EXModule.scala 58:28]
    node _io_branchAddr_T = add(rs1data, imm) @[EXModule.scala 62:43]
    node _io_branchAddr_T_1 = tail(_io_branchAddr_T, 1) @[EXModule.scala 62:43]
    node _io_branchAddr_T_2 = asSInt(_io_branchAddr_T_1) @[EXModule.scala 62:43]
    node _io_branchAddr_T_3 = asSInt(pc) @[EXModule.scala 62:53]
    node _io_branchAddr_T_4 = add(_io_branchAddr_T_3, imm) @[EXModule.scala 62:60]
    node _io_branchAddr_T_5 = tail(_io_branchAddr_T_4, 1) @[EXModule.scala 62:60]
    node _io_branchAddr_T_6 = asSInt(_io_branchAddr_T_5) @[EXModule.scala 62:60]
    node _io_branchAddr_T_7 = mux(pcSelect, _io_branchAddr_T_2, _io_branchAddr_T_6) @[EXModule.scala 62:23]
    node _io_branchAddr_T_8 = asUInt(_io_branchAddr_T_7) @[EXModule.scala 62:67]
    node _muxALUinput_T = mux(aluSRC, imm, rs2dataIn) @[EXModule.scala 66:21]
    node _T = asUInt(UInt<1>("h0")) @[EXModule.scala 71:3]
    node _T_1 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_2 = eq(_T, _T_1) @[EXModule.scala 71:3]
    node muxALUinput = _muxALUinput_T @[EXModule.scala 65:32 66:15]
    node _io_aluResult_T = add(rs1data, muxALUinput) @[EXModule.scala 72:37]
    node _io_aluResult_T_1 = tail(_io_aluResult_T, 1) @[EXModule.scala 72:37]
    node _io_aluResult_T_2 = asSInt(_io_aluResult_T_1) @[EXModule.scala 72:37]
    node _T_3 = asUInt(UInt<1>("h1")) @[EXModule.scala 71:3]
    node _T_4 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_5 = eq(_T_3, _T_4) @[EXModule.scala 71:3]
    node _io_aluResult_T_3 = sub(rs1data, muxALUinput) @[EXModule.scala 73:37]
    node _io_aluResult_T_4 = tail(_io_aluResult_T_3, 1) @[EXModule.scala 73:37]
    node _io_aluResult_T_5 = asSInt(_io_aluResult_T_4) @[EXModule.scala 73:37]
    node _T_6 = asUInt(UInt<2>("h2")) @[EXModule.scala 71:3]
    node _T_7 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_8 = eq(_T_6, _T_7) @[EXModule.scala 71:3]
    node _io_aluResult_T_6 = xor(rs1data, muxALUinput) @[EXModule.scala 74:37]
    node _io_aluResult_T_7 = asSInt(_io_aluResult_T_6) @[EXModule.scala 74:37]
    node _T_9 = asUInt(UInt<2>("h3")) @[EXModule.scala 71:3]
    node _T_10 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_11 = eq(_T_9, _T_10) @[EXModule.scala 71:3]
    node _io_aluResult_T_8 = or(rs1data, muxALUinput) @[EXModule.scala 75:37]
    node _io_aluResult_T_9 = asSInt(_io_aluResult_T_8) @[EXModule.scala 75:37]
    node _T_12 = asUInt(UInt<3>("h4")) @[EXModule.scala 71:3]
    node _T_13 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_14 = eq(_T_12, _T_13) @[EXModule.scala 71:3]
    node _io_aluResult_T_10 = and(rs1data, muxALUinput) @[EXModule.scala 76:37]
    node _io_aluResult_T_11 = asSInt(_io_aluResult_T_10) @[EXModule.scala 76:37]
    node _T_15 = asUInt(UInt<3>("h5")) @[EXModule.scala 71:3]
    node _T_16 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_17 = eq(_T_15, _T_16) @[EXModule.scala 71:3]
    node _io_aluResult_T_12 = asUInt(muxALUinput) @[EXModule.scala 77:54]
    node _io_aluResult_T_13 = bits(_io_aluResult_T_12, 4, 0) @[EXModule.scala 77:61]
    node _io_aluResult_T_14 = dshl(rs1data, _io_aluResult_T_13) @[EXModule.scala 77:37]
    node _T_18 = asUInt(UInt<3>("h6")) @[EXModule.scala 71:3]
    node _T_19 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_20 = eq(_T_18, _T_19) @[EXModule.scala 71:3]
    node _io_aluResult_T_15 = asUInt(rs1data) @[EXModule.scala 78:39]
    node _io_aluResult_T_16 = asUInt(muxALUinput) @[EXModule.scala 78:62]
    node _io_aluResult_T_17 = dshr(_io_aluResult_T_15, _io_aluResult_T_16) @[EXModule.scala 78:47]
    node _io_aluResult_T_18 = asSInt(_io_aluResult_T_17) @[EXModule.scala 78:70]
    node _T_21 = asUInt(UInt<3>("h7")) @[EXModule.scala 71:3]
    node _T_22 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_23 = eq(_T_21, _T_22) @[EXModule.scala 71:3]
    node _io_aluResult_T_19 = asUInt(muxALUinput) @[EXModule.scala 79:52]
    node _io_aluResult_T_20 = dshr(rs1data, _io_aluResult_T_19) @[EXModule.scala 79:37]
    node _T_24 = asUInt(UInt<4>("h8")) @[EXModule.scala 71:3]
    node _T_25 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_26 = eq(_T_24, _T_25) @[EXModule.scala 71:3]
    node _T_27 = lt(rs1data, muxALUinput) @[EXModule.scala 81:20]
    node _GEN_0 = mux(_T_27, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[EXModule.scala 81:34 82:22 84:22]
    node _T_28 = asUInt(UInt<4>("h9")) @[EXModule.scala 71:3]
    node _T_29 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_30 = eq(_T_28, _T_29) @[EXModule.scala 71:3]
    node _T_31 = asUInt(rs1data) @[EXModule.scala 88:20]
    node _T_32 = asUInt(muxALUinput) @[EXModule.scala 88:41]
    node _T_33 = lt(_T_31, _T_32) @[EXModule.scala 88:27]
    node _GEN_1 = mux(_T_33, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[EXModule.scala 88:48 89:22 91:22]
    node _T_34 = asUInt(UInt<4>("ha")) @[EXModule.scala 71:3]
    node _T_35 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_36 = eq(_T_34, _T_35) @[EXModule.scala 71:3]
    node _io_aluResult_T_21 = add(pc, UInt<3>("h4")) @[EXModule.scala 94:34]
    node _io_aluResult_T_22 = tail(_io_aluResult_T_21, 1) @[EXModule.scala 94:34]
    node _io_aluResult_T_23 = asSInt(_io_aluResult_T_22) @[EXModule.scala 94:41]
    node _T_37 = asUInt(UInt<4>("hb")) @[EXModule.scala 71:3]
    node _T_38 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_39 = eq(_T_37, _T_38) @[EXModule.scala 71:3]
    node _T_40 = asUInt(UInt<4>("hc")) @[EXModule.scala 71:3]
    node _T_41 = asUInt(aluOpSelect) @[EXModule.scala 71:3]
    node _T_42 = eq(_T_40, _T_41) @[EXModule.scala 71:3]
    node _io_aluResult_T_24 = asSInt(pc) @[EXModule.scala 96:36]
    node _io_aluResult_T_25 = add(_io_aluResult_T_24, imm) @[EXModule.scala 96:43]
    node _io_aluResult_T_26 = tail(_io_aluResult_T_25, 1) @[EXModule.scala 96:43]
    node _io_aluResult_T_27 = asSInt(_io_aluResult_T_26) @[EXModule.scala 96:43]
    node _GEN_2 = mux(_T_42, _io_aluResult_T_27, asSInt(UInt<1>("h0"))) @[EXModule.scala 69:16 71:3 96:29]
    node _GEN_3 = mux(_T_39, imm, _GEN_2) @[EXModule.scala 71:3 95:27]
    node _GEN_4 = mux(_T_36, _io_aluResult_T_23, _GEN_3) @[EXModule.scala 71:3 94:27]
    node _GEN_5 = mux(_T_30, _GEN_1, _GEN_4) @[EXModule.scala 71:3]
    node _GEN_6 = mux(_T_26, _GEN_0, _GEN_5) @[EXModule.scala 71:3]
    node _GEN_7 = mux(_T_23, _io_aluResult_T_20, _GEN_6) @[EXModule.scala 71:3 79:26]
    node _GEN_8 = mux(_T_20, _io_aluResult_T_18, _GEN_7) @[EXModule.scala 71:3 78:26]
    node _GEN_9 = mux(_T_17, _io_aluResult_T_14, _GEN_8) @[EXModule.scala 71:3 77:26]
    node _GEN_10 = mux(_T_14, _io_aluResult_T_11, _GEN_9) @[EXModule.scala 71:3 76:26]
    node _GEN_11 = mux(_T_11, _io_aluResult_T_9, _GEN_10) @[EXModule.scala 71:3 75:26]
    node _GEN_12 = mux(_T_8, _io_aluResult_T_7, _GEN_11) @[EXModule.scala 71:3 74:26]
    node _GEN_13 = mux(_T_5, _io_aluResult_T_5, _GEN_12) @[EXModule.scala 71:3 73:26]
    node _GEN_14 = mux(_T_2, _io_aluResult_T_2, _GEN_13) @[EXModule.scala 71:3 72:26]
    io_branchAddr <= _io_branchAddr_T_8 @[EXModule.scala 62:17]
    io_aluResult <= asSInt(bits(_GEN_14, 31, 0))
    io_rs2DataOut <= rs2dataIn @[EXModule.scala 111:17]
    io_rdOut <= rdIn @[EXModule.scala 110:12]
    io_branchOut <= branchIn @[EXModule.scala 102:16]
    io_memReadOut <= memReadIn @[EXModule.scala 104:17]
    io_memWriteOut <= memWriteIn @[EXModule.scala 105:18]
    io_regWriteOut <= regWriteIn @[EXModule.scala 106:18]
    io_memToRegOut <= memToRegIn @[EXModule.scala 107:18]
    io_branchCheckOut <= branchCheckIn @[EXModule.scala 103:21]
    rs1data <= io_rs1data @[EXModule.scala 44:28]
    rs2dataIn <= io_rs2dataIn @[EXModule.scala 45:28]
    pc <= io_pc @[EXModule.scala 46:28]
    rdIn <= io_rdIn @[EXModule.scala 47:28]
    imm <= io_imm @[EXModule.scala 48:28]
    aluOpSelect <= io_aluOpSelect @[EXModule.scala 49:29]
    aluSRC <= io_aluSRC @[EXModule.scala 51:28]
    branchIn <= io_branchIn @[EXModule.scala 52:28]
    memReadIn <= io_memReadIn @[EXModule.scala 53:28]
    memWriteIn <= io_memWriteIn @[EXModule.scala 54:28]
    regWriteIn <= io_regWriteIn @[EXModule.scala 55:28]
    memToRegIn <= io_memToRegIn @[EXModule.scala 56:28]
    branchCheckIn <= io_branchCheckIn @[EXModule.scala 57:30]
    pcSelect <= io_pcSelect @[EXModule.scala 58:28]
