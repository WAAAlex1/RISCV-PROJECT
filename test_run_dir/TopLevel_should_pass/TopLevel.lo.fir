FIRRTL version 1.1.0
circuit TopLevel :
  module Memory :
    input clock : Clock
    input reset : UInt<1>
    input io_rdAddr : UInt<10>
    output io_rdData : UInt<32>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>

    mem mem : @[Memory.scala 13:24]
      data-type => UInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_rdData_MPORT
      writer => MPORT
      read-under-write => undefined
    node _GEN_0 = validif(UInt<1>("h1"), io_rdAddr) @[Memory.scala 15:{24,24}]
    node _io_rdData_WIRE = _GEN_0 @[Memory.scala 15:24]
    node _io_rdData_T = or(_io_rdData_WIRE, UInt<10>("h0")) @[Memory.scala 15:24]
    node _io_rdData_T_1 = bits(_io_rdData_T, 9, 0) @[Memory.scala 15:24]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 13:24 15:{24,24}]
    node _GEN_2 = validif(UInt<1>("h1"), _io_rdData_T_1) @[Memory.scala 15:{24,24}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[Memory.scala 15:{24,24}]
    node _GEN_4 = validif(io_wrEna, io_wrAddr) @[Memory.scala 17:18]
    node _GEN_5 = validif(io_wrEna, clock) @[Memory.scala 17:18]
    node _GEN_6 = mux(io_wrEna, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 17:18 13:24]
    node _GEN_7 = validif(io_wrEna, UInt<1>("h1")) @[Memory.scala 17:18]
    node _GEN_8 = validif(io_wrEna, io_wrData) @[Memory.scala 17:18]
    io_rdData <= mem.io_rdData_MPORT.data @[Memory.scala 15:13]
    mem.io_rdData_MPORT.addr <= _GEN_2
    mem.io_rdData_MPORT.en <= _GEN_1
    mem.io_rdData_MPORT.clk <= _GEN_3
    mem.MPORT.addr <= _GEN_4
    mem.MPORT.en <= _GEN_6
    mem.MPORT.clk <= _GEN_5
    mem.MPORT.data <= _GEN_8
    mem.MPORT.mask <= _GEN_7

  module IFModule :
    input clock : Clock
    input reset : UInt<1>
    input io_pcSrc : UInt<1>
    input io_branchAddr : UInt<32>
    output io_instruction : UInt<32>
    output io_pc : UInt<32>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>

    inst instrMem of Memory @[IFModule.scala 20:24]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[IFModule.scala 19:19]
    node _pcAdded_T = add(pc, UInt<1>("h1")) @[IFModule.scala 27:17]
    node _pcAdded_T_1 = tail(_pcAdded_T, 1) @[IFModule.scala 27:17]
    node _pcMux_T = shr(io_branchAddr, 2) @[IFModule.scala 31:40]
    node pcAdded = _pcAdded_T_1 @[IFModule.scala 26:28 27:11]
    node _pcMux_T_1 = mux(io_pcSrc, _pcMux_T, pcAdded) @[IFModule.scala 31:15]
    node _io_pc_T = shl(pc, 2) @[IFModule.scala 41:15]
    node pcMux = _pcMux_T_1 @[IFModule.scala 30:26 31:9]
    io_instruction <= instrMem.io_rdData @[IFModule.scala 38:18]
    io_pc <= bits(_io_pc_T, 31, 0) @[IFModule.scala 41:9]
    pc <= mux(reset, UInt<32>("h0"), pcMux) @[IFModule.scala 19:{19,19} 32:6]
    instrMem.clock <= clock
    instrMem.reset <= reset
    instrMem.io_rdAddr <= bits(pcMux, 9, 0) @[IFModule.scala 35:22]
    instrMem.io_wrAddr <= io_wrAddr @[IFModule.scala 22:22]
    instrMem.io_wrData <= io_wrData @[IFModule.scala 23:22]
    instrMem.io_wrEna <= io_wrEna @[IFModule.scala 21:21]

  module IDModule :
    input clock : Clock
    input reset : UInt<1>
    input io_pcIn : UInt<32>
    input io_writeRegIdx : UInt<5>
    input io_regWriteIn : UInt<1>
    input io_writeRegData : SInt<32>
    input io_instr : UInt<32>
    output io_rs1data : SInt<32>
    output io_rs2data : SInt<32>
    output io_pcOut : UInt<32>
    output io_rd : UInt<5>
    output io_imm : SInt<32>
    output io_aluOpSelect : UInt<4>
    output io_pcSelect : UInt<1>
    output io_regFile_0 : SInt<32>
    output io_regFile_1 : SInt<32>
    output io_regFile_2 : SInt<32>
    output io_regFile_3 : SInt<32>
    output io_regFile_4 : SInt<32>
    output io_regFile_5 : SInt<32>
    output io_regFile_6 : SInt<32>
    output io_regFile_7 : SInt<32>
    output io_regFile_8 : SInt<32>
    output io_regFile_9 : SInt<32>
    output io_regFile_10 : SInt<32>
    output io_regFile_11 : SInt<32>
    output io_regFile_12 : SInt<32>
    output io_regFile_13 : SInt<32>
    output io_regFile_14 : SInt<32>
    output io_regFile_15 : SInt<32>
    output io_regFile_16 : SInt<32>
    output io_regFile_17 : SInt<32>
    output io_regFile_18 : SInt<32>
    output io_regFile_19 : SInt<32>
    output io_regFile_20 : SInt<32>
    output io_regFile_21 : SInt<32>
    output io_regFile_22 : SInt<32>
    output io_regFile_23 : SInt<32>
    output io_regFile_24 : SInt<32>
    output io_regFile_25 : SInt<32>
    output io_regFile_26 : SInt<32>
    output io_regFile_27 : SInt<32>
    output io_regFile_28 : SInt<32>
    output io_regFile_29 : SInt<32>
    output io_regFile_30 : SInt<32>
    output io_regFile_31 : SInt<32>
    output io_aluSRC : UInt<1>
    output io_branch : UInt<1>
    output io_memRead : UInt<1>
    output io_memWrite : UInt<1>
    output io_regWriteOut : UInt<1>
    output io_memToReg : UInt<1>
    output io_branchCheck : UInt<1>
    output io_memSize : UInt<3>
    output io_aluControl : UInt<4>
    output io_aluOPType : UInt<2>

    reg pcIn : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pcIn) @[IDModule.scala 46:21]
    reg instr : UInt<32>, clock with :
      reset => (UInt<1>("h0"), instr) @[IDModule.scala 47:22]
    reg registerFile_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_0) @[IDModule.scala 50:25]
    reg registerFile_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_1) @[IDModule.scala 50:25]
    reg registerFile_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_2) @[IDModule.scala 50:25]
    reg registerFile_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_3) @[IDModule.scala 50:25]
    reg registerFile_4 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_4) @[IDModule.scala 50:25]
    reg registerFile_5 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_5) @[IDModule.scala 50:25]
    reg registerFile_6 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_6) @[IDModule.scala 50:25]
    reg registerFile_7 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_7) @[IDModule.scala 50:25]
    reg registerFile_8 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_8) @[IDModule.scala 50:25]
    reg registerFile_9 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_9) @[IDModule.scala 50:25]
    reg registerFile_10 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_10) @[IDModule.scala 50:25]
    reg registerFile_11 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_11) @[IDModule.scala 50:25]
    reg registerFile_12 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_12) @[IDModule.scala 50:25]
    reg registerFile_13 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_13) @[IDModule.scala 50:25]
    reg registerFile_14 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_14) @[IDModule.scala 50:25]
    reg registerFile_15 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_15) @[IDModule.scala 50:25]
    reg registerFile_16 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_16) @[IDModule.scala 50:25]
    reg registerFile_17 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_17) @[IDModule.scala 50:25]
    reg registerFile_18 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_18) @[IDModule.scala 50:25]
    reg registerFile_19 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_19) @[IDModule.scala 50:25]
    reg registerFile_20 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_20) @[IDModule.scala 50:25]
    reg registerFile_21 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_21) @[IDModule.scala 50:25]
    reg registerFile_22 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_22) @[IDModule.scala 50:25]
    reg registerFile_23 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_23) @[IDModule.scala 50:25]
    reg registerFile_24 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_24) @[IDModule.scala 50:25]
    reg registerFile_25 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_25) @[IDModule.scala 50:25]
    reg registerFile_26 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_26) @[IDModule.scala 50:25]
    reg registerFile_27 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_27) @[IDModule.scala 50:25]
    reg registerFile_28 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_28) @[IDModule.scala 50:25]
    reg registerFile_29 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_29) @[IDModule.scala 50:25]
    reg registerFile_30 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_30) @[IDModule.scala 50:25]
    reg registerFile_31 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), registerFile_31) @[IDModule.scala 50:25]
    node _rs1data_T = bits(instr, 19, 15) @[IDModule.scala 52:35]
    node _rs2data_T = bits(instr, 24, 20) @[IDModule.scala 53:35]
    node _T = bits(instr, 6, 1) @[IDModule.scala 80:15]
    node _T_1 = eq(UInt<5>("h19"), _T) @[IDModule.scala 80:22]
    node _T_2 = eq(UInt<4>("h9"), _T) @[IDModule.scala 80:22]
    node _io_imm_T = bits(instr, 31, 20) @[IDModule.scala 93:24]
    node _io_imm_T_1 = cat(_io_imm_T, UInt<20>("hfffff")) @[IDModule.scala 93:32]
    node _io_imm_T_2 = asSInt(_io_imm_T_1) @[IDModule.scala 93:47]
    node _io_imm_T_3 = shr(_io_imm_T_2, 20) @[IDModule.scala 93:54]
    node _T_3 = eq(UInt<1>("h1"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_4 = bits(instr, 31, 20) @[IDModule.scala 105:23]
    node _io_imm_T_5 = cat(_io_imm_T_4, UInt<20>("hfffff")) @[IDModule.scala 105:31]
    node _io_imm_T_6 = asSInt(_io_imm_T_5) @[IDModule.scala 105:46]
    node _io_imm_T_7 = shr(_io_imm_T_6, 20) @[IDModule.scala 105:53]
    node _T_4 = eq(UInt<6>("h39"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_8 = bits(instr, 31, 20) @[IDModule.scala 118:24]
    node _io_imm_T_9 = cat(_io_imm_T_8, UInt<20>("hfffff")) @[IDModule.scala 118:32]
    node _io_imm_T_10 = asSInt(_io_imm_T_9) @[IDModule.scala 118:48]
    node _io_imm_T_11 = shr(_io_imm_T_10, 20) @[IDModule.scala 118:55]
    node _T_5 = eq(UInt<6>("h33"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_12 = bits(instr, 31, 20) @[IDModule.scala 122:24]
    node _io_imm_T_13 = cat(_io_imm_T_12, UInt<20>("hfffff")) @[IDModule.scala 122:32]
    node _io_imm_T_14 = asSInt(_io_imm_T_13) @[IDModule.scala 122:48]
    node _io_imm_T_15 = shr(_io_imm_T_14, 20) @[IDModule.scala 122:55]
    node _T_6 = eq(UInt<5>("h11"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_16 = bits(instr, 31, 25) @[IDModule.scala 126:24]
    node _io_imm_T_17 = bits(instr, 11, 7) @[IDModule.scala 126:40]
    node _io_imm_T_18 = cat(_io_imm_T_16, _io_imm_T_17) @[IDModule.scala 126:32]
    node _io_imm_T_19 = cat(_io_imm_T_18, UInt<20>("hfffff")) @[IDModule.scala 126:47]
    node _io_imm_T_20 = asSInt(_io_imm_T_19) @[IDModule.scala 126:63]
    node _io_imm_T_21 = shr(_io_imm_T_20, 20) @[IDModule.scala 126:70]
    node _T_7 = eq(UInt<6>("h31"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_22 = bits(instr, 31, 31) @[IDModule.scala 138:24]
    node _io_imm_T_23 = bits(instr, 7, 7) @[IDModule.scala 138:37]
    node _io_imm_T_24 = cat(_io_imm_T_22, _io_imm_T_23) @[IDModule.scala 138:29]
    node _io_imm_T_25 = bits(instr, 30, 25) @[IDModule.scala 138:49]
    node _io_imm_T_26 = cat(_io_imm_T_24, _io_imm_T_25) @[IDModule.scala 138:41]
    node _io_imm_T_27 = bits(instr, 11, 8) @[IDModule.scala 138:65]
    node _io_imm_T_28 = cat(_io_imm_T_26, _io_imm_T_27) @[IDModule.scala 138:57]
    node _io_imm_T_29 = cat(_io_imm_T_28, UInt<20>("hfffff")) @[IDModule.scala 138:72]
    node _io_imm_T_30 = asSInt(_io_imm_T_29) @[IDModule.scala 138:88]
    node _io_imm_T_31 = shr(_io_imm_T_30, 19) @[IDModule.scala 138:95]
    node _T_8 = eq(UInt<6>("h37"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_32 = bits(instr, 31, 31) @[IDModule.scala 149:24]
    node _io_imm_T_33 = bits(instr, 19, 12) @[IDModule.scala 149:37]
    node _io_imm_T_34 = cat(_io_imm_T_32, _io_imm_T_33) @[IDModule.scala 149:29]
    node _io_imm_T_35 = bits(instr, 20, 20) @[IDModule.scala 149:53]
    node _io_imm_T_36 = cat(_io_imm_T_34, _io_imm_T_35) @[IDModule.scala 149:45]
    node _io_imm_T_37 = bits(instr, 30, 22) @[IDModule.scala 149:66]
    node _io_imm_T_38 = cat(_io_imm_T_36, _io_imm_T_37) @[IDModule.scala 149:58]
    node _io_imm_T_39 = cat(_io_imm_T_38, UInt<16>("hfff1")) @[IDModule.scala 149:74]
    node _io_imm_T_40 = asSInt(_io_imm_T_39) @[IDModule.scala 149:89]
    node _io_imm_T_41 = shr(_io_imm_T_40, 11) @[IDModule.scala 149:96]
    node _T_9 = eq(UInt<5>("h1b"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_42 = or(instr, UInt<32>("hfffff000")) @[IDModule.scala 151:35]
    node _io_imm_T_43 = asSInt(_io_imm_T_42) @[IDModule.scala 151:53]
    node _T_10 = eq(UInt<4>("hb"), _T) @[IDModule.scala 80:22]
    node _io_imm_T_44 = or(instr, UInt<32>("hfffff000")) @[IDModule.scala 152:35]
    node _io_imm_T_45 = asSInt(_io_imm_T_44) @[IDModule.scala 152:53]
    node _GEN_0 = mux(_T_10, _io_imm_T_45, asSInt(UInt<1>("h0"))) @[IDModule.scala 80:22 152:24 79:10]
    node _GEN_1 = mux(_T_9, _io_imm_T_43, _GEN_0) @[IDModule.scala 80:22 151:24]
    node _GEN_2 = mux(_T_8, _io_imm_T_41, _GEN_1) @[IDModule.scala 149:14 80:22]
    node _GEN_3 = mux(_T_7, _io_imm_T_31, _GEN_2) @[IDModule.scala 138:14 80:22]
    node _GEN_4 = mux(_T_7, UInt<1>("h0"), UInt<1>("h0")) @[IDModule.scala 141:17 56:13 80:22]
    node _GEN_5 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[IDModule.scala 142:17 57:13 80:22]
    node _GEN_6 = mux(_T_6, _io_imm_T_21, _GEN_3) @[IDModule.scala 126:14 80:22]
    node _GEN_7 = mux(_T_6, UInt<2>("h2"), UInt<2>("h0")) @[IDModule.scala 127:17 80:22 72:30]
    node _GEN_8 = mux(_T_6, UInt<1>("h1"), _GEN_4) @[IDModule.scala 130:17 80:22]
    node _GEN_9 = mux(_T_6, UInt<1>("h0"), _GEN_5) @[IDModule.scala 131:17 80:22]
    node _GEN_10 = mux(_T_6, UInt<1>("h0"), _GEN_4) @[IDModule.scala 132:18 80:22]
    node _GEN_11 = mux(_T_5, _io_imm_T_15, _GEN_6) @[IDModule.scala 122:14 80:22]
    node _GEN_12 = mux(_T_5, UInt<1>("h1"), UInt<1>("h0")) @[IDModule.scala 123:19 62:15 80:22]
    node _GEN_13 = mux(_T_5, UInt<2>("h0"), _GEN_7) @[IDModule.scala 80:22 72:30]
    node _GEN_14 = mux(_T_5, UInt<1>("h0"), _GEN_8) @[IDModule.scala 56:13 80:22]
    node _GEN_15 = mux(_T_5, UInt<1>("h0"), _GEN_9) @[IDModule.scala 57:13 80:22]
    node _GEN_16 = mux(_T_5, UInt<1>("h0"), _GEN_10) @[IDModule.scala 58:14 80:22]
    node _GEN_17 = mux(_T_4, _io_imm_T_11, _GEN_11) @[IDModule.scala 118:14 80:22]
    node _GEN_18 = mux(_T_4, UInt<1>("h0"), _GEN_12) @[IDModule.scala 62:15 80:22]
    node _GEN_19 = mux(_T_4, UInt<2>("h0"), _GEN_13) @[IDModule.scala 80:22 72:30]
    node _GEN_20 = mux(_T_4, UInt<1>("h0"), _GEN_14) @[IDModule.scala 56:13 80:22]
    node _GEN_21 = mux(_T_4, UInt<1>("h0"), _GEN_15) @[IDModule.scala 57:13 80:22]
    node _GEN_22 = mux(_T_4, UInt<1>("h0"), _GEN_16) @[IDModule.scala 58:14 80:22]
    node _GEN_23 = mux(_T_3, _io_imm_T_7, _GEN_17) @[IDModule.scala 105:14 80:22]
    node _GEN_24 = mux(_T_3, UInt<2>("h2"), _GEN_19) @[IDModule.scala 106:17 80:22]
    node _GEN_25 = mux(_T_3, UInt<1>("h1"), _GEN_20) @[IDModule.scala 109:17 80:22]
    node _GEN_26 = mux(_T_3, UInt<1>("h0"), _GEN_21) @[IDModule.scala 110:17 80:22]
    node _GEN_27 = mux(_T_3, UInt<1>("h1"), _GEN_22) @[IDModule.scala 111:18 80:22]
    node _GEN_28 = mux(_T_3, UInt<1>("h0"), _GEN_20) @[IDModule.scala 112:19 80:22]
    node _GEN_29 = mux(_T_3, UInt<1>("h0"), _GEN_18) @[IDModule.scala 62:15 80:22]
    node _GEN_30 = mux(_T_2, _io_imm_T_3, _GEN_23) @[IDModule.scala 80:22 93:14]
    node _GEN_31 = mux(_T_2, UInt<1>("h1"), _GEN_24) @[IDModule.scala 80:22 94:17]
    node _GEN_32 = mux(_T_2, UInt<1>("h1"), _GEN_25) @[IDModule.scala 80:22 97:17]
    node _GEN_33 = mux(_T_2, UInt<1>("h0"), _GEN_26) @[IDModule.scala 80:22 98:17]
    node _GEN_34 = mux(_T_2, UInt<1>("h0"), _GEN_27) @[IDModule.scala 80:22 99:18]
    node _GEN_35 = mux(_T_2, UInt<1>("h0"), _GEN_28) @[IDModule.scala 100:19 80:22]
    node _GEN_36 = mux(_T_2, UInt<1>("h1"), _GEN_27) @[IDModule.scala 101:22 80:22]
    node _GEN_37 = mux(_T_2, UInt<1>("h0"), _GEN_29) @[IDModule.scala 62:15 80:22]
    node _GEN_38 = mux(_T_1, UInt<1>("h0"), _GEN_31) @[IDModule.scala 80:22 82:17]
    node _GEN_39 = mux(_T_1, UInt<1>("h0"), _GEN_32) @[IDModule.scala 80:22 85:17]
    node _GEN_40 = mux(_T_1, UInt<1>("h0"), _GEN_33) @[IDModule.scala 80:22 86:17]
    node _GEN_41 = mux(_T_1, UInt<1>("h0"), _GEN_34) @[IDModule.scala 80:22 87:18]
    node _GEN_42 = mux(_T_1, UInt<1>("h0"), _GEN_35) @[IDModule.scala 80:22 88:19]
    node _GEN_43 = mux(_T_1, UInt<1>("h1"), _GEN_36) @[IDModule.scala 80:22 89:22]
    node _GEN_44 = mux(_T_1, asSInt(UInt<1>("h0")), _GEN_30) @[IDModule.scala 79:10 80:22]
    node _GEN_45 = mux(_T_1, UInt<1>("h0"), _GEN_37) @[IDModule.scala 62:15 80:22]
    node aluOPType = _GEN_38 @[IDModule.scala 72:30]
    node _T_11 = eq(UInt<1>("h0"), aluOPType) @[IDModule.scala 157:20]
    node _T_12 = bits(instr, 30, 30) @[IDModule.scala 159:19]
    node _T_13 = bits(instr, 14, 12) @[IDModule.scala 159:32]
    node _T_14 = cat(_T_12, _T_13) @[IDModule.scala 159:24]
    node _T_15 = eq(UInt<1>("h0"), _T_14) @[IDModule.scala 159:40]
    node _T_16 = eq(UInt<4>("h8"), _T_14) @[IDModule.scala 159:40]
    node _T_17 = eq(UInt<3>("h4"), _T_14) @[IDModule.scala 159:40]
    node _T_18 = eq(UInt<3>("h6"), _T_14) @[IDModule.scala 159:40]
    node _T_19 = eq(UInt<3>("h7"), _T_14) @[IDModule.scala 159:40]
    node _T_20 = eq(UInt<1>("h1"), _T_14) @[IDModule.scala 159:40]
    node _T_21 = eq(UInt<3>("h5"), _T_14) @[IDModule.scala 159:40]
    node _T_22 = eq(UInt<4>("hd"), _T_14) @[IDModule.scala 159:40]
    node _T_23 = eq(UInt<2>("h2"), _T_14) @[IDModule.scala 159:40]
    node _T_24 = eq(UInt<2>("h3"), _T_14) @[IDModule.scala 159:40]
    node _GEN_46 = mux(_T_24, UInt<4>("h9"), UInt<1>("h0")) @[IDModule.scala 156:18 159:40 169:38]
    node _GEN_47 = mux(_T_23, UInt<4>("h8"), _GEN_46) @[IDModule.scala 159:40 168:38]
    node _GEN_48 = mux(_T_22, UInt<3>("h7"), _GEN_47) @[IDModule.scala 159:40 167:38]
    node _GEN_49 = mux(_T_21, UInt<3>("h6"), _GEN_48) @[IDModule.scala 159:40 166:38]
    node _GEN_50 = mux(_T_20, UInt<3>("h5"), _GEN_49) @[IDModule.scala 159:40 165:38]
    node _GEN_51 = mux(_T_19, UInt<3>("h4"), _GEN_50) @[IDModule.scala 159:40 164:38]
    node _GEN_52 = mux(_T_18, UInt<2>("h3"), _GEN_51) @[IDModule.scala 159:40 163:38]
    node _GEN_53 = mux(_T_17, UInt<2>("h2"), _GEN_52) @[IDModule.scala 159:40 162:38]
    node _GEN_54 = mux(_T_16, UInt<1>("h1"), _GEN_53) @[IDModule.scala 159:40 161:38]
    node _GEN_55 = mux(_T_15, UInt<1>("h0"), _GEN_54) @[IDModule.scala 159:40 160:38]
    node _T_25 = eq(UInt<1>("h1"), aluOPType) @[IDModule.scala 157:20]
    node _T_26 = bits(instr, 14, 12) @[IDModule.scala 173:19]
    node _T_27 = eq(UInt<1>("h0"), _T_26) @[IDModule.scala 173:27]
    node _T_28 = eq(UInt<3>("h4"), _T_26) @[IDModule.scala 173:27]
    node _T_29 = eq(UInt<3>("h6"), _T_26) @[IDModule.scala 173:27]
    node _T_30 = eq(UInt<3>("h7"), _T_26) @[IDModule.scala 173:27]
    node _T_31 = eq(UInt<1>("h1"), _T_26) @[IDModule.scala 173:27]
    node _io_aluOpSelect_T = bits(io_imm, 11, 5) @[IDModule.scala 178:50]
    node _io_aluOpSelect_T_1 = eq(_io_aluOpSelect_T, UInt<1>("h0")) @[IDModule.scala 178:57]
    node _io_aluOpSelect_T_2 = mux(_io_aluOpSelect_T_1, UInt<3>("h5"), UInt<1>("h0")) @[IDModule.scala 178:43]
    node _T_32 = eq(UInt<3>("h5"), _T_26) @[IDModule.scala 173:27]
    node _io_aluOpSelect_T_3 = bits(io_imm, 11, 5) @[IDModule.scala 179:50]
    node _io_aluOpSelect_T_4 = eq(_io_aluOpSelect_T_3, UInt<1>("h0")) @[IDModule.scala 179:57]
    node _io_aluOpSelect_T_5 = bits(io_imm, 11, 5) @[IDModule.scala 179:90]
    node _io_aluOpSelect_T_6 = eq(_io_aluOpSelect_T_5, UInt<6>("h20")) @[IDModule.scala 179:96]
    node _io_aluOpSelect_T_7 = mux(_io_aluOpSelect_T_6, UInt<3>("h7"), UInt<1>("h0")) @[IDModule.scala 179:83]
    node _io_aluOpSelect_T_8 = mux(_io_aluOpSelect_T_4, UInt<3>("h6"), _io_aluOpSelect_T_7) @[IDModule.scala 179:43]
    node _T_33 = eq(UInt<2>("h2"), _T_26) @[IDModule.scala 173:27]
    node _T_34 = eq(UInt<2>("h3"), _T_26) @[IDModule.scala 173:27]
    node _GEN_56 = mux(_T_34, UInt<4>("h9"), UInt<1>("h0")) @[IDModule.scala 156:18 173:27 181:37]
    node _GEN_57 = mux(_T_33, UInt<4>("h8"), _GEN_56) @[IDModule.scala 173:27 180:37]
    node _GEN_58 = mux(_T_32, _io_aluOpSelect_T_8, _GEN_57) @[IDModule.scala 173:27 179:37]
    node _GEN_59 = mux(_T_31, _io_aluOpSelect_T_2, _GEN_58) @[IDModule.scala 173:27 178:37]
    node _GEN_60 = mux(_T_30, UInt<3>("h4"), _GEN_59) @[IDModule.scala 173:27 177:37]
    node _GEN_61 = mux(_T_29, UInt<2>("h3"), _GEN_60) @[IDModule.scala 173:27 176:37]
    node _GEN_62 = mux(_T_28, UInt<2>("h2"), _GEN_61) @[IDModule.scala 173:27 175:37]
    node _GEN_63 = mux(_T_27, UInt<1>("h0"), _GEN_62) @[IDModule.scala 173:27 174:37]
    node _T_35 = eq(UInt<2>("h2"), aluOPType) @[IDModule.scala 157:20]
    node _io_memSize_T = bits(instr, 14, 12) @[IDModule.scala 186:26]
    node _GEN_64 = mux(_T_35, UInt<1>("h0"), UInt<1>("h0")) @[IDModule.scala 156:18 157:20 185:22]
    node _GEN_65 = mux(_T_35, _io_memSize_T, UInt<1>("h0")) @[IDModule.scala 157:20 186:18 63:14]
    node _GEN_66 = mux(_T_25, _GEN_63, _GEN_64) @[IDModule.scala 157:20]
    node _GEN_67 = mux(_T_25, UInt<1>("h0"), _GEN_65) @[IDModule.scala 157:20 63:14]
    node _GEN_68 = mux(_T_11, _GEN_55, _GEN_66) @[IDModule.scala 157:20]
    node _GEN_69 = mux(_T_11, UInt<1>("h0"), _GEN_67) @[IDModule.scala 157:20 63:14]
    node _T_36 = bits(instr, 6, 1) @[IDModule.scala 190:15]
    node _T_37 = eq(UInt<6>("h37"), _T_36) @[IDModule.scala 190:21]
    node _T_38 = eq(UInt<6>("h33"), _T_36) @[IDModule.scala 190:21]
    node _T_39 = eq(UInt<5>("h1b"), _T_36) @[IDModule.scala 190:21]
    node _T_40 = eq(UInt<4>("hb"), _T_36) @[IDModule.scala 190:21]
    node _GEN_70 = mux(_T_40, UInt<4>("hc"), _GEN_68) @[IDModule.scala 190:21 194:36]
    node _GEN_71 = mux(_T_39, UInt<4>("hb"), _GEN_70) @[IDModule.scala 190:21 193:36]
    node _GEN_72 = mux(_T_38, UInt<4>("ha"), _GEN_71) @[IDModule.scala 190:21 192:36]
    node _GEN_73 = mux(_T_37, UInt<4>("ha"), _GEN_72) @[IDModule.scala 190:21 191:36]
    node _T_41 = bits(instr, 14, 12) @[IDModule.scala 199:15]
    node _T_42 = eq(UInt<1>("h0"), _T_41) @[IDModule.scala 200:3]
    node _GEN_74 = validif(eq(UInt<1>("h0"), _rs1data_T), registerFile_0) @[IDModule.scala 202:{34,34}]
    node _GEN_75 = mux(eq(UInt<1>("h1"), _rs1data_T), registerFile_1, _GEN_74) @[IDModule.scala 202:{34,34}]
    node _GEN_76 = mux(eq(UInt<2>("h2"), _rs1data_T), registerFile_2, _GEN_75) @[IDModule.scala 202:{34,34}]
    node _GEN_77 = mux(eq(UInt<2>("h3"), _rs1data_T), registerFile_3, _GEN_76) @[IDModule.scala 202:{34,34}]
    node _GEN_78 = mux(eq(UInt<3>("h4"), _rs1data_T), registerFile_4, _GEN_77) @[IDModule.scala 202:{34,34}]
    node _GEN_79 = mux(eq(UInt<3>("h5"), _rs1data_T), registerFile_5, _GEN_78) @[IDModule.scala 202:{34,34}]
    node _GEN_80 = mux(eq(UInt<3>("h6"), _rs1data_T), registerFile_6, _GEN_79) @[IDModule.scala 202:{34,34}]
    node _GEN_81 = mux(eq(UInt<3>("h7"), _rs1data_T), registerFile_7, _GEN_80) @[IDModule.scala 202:{34,34}]
    node _GEN_82 = mux(eq(UInt<4>("h8"), _rs1data_T), registerFile_8, _GEN_81) @[IDModule.scala 202:{34,34}]
    node _GEN_83 = mux(eq(UInt<4>("h9"), _rs1data_T), registerFile_9, _GEN_82) @[IDModule.scala 202:{34,34}]
    node _GEN_84 = mux(eq(UInt<4>("ha"), _rs1data_T), registerFile_10, _GEN_83) @[IDModule.scala 202:{34,34}]
    node _GEN_85 = mux(eq(UInt<4>("hb"), _rs1data_T), registerFile_11, _GEN_84) @[IDModule.scala 202:{34,34}]
    node _GEN_86 = mux(eq(UInt<4>("hc"), _rs1data_T), registerFile_12, _GEN_85) @[IDModule.scala 202:{34,34}]
    node _GEN_87 = mux(eq(UInt<4>("hd"), _rs1data_T), registerFile_13, _GEN_86) @[IDModule.scala 202:{34,34}]
    node _GEN_88 = mux(eq(UInt<4>("he"), _rs1data_T), registerFile_14, _GEN_87) @[IDModule.scala 202:{34,34}]
    node _GEN_89 = mux(eq(UInt<4>("hf"), _rs1data_T), registerFile_15, _GEN_88) @[IDModule.scala 202:{34,34}]
    node _GEN_90 = mux(eq(UInt<5>("h10"), _rs1data_T), registerFile_16, _GEN_89) @[IDModule.scala 202:{34,34}]
    node _GEN_91 = mux(eq(UInt<5>("h11"), _rs1data_T), registerFile_17, _GEN_90) @[IDModule.scala 202:{34,34}]
    node _GEN_92 = mux(eq(UInt<5>("h12"), _rs1data_T), registerFile_18, _GEN_91) @[IDModule.scala 202:{34,34}]
    node _GEN_93 = mux(eq(UInt<5>("h13"), _rs1data_T), registerFile_19, _GEN_92) @[IDModule.scala 202:{34,34}]
    node _GEN_94 = mux(eq(UInt<5>("h14"), _rs1data_T), registerFile_20, _GEN_93) @[IDModule.scala 202:{34,34}]
    node _GEN_95 = mux(eq(UInt<5>("h15"), _rs1data_T), registerFile_21, _GEN_94) @[IDModule.scala 202:{34,34}]
    node _GEN_96 = mux(eq(UInt<5>("h16"), _rs1data_T), registerFile_22, _GEN_95) @[IDModule.scala 202:{34,34}]
    node _GEN_97 = mux(eq(UInt<5>("h17"), _rs1data_T), registerFile_23, _GEN_96) @[IDModule.scala 202:{34,34}]
    node _GEN_98 = mux(eq(UInt<5>("h18"), _rs1data_T), registerFile_24, _GEN_97) @[IDModule.scala 202:{34,34}]
    node _GEN_99 = mux(eq(UInt<5>("h19"), _rs1data_T), registerFile_25, _GEN_98) @[IDModule.scala 202:{34,34}]
    node _GEN_100 = mux(eq(UInt<5>("h1a"), _rs1data_T), registerFile_26, _GEN_99) @[IDModule.scala 202:{34,34}]
    node _GEN_101 = mux(eq(UInt<5>("h1b"), _rs1data_T), registerFile_27, _GEN_100) @[IDModule.scala 202:{34,34}]
    node _GEN_102 = mux(eq(UInt<5>("h1c"), _rs1data_T), registerFile_28, _GEN_101) @[IDModule.scala 202:{34,34}]
    node _GEN_103 = mux(eq(UInt<5>("h1d"), _rs1data_T), registerFile_29, _GEN_102) @[IDModule.scala 202:{34,34}]
    node _GEN_104 = mux(eq(UInt<5>("h1e"), _rs1data_T), registerFile_30, _GEN_103) @[IDModule.scala 202:{34,34}]
    node _GEN_105 = mux(eq(UInt<5>("h1f"), _rs1data_T), registerFile_31, _GEN_104) @[IDModule.scala 202:{34,34}]
    node _GEN_106 = validif(eq(UInt<1>("h0"), _rs2data_T), registerFile_0) @[IDModule.scala 202:{34,34}]
    node _GEN_107 = mux(eq(UInt<1>("h1"), _rs2data_T), registerFile_1, _GEN_106) @[IDModule.scala 202:{34,34}]
    node _GEN_108 = mux(eq(UInt<2>("h2"), _rs2data_T), registerFile_2, _GEN_107) @[IDModule.scala 202:{34,34}]
    node _GEN_109 = mux(eq(UInt<2>("h3"), _rs2data_T), registerFile_3, _GEN_108) @[IDModule.scala 202:{34,34}]
    node _GEN_110 = mux(eq(UInt<3>("h4"), _rs2data_T), registerFile_4, _GEN_109) @[IDModule.scala 202:{34,34}]
    node _GEN_111 = mux(eq(UInt<3>("h5"), _rs2data_T), registerFile_5, _GEN_110) @[IDModule.scala 202:{34,34}]
    node _GEN_112 = mux(eq(UInt<3>("h6"), _rs2data_T), registerFile_6, _GEN_111) @[IDModule.scala 202:{34,34}]
    node _GEN_113 = mux(eq(UInt<3>("h7"), _rs2data_T), registerFile_7, _GEN_112) @[IDModule.scala 202:{34,34}]
    node _GEN_114 = mux(eq(UInt<4>("h8"), _rs2data_T), registerFile_8, _GEN_113) @[IDModule.scala 202:{34,34}]
    node _GEN_115 = mux(eq(UInt<4>("h9"), _rs2data_T), registerFile_9, _GEN_114) @[IDModule.scala 202:{34,34}]
    node _GEN_116 = mux(eq(UInt<4>("ha"), _rs2data_T), registerFile_10, _GEN_115) @[IDModule.scala 202:{34,34}]
    node _GEN_117 = mux(eq(UInt<4>("hb"), _rs2data_T), registerFile_11, _GEN_116) @[IDModule.scala 202:{34,34}]
    node _GEN_118 = mux(eq(UInt<4>("hc"), _rs2data_T), registerFile_12, _GEN_117) @[IDModule.scala 202:{34,34}]
    node _GEN_119 = mux(eq(UInt<4>("hd"), _rs2data_T), registerFile_13, _GEN_118) @[IDModule.scala 202:{34,34}]
    node _GEN_120 = mux(eq(UInt<4>("he"), _rs2data_T), registerFile_14, _GEN_119) @[IDModule.scala 202:{34,34}]
    node _GEN_121 = mux(eq(UInt<4>("hf"), _rs2data_T), registerFile_15, _GEN_120) @[IDModule.scala 202:{34,34}]
    node _GEN_122 = mux(eq(UInt<5>("h10"), _rs2data_T), registerFile_16, _GEN_121) @[IDModule.scala 202:{34,34}]
    node _GEN_123 = mux(eq(UInt<5>("h11"), _rs2data_T), registerFile_17, _GEN_122) @[IDModule.scala 202:{34,34}]
    node _GEN_124 = mux(eq(UInt<5>("h12"), _rs2data_T), registerFile_18, _GEN_123) @[IDModule.scala 202:{34,34}]
    node _GEN_125 = mux(eq(UInt<5>("h13"), _rs2data_T), registerFile_19, _GEN_124) @[IDModule.scala 202:{34,34}]
    node _GEN_126 = mux(eq(UInt<5>("h14"), _rs2data_T), registerFile_20, _GEN_125) @[IDModule.scala 202:{34,34}]
    node _GEN_127 = mux(eq(UInt<5>("h15"), _rs2data_T), registerFile_21, _GEN_126) @[IDModule.scala 202:{34,34}]
    node _GEN_128 = mux(eq(UInt<5>("h16"), _rs2data_T), registerFile_22, _GEN_127) @[IDModule.scala 202:{34,34}]
    node _GEN_129 = mux(eq(UInt<5>("h17"), _rs2data_T), registerFile_23, _GEN_128) @[IDModule.scala 202:{34,34}]
    node _GEN_130 = mux(eq(UInt<5>("h18"), _rs2data_T), registerFile_24, _GEN_129) @[IDModule.scala 202:{34,34}]
    node _GEN_131 = mux(eq(UInt<5>("h19"), _rs2data_T), registerFile_25, _GEN_130) @[IDModule.scala 202:{34,34}]
    node _GEN_132 = mux(eq(UInt<5>("h1a"), _rs2data_T), registerFile_26, _GEN_131) @[IDModule.scala 202:{34,34}]
    node _GEN_133 = mux(eq(UInt<5>("h1b"), _rs2data_T), registerFile_27, _GEN_132) @[IDModule.scala 202:{34,34}]
    node _GEN_134 = mux(eq(UInt<5>("h1c"), _rs2data_T), registerFile_28, _GEN_133) @[IDModule.scala 202:{34,34}]
    node _GEN_135 = mux(eq(UInt<5>("h1d"), _rs2data_T), registerFile_29, _GEN_134) @[IDModule.scala 202:{34,34}]
    node _GEN_136 = mux(eq(UInt<5>("h1e"), _rs2data_T), registerFile_30, _GEN_135) @[IDModule.scala 202:{34,34}]
    node _GEN_137 = mux(eq(UInt<5>("h1f"), _rs2data_T), registerFile_31, _GEN_136) @[IDModule.scala 202:{34,34}]
    node _registerFile_rs1data_T = _GEN_105 @[IDModule.scala 202:34]
    node _registerFile_rs2data_T = _GEN_137 @[IDModule.scala 202:34]
    node _io_branchCheck_T = eq(_registerFile_rs1data_T, _registerFile_rs2data_T) @[IDModule.scala 202:34]
    node _T_43 = eq(UInt<1>("h1"), _T_41) @[IDModule.scala 200:3]
    node _registerFile_rs1data_T_0 = _GEN_105 @[IDModule.scala 205:34]
    node _registerFile_rs2data_T_0 = _GEN_137 @[IDModule.scala 205:34]
    node _io_branchCheck_T_1 = neq(_registerFile_rs1data_T_0, _registerFile_rs2data_T_0) @[IDModule.scala 205:34]
    node _T_44 = eq(UInt<3>("h4"), _T_41) @[IDModule.scala 200:3]
    node _registerFile_rs1data_T_1 = _GEN_105 @[IDModule.scala 208:34]
    node _registerFile_rs2data_T_1 = _GEN_137 @[IDModule.scala 208:34]
    node _io_branchCheck_T_2 = lt(_registerFile_rs1data_T_1, _registerFile_rs2data_T_1) @[IDModule.scala 208:34]
    node _T_45 = eq(UInt<3>("h5"), _T_41) @[IDModule.scala 200:3]
    node _registerFile_rs1data_T_2 = _GEN_105 @[IDModule.scala 211:34]
    node _registerFile_rs2data_T_2 = _GEN_137 @[IDModule.scala 211:34]
    node _io_branchCheck_T_3 = geq(_registerFile_rs1data_T_2, _registerFile_rs2data_T_2) @[IDModule.scala 211:34]
    node _T_46 = eq(UInt<3>("h6"), _T_41) @[IDModule.scala 200:3]
    node _registerFile_rs1data_T_3 = _GEN_105 @[IDModule.scala 214:34]
    node _io_branchCheck_T_4 = asUInt(_registerFile_rs1data_T_3) @[IDModule.scala 214:34]
    node _registerFile_rs2data_T_3 = _GEN_137 @[IDModule.scala 214:51]
    node _io_branchCheck_T_5 = asUInt(_registerFile_rs2data_T_3) @[IDModule.scala 214:51]
    node _io_branchCheck_T_6 = lt(_io_branchCheck_T_4, _io_branchCheck_T_5) @[IDModule.scala 214:41]
    node _T_47 = eq(UInt<3>("h7"), _T_41) @[IDModule.scala 200:3]
    node _registerFile_rs1data_T_4 = _GEN_105 @[IDModule.scala 217:34]
    node _io_branchCheck_T_7 = asUInt(_registerFile_rs1data_T_4) @[IDModule.scala 217:34]
    node _registerFile_rs2data_T_4 = _GEN_137 @[IDModule.scala 217:52]
    node _io_branchCheck_T_8 = asUInt(_registerFile_rs2data_T_4) @[IDModule.scala 217:52]
    node _io_branchCheck_T_9 = geq(_io_branchCheck_T_7, _io_branchCheck_T_8) @[IDModule.scala 217:41]
    node _GEN_138 = mux(_T_47, _io_branchCheck_T_9, UInt<1>("h0")) @[IDModule.scala 198:18 200:3 217:22]
    node _GEN_139 = mux(_T_46, _io_branchCheck_T_6, _GEN_138) @[IDModule.scala 200:3 214:22]
    node _GEN_140 = mux(_T_45, _io_branchCheck_T_3, _GEN_139) @[IDModule.scala 200:3 211:22]
    node _GEN_141 = mux(_T_44, _io_branchCheck_T_2, _GEN_140) @[IDModule.scala 200:3 208:22]
    node _GEN_142 = mux(_T_43, _io_branchCheck_T_1, _GEN_141) @[IDModule.scala 200:3 205:22]
    node _GEN_143 = mux(_T_42, _io_branchCheck_T, _GEN_142) @[IDModule.scala 200:3 202:22]
    node _registerFile_io_writeRegIdx = io_writeRegData @[IDModule.scala 223:{34,34}]
    node _GEN_144 = mux(eq(UInt<1>("h0"), io_writeRegIdx), _registerFile_io_writeRegIdx, asSInt(UInt<1>("h0"))) @[IDModule.scala 223:{34,34} 51:19]
    node _GEN_145 = mux(eq(UInt<1>("h1"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_1) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_146 = mux(eq(UInt<2>("h2"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_2) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_147 = mux(eq(UInt<2>("h3"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_3) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_148 = mux(eq(UInt<3>("h4"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_4) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_149 = mux(eq(UInt<3>("h5"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_5) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_150 = mux(eq(UInt<3>("h6"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_6) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_151 = mux(eq(UInt<3>("h7"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_7) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_152 = mux(eq(UInt<4>("h8"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_8) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_153 = mux(eq(UInt<4>("h9"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_9) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_154 = mux(eq(UInt<4>("ha"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_10) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_155 = mux(eq(UInt<4>("hb"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_11) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_156 = mux(eq(UInt<4>("hc"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_12) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_157 = mux(eq(UInt<4>("hd"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_13) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_158 = mux(eq(UInt<4>("he"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_14) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_159 = mux(eq(UInt<4>("hf"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_15) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_160 = mux(eq(UInt<5>("h10"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_16) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_161 = mux(eq(UInt<5>("h11"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_17) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_162 = mux(eq(UInt<5>("h12"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_18) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_163 = mux(eq(UInt<5>("h13"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_19) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_164 = mux(eq(UInt<5>("h14"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_20) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_165 = mux(eq(UInt<5>("h15"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_21) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_166 = mux(eq(UInt<5>("h16"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_22) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_167 = mux(eq(UInt<5>("h17"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_23) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_168 = mux(eq(UInt<5>("h18"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_24) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_169 = mux(eq(UInt<5>("h19"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_25) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_170 = mux(eq(UInt<5>("h1a"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_26) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_171 = mux(eq(UInt<5>("h1b"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_27) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_172 = mux(eq(UInt<5>("h1c"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_28) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_173 = mux(eq(UInt<5>("h1d"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_29) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_174 = mux(eq(UInt<5>("h1e"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_30) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_175 = mux(eq(UInt<5>("h1f"), io_writeRegIdx), _registerFile_io_writeRegIdx, registerFile_31) @[IDModule.scala 223:{34,34} 50:25]
    node _GEN_176 = mux(io_regWriteIn, _GEN_144, asSInt(UInt<1>("h0"))) @[IDModule.scala 222:22 51:19]
    node _GEN_177 = mux(io_regWriteIn, _GEN_145, registerFile_1) @[IDModule.scala 222:22 50:25]
    node _GEN_178 = mux(io_regWriteIn, _GEN_146, registerFile_2) @[IDModule.scala 222:22 50:25]
    node _GEN_179 = mux(io_regWriteIn, _GEN_147, registerFile_3) @[IDModule.scala 222:22 50:25]
    node _GEN_180 = mux(io_regWriteIn, _GEN_148, registerFile_4) @[IDModule.scala 222:22 50:25]
    node _GEN_181 = mux(io_regWriteIn, _GEN_149, registerFile_5) @[IDModule.scala 222:22 50:25]
    node _GEN_182 = mux(io_regWriteIn, _GEN_150, registerFile_6) @[IDModule.scala 222:22 50:25]
    node _GEN_183 = mux(io_regWriteIn, _GEN_151, registerFile_7) @[IDModule.scala 222:22 50:25]
    node _GEN_184 = mux(io_regWriteIn, _GEN_152, registerFile_8) @[IDModule.scala 222:22 50:25]
    node _GEN_185 = mux(io_regWriteIn, _GEN_153, registerFile_9) @[IDModule.scala 222:22 50:25]
    node _GEN_186 = mux(io_regWriteIn, _GEN_154, registerFile_10) @[IDModule.scala 222:22 50:25]
    node _GEN_187 = mux(io_regWriteIn, _GEN_155, registerFile_11) @[IDModule.scala 222:22 50:25]
    node _GEN_188 = mux(io_regWriteIn, _GEN_156, registerFile_12) @[IDModule.scala 222:22 50:25]
    node _GEN_189 = mux(io_regWriteIn, _GEN_157, registerFile_13) @[IDModule.scala 222:22 50:25]
    node _GEN_190 = mux(io_regWriteIn, _GEN_158, registerFile_14) @[IDModule.scala 222:22 50:25]
    node _GEN_191 = mux(io_regWriteIn, _GEN_159, registerFile_15) @[IDModule.scala 222:22 50:25]
    node _GEN_192 = mux(io_regWriteIn, _GEN_160, registerFile_16) @[IDModule.scala 222:22 50:25]
    node _GEN_193 = mux(io_regWriteIn, _GEN_161, registerFile_17) @[IDModule.scala 222:22 50:25]
    node _GEN_194 = mux(io_regWriteIn, _GEN_162, registerFile_18) @[IDModule.scala 222:22 50:25]
    node _GEN_195 = mux(io_regWriteIn, _GEN_163, registerFile_19) @[IDModule.scala 222:22 50:25]
    node _GEN_196 = mux(io_regWriteIn, _GEN_164, registerFile_20) @[IDModule.scala 222:22 50:25]
    node _GEN_197 = mux(io_regWriteIn, _GEN_165, registerFile_21) @[IDModule.scala 222:22 50:25]
    node _GEN_198 = mux(io_regWriteIn, _GEN_166, registerFile_22) @[IDModule.scala 222:22 50:25]
    node _GEN_199 = mux(io_regWriteIn, _GEN_167, registerFile_23) @[IDModule.scala 222:22 50:25]
    node _GEN_200 = mux(io_regWriteIn, _GEN_168, registerFile_24) @[IDModule.scala 222:22 50:25]
    node _GEN_201 = mux(io_regWriteIn, _GEN_169, registerFile_25) @[IDModule.scala 222:22 50:25]
    node _GEN_202 = mux(io_regWriteIn, _GEN_170, registerFile_26) @[IDModule.scala 222:22 50:25]
    node _GEN_203 = mux(io_regWriteIn, _GEN_171, registerFile_27) @[IDModule.scala 222:22 50:25]
    node _GEN_204 = mux(io_regWriteIn, _GEN_172, registerFile_28) @[IDModule.scala 222:22 50:25]
    node _GEN_205 = mux(io_regWriteIn, _GEN_173, registerFile_29) @[IDModule.scala 222:22 50:25]
    node _GEN_206 = mux(io_regWriteIn, _GEN_174, registerFile_30) @[IDModule.scala 222:22 50:25]
    node _GEN_207 = mux(io_regWriteIn, _GEN_175, registerFile_31) @[IDModule.scala 222:22 50:25]
    node _io_rd_T = bits(instr, 11, 7) @[IDModule.scala 230:17]
    node _io_aluControl_T = bits(instr, 30, 30) @[IDModule.scala 234:25]
    node _io_aluControl_T_1 = bits(instr, 14, 12) @[IDModule.scala 234:38]
    node _io_aluControl_T_2 = cat(_io_aluControl_T, _io_aluControl_T_1) @[IDModule.scala 234:30]
    node _registerFile_rs1data_T_5 = _GEN_105 @[IDModule.scala 228:14]
    node _registerFile_rs2data_T_5 = _GEN_137 @[IDModule.scala 229:14]
    io_rs1data <= _registerFile_rs1data_T_5 @[IDModule.scala 228:14]
    io_rs2data <= _registerFile_rs2data_T_5 @[IDModule.scala 229:14]
    io_pcOut <= pcIn @[IDModule.scala 227:12]
    io_rd <= _io_rd_T @[IDModule.scala 230:9]
    io_imm <= _GEN_44
    io_aluOpSelect <= _GEN_73
    io_pcSelect <= _GEN_45
    io_regFile_0 <= registerFile_0 @[IDModule.scala 231:14]
    io_regFile_1 <= registerFile_1 @[IDModule.scala 231:14]
    io_regFile_2 <= registerFile_2 @[IDModule.scala 231:14]
    io_regFile_3 <= registerFile_3 @[IDModule.scala 231:14]
    io_regFile_4 <= registerFile_4 @[IDModule.scala 231:14]
    io_regFile_5 <= registerFile_5 @[IDModule.scala 231:14]
    io_regFile_6 <= registerFile_6 @[IDModule.scala 231:14]
    io_regFile_7 <= registerFile_7 @[IDModule.scala 231:14]
    io_regFile_8 <= registerFile_8 @[IDModule.scala 231:14]
    io_regFile_9 <= registerFile_9 @[IDModule.scala 231:14]
    io_regFile_10 <= registerFile_10 @[IDModule.scala 231:14]
    io_regFile_11 <= registerFile_11 @[IDModule.scala 231:14]
    io_regFile_12 <= registerFile_12 @[IDModule.scala 231:14]
    io_regFile_13 <= registerFile_13 @[IDModule.scala 231:14]
    io_regFile_14 <= registerFile_14 @[IDModule.scala 231:14]
    io_regFile_15 <= registerFile_15 @[IDModule.scala 231:14]
    io_regFile_16 <= registerFile_16 @[IDModule.scala 231:14]
    io_regFile_17 <= registerFile_17 @[IDModule.scala 231:14]
    io_regFile_18 <= registerFile_18 @[IDModule.scala 231:14]
    io_regFile_19 <= registerFile_19 @[IDModule.scala 231:14]
    io_regFile_20 <= registerFile_20 @[IDModule.scala 231:14]
    io_regFile_21 <= registerFile_21 @[IDModule.scala 231:14]
    io_regFile_22 <= registerFile_22 @[IDModule.scala 231:14]
    io_regFile_23 <= registerFile_23 @[IDModule.scala 231:14]
    io_regFile_24 <= registerFile_24 @[IDModule.scala 231:14]
    io_regFile_25 <= registerFile_25 @[IDModule.scala 231:14]
    io_regFile_26 <= registerFile_26 @[IDModule.scala 231:14]
    io_regFile_27 <= registerFile_27 @[IDModule.scala 231:14]
    io_regFile_28 <= registerFile_28 @[IDModule.scala 231:14]
    io_regFile_29 <= registerFile_29 @[IDModule.scala 231:14]
    io_regFile_30 <= registerFile_30 @[IDModule.scala 231:14]
    io_regFile_31 <= registerFile_31 @[IDModule.scala 231:14]
    io_aluSRC <= _GEN_39
    io_branch <= _GEN_40
    io_memRead <= _GEN_41
    io_memWrite <= _GEN_42
    io_regWriteOut <= _GEN_43
    io_memToReg <= _GEN_41
    io_branchCheck <= _GEN_143
    io_memSize <= _GEN_69
    io_aluControl <= _io_aluControl_T_2 @[IDModule.scala 234:17]
    io_aluOPType <= aluOPType @[IDModule.scala 235:16]
    pcIn <= io_pcIn @[IDModule.scala 46:21]
    instr <= io_instr @[IDModule.scala 47:22]
    registerFile_0 <= _GEN_176
    registerFile_1 <= _GEN_177
    registerFile_2 <= _GEN_178
    registerFile_3 <= _GEN_179
    registerFile_4 <= _GEN_180
    registerFile_5 <= _GEN_181
    registerFile_6 <= _GEN_182
    registerFile_7 <= _GEN_183
    registerFile_8 <= _GEN_184
    registerFile_9 <= _GEN_185
    registerFile_10 <= _GEN_186
    registerFile_11 <= _GEN_187
    registerFile_12 <= _GEN_188
    registerFile_13 <= _GEN_189
    registerFile_14 <= _GEN_190
    registerFile_15 <= _GEN_191
    registerFile_16 <= _GEN_192
    registerFile_17 <= _GEN_193
    registerFile_18 <= _GEN_194
    registerFile_19 <= _GEN_195
    registerFile_20 <= _GEN_196
    registerFile_21 <= _GEN_197
    registerFile_22 <= _GEN_198
    registerFile_23 <= _GEN_199
    registerFile_24 <= _GEN_200
    registerFile_25 <= _GEN_201
    registerFile_26 <= _GEN_202
    registerFile_27 <= _GEN_203
    registerFile_28 <= _GEN_204
    registerFile_29 <= _GEN_205
    registerFile_30 <= _GEN_206
    registerFile_31 <= _GEN_207

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
    input io_memSizeIn : UInt<3>
    output io_branchOut : UInt<1>
    output io_memReadOut : UInt<1>
    output io_memWriteOut : UInt<1>
    output io_regWriteOut : UInt<1>
    output io_memToRegOut : UInt<1>
    output io_branchCheckOut : UInt<1>
    output io_memSizeOut : UInt<3>

    reg rs1data : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs1data) @[EXModule.scala 46:28]
    reg rs2dataIn : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rs2dataIn) @[EXModule.scala 47:28]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[EXModule.scala 48:28]
    reg rdIn : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdIn) @[EXModule.scala 49:28]
    reg imm : SInt<32>, clock with :
      reset => (UInt<1>("h0"), imm) @[EXModule.scala 50:28]
    reg aluOpSelect : UInt<4>, clock with :
      reset => (UInt<1>("h0"), aluOpSelect) @[EXModule.scala 51:29]
    reg aluSRC : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aluSRC) @[EXModule.scala 53:28]
    reg branchIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchIn) @[EXModule.scala 54:28]
    reg memReadIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memReadIn) @[EXModule.scala 55:28]
    reg memWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memWriteIn) @[EXModule.scala 56:28]
    reg regWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regWriteIn) @[EXModule.scala 57:28]
    reg memToRegIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memToRegIn) @[EXModule.scala 58:28]
    reg branchCheckIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchCheckIn) @[EXModule.scala 59:30]
    reg pcSelect : UInt<1>, clock with :
      reset => (UInt<1>("h0"), pcSelect) @[EXModule.scala 60:28]
    reg memSizeIn : UInt<3>, clock with :
      reset => (UInt<1>("h0"), memSizeIn) @[EXModule.scala 61:28]
    node _io_branchAddr_T = add(rs1data, imm) @[EXModule.scala 65:43]
    node _io_branchAddr_T_1 = tail(_io_branchAddr_T, 1) @[EXModule.scala 65:43]
    node _io_branchAddr_T_2 = asSInt(_io_branchAddr_T_1) @[EXModule.scala 65:43]
    node _io_branchAddr_T_3 = asSInt(pc) @[EXModule.scala 65:53]
    node _io_branchAddr_T_4 = add(_io_branchAddr_T_3, imm) @[EXModule.scala 65:60]
    node _io_branchAddr_T_5 = tail(_io_branchAddr_T_4, 1) @[EXModule.scala 65:60]
    node _io_branchAddr_T_6 = asSInt(_io_branchAddr_T_5) @[EXModule.scala 65:60]
    node _io_branchAddr_T_7 = mux(pcSelect, _io_branchAddr_T_2, _io_branchAddr_T_6) @[EXModule.scala 65:23]
    node _io_branchAddr_T_8 = asUInt(_io_branchAddr_T_7) @[EXModule.scala 65:67]
    node _muxALUinput_T = mux(aluSRC, imm, rs2dataIn) @[EXModule.scala 69:21]
    node _T = asUInt(UInt<1>("h0")) @[EXModule.scala 74:3]
    node _T_1 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_2 = eq(_T, _T_1) @[EXModule.scala 74:3]
    node muxALUinput = _muxALUinput_T @[EXModule.scala 68:32 69:15]
    node _io_aluResult_T = add(rs1data, muxALUinput) @[EXModule.scala 75:37]
    node _io_aluResult_T_1 = tail(_io_aluResult_T, 1) @[EXModule.scala 75:37]
    node _io_aluResult_T_2 = asSInt(_io_aluResult_T_1) @[EXModule.scala 75:37]
    node _T_3 = asUInt(UInt<1>("h1")) @[EXModule.scala 74:3]
    node _T_4 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_5 = eq(_T_3, _T_4) @[EXModule.scala 74:3]
    node _io_aluResult_T_3 = sub(rs1data, muxALUinput) @[EXModule.scala 76:37]
    node _io_aluResult_T_4 = tail(_io_aluResult_T_3, 1) @[EXModule.scala 76:37]
    node _io_aluResult_T_5 = asSInt(_io_aluResult_T_4) @[EXModule.scala 76:37]
    node _T_6 = asUInt(UInt<2>("h2")) @[EXModule.scala 74:3]
    node _T_7 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_8 = eq(_T_6, _T_7) @[EXModule.scala 74:3]
    node _io_aluResult_T_6 = xor(rs1data, muxALUinput) @[EXModule.scala 77:37]
    node _io_aluResult_T_7 = asSInt(_io_aluResult_T_6) @[EXModule.scala 77:37]
    node _T_9 = asUInt(UInt<2>("h3")) @[EXModule.scala 74:3]
    node _T_10 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_11 = eq(_T_9, _T_10) @[EXModule.scala 74:3]
    node _io_aluResult_T_8 = or(rs1data, muxALUinput) @[EXModule.scala 78:37]
    node _io_aluResult_T_9 = asSInt(_io_aluResult_T_8) @[EXModule.scala 78:37]
    node _T_12 = asUInt(UInt<3>("h4")) @[EXModule.scala 74:3]
    node _T_13 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_14 = eq(_T_12, _T_13) @[EXModule.scala 74:3]
    node _io_aluResult_T_10 = and(rs1data, muxALUinput) @[EXModule.scala 79:37]
    node _io_aluResult_T_11 = asSInt(_io_aluResult_T_10) @[EXModule.scala 79:37]
    node _T_15 = asUInt(UInt<3>("h5")) @[EXModule.scala 74:3]
    node _T_16 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_17 = eq(_T_15, _T_16) @[EXModule.scala 74:3]
    node _io_aluResult_T_12 = asUInt(muxALUinput) @[EXModule.scala 80:54]
    node _io_aluResult_T_13 = bits(_io_aluResult_T_12, 4, 0) @[EXModule.scala 80:61]
    node _io_aluResult_T_14 = dshl(rs1data, _io_aluResult_T_13) @[EXModule.scala 80:37]
    node _T_18 = asUInt(UInt<3>("h6")) @[EXModule.scala 74:3]
    node _T_19 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_20 = eq(_T_18, _T_19) @[EXModule.scala 74:3]
    node _io_aluResult_T_15 = asUInt(rs1data) @[EXModule.scala 81:39]
    node _io_aluResult_T_16 = asUInt(muxALUinput) @[EXModule.scala 81:62]
    node _io_aluResult_T_17 = dshr(_io_aluResult_T_15, _io_aluResult_T_16) @[EXModule.scala 81:47]
    node _io_aluResult_T_18 = asSInt(_io_aluResult_T_17) @[EXModule.scala 81:70]
    node _T_21 = asUInt(UInt<3>("h7")) @[EXModule.scala 74:3]
    node _T_22 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_23 = eq(_T_21, _T_22) @[EXModule.scala 74:3]
    node _io_aluResult_T_19 = asUInt(muxALUinput) @[EXModule.scala 82:52]
    node _io_aluResult_T_20 = dshr(rs1data, _io_aluResult_T_19) @[EXModule.scala 82:37]
    node _T_24 = asUInt(UInt<4>("h8")) @[EXModule.scala 74:3]
    node _T_25 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_26 = eq(_T_24, _T_25) @[EXModule.scala 74:3]
    node _T_27 = lt(rs1data, muxALUinput) @[EXModule.scala 84:20]
    node _GEN_0 = mux(_T_27, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[EXModule.scala 84:34 85:22 87:22]
    node _T_28 = asUInt(UInt<4>("h9")) @[EXModule.scala 74:3]
    node _T_29 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_30 = eq(_T_28, _T_29) @[EXModule.scala 74:3]
    node _T_31 = asUInt(rs1data) @[EXModule.scala 91:20]
    node _T_32 = asUInt(muxALUinput) @[EXModule.scala 91:41]
    node _T_33 = lt(_T_31, _T_32) @[EXModule.scala 91:27]
    node _GEN_1 = mux(_T_33, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[EXModule.scala 91:48 92:22 94:22]
    node _T_34 = asUInt(UInt<4>("ha")) @[EXModule.scala 74:3]
    node _T_35 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_36 = eq(_T_34, _T_35) @[EXModule.scala 74:3]
    node _io_aluResult_T_21 = add(pc, UInt<3>("h4")) @[EXModule.scala 97:34]
    node _io_aluResult_T_22 = tail(_io_aluResult_T_21, 1) @[EXModule.scala 97:34]
    node _io_aluResult_T_23 = asSInt(_io_aluResult_T_22) @[EXModule.scala 97:41]
    node _T_37 = asUInt(UInt<4>("hb")) @[EXModule.scala 74:3]
    node _T_38 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_39 = eq(_T_37, _T_38) @[EXModule.scala 74:3]
    node _T_40 = asUInt(UInt<4>("hc")) @[EXModule.scala 74:3]
    node _T_41 = asUInt(aluOpSelect) @[EXModule.scala 74:3]
    node _T_42 = eq(_T_40, _T_41) @[EXModule.scala 74:3]
    node _io_aluResult_T_24 = asSInt(pc) @[EXModule.scala 99:36]
    node _io_aluResult_T_25 = add(_io_aluResult_T_24, imm) @[EXModule.scala 99:43]
    node _io_aluResult_T_26 = tail(_io_aluResult_T_25, 1) @[EXModule.scala 99:43]
    node _io_aluResult_T_27 = asSInt(_io_aluResult_T_26) @[EXModule.scala 99:43]
    node _GEN_2 = mux(_T_42, _io_aluResult_T_27, asSInt(UInt<1>("h0"))) @[EXModule.scala 72:16 74:3 99:29]
    node _GEN_3 = mux(_T_39, imm, _GEN_2) @[EXModule.scala 74:3 98:27]
    node _GEN_4 = mux(_T_36, _io_aluResult_T_23, _GEN_3) @[EXModule.scala 74:3 97:27]
    node _GEN_5 = mux(_T_30, _GEN_1, _GEN_4) @[EXModule.scala 74:3]
    node _GEN_6 = mux(_T_26, _GEN_0, _GEN_5) @[EXModule.scala 74:3]
    node _GEN_7 = mux(_T_23, _io_aluResult_T_20, _GEN_6) @[EXModule.scala 74:3 82:26]
    node _GEN_8 = mux(_T_20, _io_aluResult_T_18, _GEN_7) @[EXModule.scala 74:3 81:26]
    node _GEN_9 = mux(_T_17, _io_aluResult_T_14, _GEN_8) @[EXModule.scala 74:3 80:26]
    node _GEN_10 = mux(_T_14, _io_aluResult_T_11, _GEN_9) @[EXModule.scala 74:3 79:26]
    node _GEN_11 = mux(_T_11, _io_aluResult_T_9, _GEN_10) @[EXModule.scala 74:3 78:26]
    node _GEN_12 = mux(_T_8, _io_aluResult_T_7, _GEN_11) @[EXModule.scala 74:3 77:26]
    node _GEN_13 = mux(_T_5, _io_aluResult_T_5, _GEN_12) @[EXModule.scala 74:3 76:26]
    node _GEN_14 = mux(_T_2, _io_aluResult_T_2, _GEN_13) @[EXModule.scala 74:3 75:26]
    io_branchAddr <= _io_branchAddr_T_8 @[EXModule.scala 65:17]
    io_aluResult <= asSInt(bits(_GEN_14, 31, 0))
    io_rs2DataOut <= rs2dataIn @[EXModule.scala 115:17]
    io_rdOut <= rdIn @[EXModule.scala 114:12]
    io_branchOut <= branchIn @[EXModule.scala 105:16]
    io_memReadOut <= memReadIn @[EXModule.scala 107:17]
    io_memWriteOut <= memWriteIn @[EXModule.scala 108:18]
    io_regWriteOut <= regWriteIn @[EXModule.scala 109:18]
    io_memToRegOut <= memToRegIn @[EXModule.scala 110:18]
    io_branchCheckOut <= branchCheckIn @[EXModule.scala 106:21]
    io_memSizeOut <= memSizeIn @[EXModule.scala 111:17]
    rs1data <= io_rs1data @[EXModule.scala 46:28]
    rs2dataIn <= io_rs2dataIn @[EXModule.scala 47:28]
    pc <= io_pc @[EXModule.scala 48:28]
    rdIn <= io_rdIn @[EXModule.scala 49:28]
    imm <= io_imm @[EXModule.scala 50:28]
    aluOpSelect <= io_aluOpSelect @[EXModule.scala 51:29]
    aluSRC <= io_aluSRC @[EXModule.scala 53:28]
    branchIn <= io_branchIn @[EXModule.scala 54:28]
    memReadIn <= io_memReadIn @[EXModule.scala 55:28]
    memWriteIn <= io_memWriteIn @[EXModule.scala 56:28]
    regWriteIn <= io_regWriteIn @[EXModule.scala 57:28]
    memToRegIn <= io_memToRegIn @[EXModule.scala 58:28]
    branchCheckIn <= io_branchCheckIn @[EXModule.scala 59:30]
    pcSelect <= io_pcSelect @[EXModule.scala 60:28]
    memSizeIn <= io_memSizeIn @[EXModule.scala 61:28]

  module Memory_1 :
    input clock : Clock
    input reset : UInt<1>
    input io_rdAddr : UInt<10>
    output io_rdData : UInt<32>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>

    mem mem : @[Memory.scala 13:24]
      data-type => UInt<8>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_rdData_MPORT
      writer => MPORT
      read-under-write => undefined
    node _GEN_0 = validif(UInt<1>("h1"), io_rdAddr) @[Memory.scala 15:{24,24}]
    node _io_rdData_WIRE = _GEN_0 @[Memory.scala 15:24]
    node _io_rdData_T = or(_io_rdData_WIRE, UInt<10>("h0")) @[Memory.scala 15:24]
    node _io_rdData_T_1 = bits(_io_rdData_T, 9, 0) @[Memory.scala 15:24]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 13:24 15:{24,24}]
    node _GEN_2 = validif(UInt<1>("h1"), _io_rdData_T_1) @[Memory.scala 15:{24,24}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[Memory.scala 15:{24,24}]
    node _GEN_4 = validif(io_wrEna, io_wrAddr) @[Memory.scala 17:18]
    node _GEN_5 = validif(io_wrEna, clock) @[Memory.scala 17:18]
    node _GEN_6 = mux(io_wrEna, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 17:18 13:24]
    node _GEN_7 = validif(io_wrEna, UInt<1>("h1")) @[Memory.scala 17:18]
    node _GEN_8 = validif(io_wrEna, io_wrData) @[Memory.scala 17:18]
    io_rdData <= pad(mem.io_rdData_MPORT.data, 32) @[Memory.scala 15:13]
    mem.io_rdData_MPORT.addr <= _GEN_2
    mem.io_rdData_MPORT.en <= _GEN_1
    mem.io_rdData_MPORT.clk <= _GEN_3
    mem.MPORT.addr <= _GEN_4
    mem.MPORT.en <= _GEN_6
    mem.MPORT.clk <= _GEN_5
    mem.MPORT.data <= bits(_GEN_8, 7, 0)
    mem.MPORT.mask <= _GEN_7

  module MEMModule :
    input clock : Clock
    input reset : UInt<1>
    input io_branchAddrIn : UInt<32>
    input io_aluResult : SInt<32>
    input io_rs2Data : SInt<32>
    input io_rdIn : UInt<5>
    output io_regWriteData : SInt<32>
    output io_rdOut : UInt<5>
    output io_branchAddrOut : UInt<32>
    output io_pcSrc : UInt<1>
    input io_branch : UInt<1>
    input io_memRead : UInt<1>
    input io_memWrite : UInt<1>
    input io_regWriteIn : UInt<1>
    input io_memToReg : UInt<1>
    input io_branchCheck : UInt<1>
    input io_memSize : UInt<3>
    output io_regWriteOut : UInt<1>

    inst memory of Memory_1 @[MEMModule.scala 47:22]
    reg aluResult : SInt<32>, clock with :
      reset => (UInt<1>("h0"), aluResult) @[MEMModule.scala 34:26]
    reg rdIn : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdIn) @[MEMModule.scala 35:21]
    reg branchCheck : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchCheck) @[MEMModule.scala 36:28]
    reg branch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branch) @[MEMModule.scala 37:23]
    reg regWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regWriteIn) @[MEMModule.scala 38:27]
    reg memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memToReg) @[MEMModule.scala 39:25]
    reg branchAddrIn : UInt<32>, clock with :
      reset => (UInt<1>("h0"), branchAddrIn) @[MEMModule.scala 40:29]
    reg memSize : UInt<3>, clock with :
      reset => (UInt<1>("h0"), memSize) @[MEMModule.scala 41:24]
    node _io_pcSrc_T = and(branch, branchCheck) @[MEMModule.scala 44:23]
    node _memory_io_rdAddr_T = asUInt(io_aluResult) @[MEMModule.scala 48:36]
    node _memory_io_wrAddr_T = asUInt(io_aluResult) @[MEMModule.scala 49:36]
    node _memory_io_wrData_T = asUInt(io_rs2Data) @[MEMModule.scala 50:34]
    node _memory_io_wrData_T_1 = bits(_memory_io_wrData_T, 7, 0) @[MEMModule.scala 50:40]
    node _memOutput_T = asSInt(memory.io_rdData) @[MEMModule.scala 53:33]
    node memOutput = _memOutput_T @[MEMModule.scala 52:30 53:13]
    node _io_regWriteData_T = mux(memToReg, memOutput, aluResult) @[MEMModule.scala 56:25]
    io_regWriteData <= _io_regWriteData_T @[MEMModule.scala 56:19]
    io_rdOut <= rdIn @[MEMModule.scala 59:12]
    io_branchAddrOut <= branchAddrIn @[MEMModule.scala 61:20]
    io_pcSrc <= _io_pcSrc_T @[MEMModule.scala 44:12]
    io_regWriteOut <= regWriteIn @[MEMModule.scala 60:18]
    aluResult <= io_aluResult @[MEMModule.scala 34:26]
    rdIn <= io_rdIn @[MEMModule.scala 35:21]
    branchCheck <= io_branchCheck @[MEMModule.scala 36:28]
    branch <= io_branch @[MEMModule.scala 37:23]
    regWriteIn <= io_regWriteIn @[MEMModule.scala 38:27]
    memToReg <= io_memToReg @[MEMModule.scala 39:25]
    branchAddrIn <= io_branchAddrIn @[MEMModule.scala 40:29]
    memSize <= io_memSize @[MEMModule.scala 41:24]
    memory.clock <= clock
    memory.reset <= reset
    memory.io_rdAddr <= bits(_memory_io_rdAddr_T, 9, 0) @[MEMModule.scala 48:20]
    memory.io_wrAddr <= bits(_memory_io_wrAddr_T, 9, 0) @[MEMModule.scala 49:20]
    memory.io_wrData <= pad(_memory_io_wrData_T_1, 32) @[MEMModule.scala 50:20]
    memory.io_wrEna <= io_memWrite @[MEMModule.scala 51:19]

  module TopLevel :
    input clock : Clock
    input reset : UInt<1>
    output io_tx : UInt<1>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>
    output io_regFile_0 : SInt<32>
    output io_regFile_1 : SInt<32>
    output io_regFile_2 : SInt<32>
    output io_regFile_3 : SInt<32>
    output io_regFile_4 : SInt<32>
    output io_regFile_5 : SInt<32>
    output io_regFile_6 : SInt<32>
    output io_regFile_7 : SInt<32>
    output io_regFile_8 : SInt<32>
    output io_regFile_9 : SInt<32>
    output io_regFile_10 : SInt<32>
    output io_regFile_11 : SInt<32>
    output io_regFile_12 : SInt<32>
    output io_regFile_13 : SInt<32>
    output io_regFile_14 : SInt<32>
    output io_regFile_15 : SInt<32>
    output io_regFile_16 : SInt<32>
    output io_regFile_17 : SInt<32>
    output io_regFile_18 : SInt<32>
    output io_regFile_19 : SInt<32>
    output io_regFile_20 : SInt<32>
    output io_regFile_21 : SInt<32>
    output io_regFile_22 : SInt<32>
    output io_regFile_23 : SInt<32>
    output io_regFile_24 : SInt<32>
    output io_regFile_25 : SInt<32>
    output io_regFile_26 : SInt<32>
    output io_regFile_27 : SInt<32>
    output io_regFile_28 : SInt<32>
    output io_regFile_29 : SInt<32>
    output io_regFile_30 : SInt<32>
    output io_regFile_31 : SInt<32>

    inst ifModule of IFModule @[TopLevel.scala 23:24]
    inst idModule of IDModule @[TopLevel.scala 24:24]
    inst exModule of EXModule @[TopLevel.scala 25:24]
    inst memModule of MEMModule @[TopLevel.scala 26:25]
    io_tx <= UInt<1>("h0") @[TopLevel.scala 18:9]
    io_regFile_0 <= idModule.io_regFile_0 @[TopLevel.scala 75:14]
    io_regFile_1 <= idModule.io_regFile_1 @[TopLevel.scala 75:14]
    io_regFile_2 <= idModule.io_regFile_2 @[TopLevel.scala 75:14]
    io_regFile_3 <= idModule.io_regFile_3 @[TopLevel.scala 75:14]
    io_regFile_4 <= idModule.io_regFile_4 @[TopLevel.scala 75:14]
    io_regFile_5 <= idModule.io_regFile_5 @[TopLevel.scala 75:14]
    io_regFile_6 <= idModule.io_regFile_6 @[TopLevel.scala 75:14]
    io_regFile_7 <= idModule.io_regFile_7 @[TopLevel.scala 75:14]
    io_regFile_8 <= idModule.io_regFile_8 @[TopLevel.scala 75:14]
    io_regFile_9 <= idModule.io_regFile_9 @[TopLevel.scala 75:14]
    io_regFile_10 <= idModule.io_regFile_10 @[TopLevel.scala 75:14]
    io_regFile_11 <= idModule.io_regFile_11 @[TopLevel.scala 75:14]
    io_regFile_12 <= idModule.io_regFile_12 @[TopLevel.scala 75:14]
    io_regFile_13 <= idModule.io_regFile_13 @[TopLevel.scala 75:14]
    io_regFile_14 <= idModule.io_regFile_14 @[TopLevel.scala 75:14]
    io_regFile_15 <= idModule.io_regFile_15 @[TopLevel.scala 75:14]
    io_regFile_16 <= idModule.io_regFile_16 @[TopLevel.scala 75:14]
    io_regFile_17 <= idModule.io_regFile_17 @[TopLevel.scala 75:14]
    io_regFile_18 <= idModule.io_regFile_18 @[TopLevel.scala 75:14]
    io_regFile_19 <= idModule.io_regFile_19 @[TopLevel.scala 75:14]
    io_regFile_20 <= idModule.io_regFile_20 @[TopLevel.scala 75:14]
    io_regFile_21 <= idModule.io_regFile_21 @[TopLevel.scala 75:14]
    io_regFile_22 <= idModule.io_regFile_22 @[TopLevel.scala 75:14]
    io_regFile_23 <= idModule.io_regFile_23 @[TopLevel.scala 75:14]
    io_regFile_24 <= idModule.io_regFile_24 @[TopLevel.scala 75:14]
    io_regFile_25 <= idModule.io_regFile_25 @[TopLevel.scala 75:14]
    io_regFile_26 <= idModule.io_regFile_26 @[TopLevel.scala 75:14]
    io_regFile_27 <= idModule.io_regFile_27 @[TopLevel.scala 75:14]
    io_regFile_28 <= idModule.io_regFile_28 @[TopLevel.scala 75:14]
    io_regFile_29 <= idModule.io_regFile_29 @[TopLevel.scala 75:14]
    io_regFile_30 <= idModule.io_regFile_30 @[TopLevel.scala 75:14]
    io_regFile_31 <= idModule.io_regFile_31 @[TopLevel.scala 75:14]
    ifModule.clock <= clock
    ifModule.reset <= reset
    ifModule.io_pcSrc <= memModule.io_pcSrc @[TopLevel.scala 29:21]
    ifModule.io_branchAddr <= memModule.io_branchAddrOut @[TopLevel.scala 30:26]
    ifModule.io_wrAddr <= io_wrAddr @[TopLevel.scala 71:22]
    ifModule.io_wrData <= io_wrData @[TopLevel.scala 72:22]
    ifModule.io_wrEna <= io_wrEna @[TopLevel.scala 73:22]
    idModule.clock <= clock
    idModule.reset <= reset
    idModule.io_pcIn <= ifModule.io_pc @[TopLevel.scala 33:20]
    idModule.io_writeRegIdx <= memModule.io_rdOut @[TopLevel.scala 34:27]
    idModule.io_regWriteIn <= memModule.io_regWriteOut @[TopLevel.scala 35:26]
    idModule.io_writeRegData <= memModule.io_regWriteData @[TopLevel.scala 36:28]
    idModule.io_instr <= ifModule.io_instruction @[TopLevel.scala 37:21]
    exModule.clock <= clock
    exModule.reset <= reset
    exModule.io_rs1data <= idModule.io_rs1data @[TopLevel.scala 40:23]
    exModule.io_rs2dataIn <= idModule.io_rs2data @[TopLevel.scala 41:25]
    exModule.io_pc <= idModule.io_pcOut @[TopLevel.scala 42:18]
    exModule.io_rdIn <= idModule.io_rd @[TopLevel.scala 43:20]
    exModule.io_imm <= idModule.io_imm @[TopLevel.scala 44:19]
    exModule.io_aluOpSelect <= idModule.io_aluOpSelect @[TopLevel.scala 45:27]
    exModule.io_pcSelect <= idModule.io_pcSelect @[TopLevel.scala 46:24]
    exModule.io_aluSRC <= idModule.io_aluSRC @[TopLevel.scala 47:22]
    exModule.io_branchIn <= idModule.io_branch @[TopLevel.scala 48:24]
    exModule.io_memReadIn <= idModule.io_memRead @[TopLevel.scala 49:25]
    exModule.io_memWriteIn <= idModule.io_memWrite @[TopLevel.scala 50:26]
    exModule.io_regWriteIn <= idModule.io_regWriteOut @[TopLevel.scala 51:26]
    exModule.io_memToRegIn <= idModule.io_memToReg @[TopLevel.scala 52:26]
    exModule.io_branchCheckIn <= idModule.io_branchCheck @[TopLevel.scala 53:29]
    exModule.io_memSizeIn <= idModule.io_memSize @[TopLevel.scala 54:25]
    memModule.clock <= clock
    memModule.reset <= reset
    memModule.io_branchAddrIn <= exModule.io_branchAddr @[TopLevel.scala 57:29]
    memModule.io_aluResult <= exModule.io_aluResult @[TopLevel.scala 58:26]
    memModule.io_rs2Data <= exModule.io_rs2DataOut @[TopLevel.scala 59:24]
    memModule.io_rdIn <= exModule.io_rdOut @[TopLevel.scala 60:21]
    memModule.io_branch <= exModule.io_branchOut @[TopLevel.scala 61:23]
    memModule.io_memRead <= exModule.io_memReadOut @[TopLevel.scala 62:24]
    memModule.io_memWrite <= exModule.io_memWriteOut @[TopLevel.scala 63:25]
    memModule.io_regWriteIn <= exModule.io_regWriteOut @[TopLevel.scala 64:27]
    memModule.io_memToReg <= exModule.io_memToRegOut @[TopLevel.scala 65:25]
    memModule.io_branchCheck <= exModule.io_branchCheckOut @[TopLevel.scala 66:28]
    memModule.io_memSize <= exModule.io_memSizeOut @[TopLevel.scala 67:24]
