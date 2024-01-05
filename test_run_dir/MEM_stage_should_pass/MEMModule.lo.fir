FIRRTL version 1.1.0
circuit MEMModule :
  module Memory :
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
    output io_regWriteOut : UInt<1>

    inst memory of Memory @[MEMModule.scala 45:22]
    reg aluResult : SInt<32>, clock with :
      reset => (UInt<1>("h0"), aluResult) @[MEMModule.scala 33:26]
    reg rdIn : UInt<5>, clock with :
      reset => (UInt<1>("h0"), rdIn) @[MEMModule.scala 34:21]
    reg branchCheck : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branchCheck) @[MEMModule.scala 35:28]
    reg branch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), branch) @[MEMModule.scala 36:23]
    reg regWriteIn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regWriteIn) @[MEMModule.scala 37:27]
    reg memToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), memToReg) @[MEMModule.scala 38:25]
    reg branchAddrIn : UInt<32>, clock with :
      reset => (UInt<1>("h0"), branchAddrIn) @[MEMModule.scala 39:29]
    node _io_pcSrc_T = and(branch, branchCheck) @[MEMModule.scala 42:23]
    node _memory_io_rdAddr_T = asUInt(io_aluResult) @[MEMModule.scala 46:36]
    node _memory_io_wrAddr_T = asUInt(io_aluResult) @[MEMModule.scala 47:36]
    node _memory_io_wrData_T = asUInt(io_rs2Data) @[MEMModule.scala 48:34]
    node _memory_io_wrData_T_1 = bits(_memory_io_wrData_T, 7, 0) @[MEMModule.scala 48:40]
    node _memOutput_T = asSInt(memory.io_rdData) @[MEMModule.scala 51:33]
    node memOutput = _memOutput_T @[MEMModule.scala 50:30 51:13]
    node _io_regWriteData_T = mux(memToReg, memOutput, aluResult) @[MEMModule.scala 54:25]
    io_regWriteData <= _io_regWriteData_T @[MEMModule.scala 54:19]
    io_rdOut <= rdIn @[MEMModule.scala 57:12]
    io_branchAddrOut <= branchAddrIn @[MEMModule.scala 59:20]
    io_pcSrc <= _io_pcSrc_T @[MEMModule.scala 42:12]
    io_regWriteOut <= regWriteIn @[MEMModule.scala 58:18]
    aluResult <= io_aluResult @[MEMModule.scala 33:26]
    rdIn <= io_rdIn @[MEMModule.scala 34:21]
    branchCheck <= io_branchCheck @[MEMModule.scala 35:28]
    branch <= io_branch @[MEMModule.scala 36:23]
    regWriteIn <= io_regWriteIn @[MEMModule.scala 37:27]
    memToReg <= io_memToReg @[MEMModule.scala 38:25]
    branchAddrIn <= io_branchAddrIn @[MEMModule.scala 39:29]
    memory.clock <= clock
    memory.reset <= reset
    memory.io_rdAddr <= bits(_memory_io_rdAddr_T, 9, 0) @[MEMModule.scala 46:20]
    memory.io_wrAddr <= bits(_memory_io_wrAddr_T, 9, 0) @[MEMModule.scala 47:20]
    memory.io_wrData <= pad(_memory_io_wrData_T_1, 32) @[MEMModule.scala 48:20]
    memory.io_wrEna <= io_memWrite @[MEMModule.scala 49:19]
