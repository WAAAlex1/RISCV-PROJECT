FIRRTL version 1.1.0
circuit IFModule :
  module InstrMemModule :
    input clock : Clock
    input reset : UInt<1>
    input io_rdAddr : UInt<10>
    output io_rdData : UInt<32>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>

    mem mem : @[InstrMemModule.scala 13:24]
      data-type => UInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_rdData_MPORT
      writer => MPORT
      read-under-write => undefined
    node _GEN_0 = validif(UInt<1>("h1"), io_rdAddr) @[InstrMemModule.scala 15:{24,24}]
    node _io_rdData_WIRE = _GEN_0 @[InstrMemModule.scala 15:24]
    node _io_rdData_T = or(_io_rdData_WIRE, UInt<10>("h0")) @[InstrMemModule.scala 15:24]
    node _io_rdData_T_1 = bits(_io_rdData_T, 9, 0) @[InstrMemModule.scala 15:24]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[InstrMemModule.scala 13:24 15:{24,24}]
    node _GEN_2 = validif(UInt<1>("h1"), _io_rdData_T_1) @[InstrMemModule.scala 15:{24,24}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[InstrMemModule.scala 15:{24,24}]
    node _GEN_4 = validif(io_wrEna, io_wrAddr) @[InstrMemModule.scala 17:18]
    node _GEN_5 = validif(io_wrEna, clock) @[InstrMemModule.scala 17:18]
    node _GEN_6 = mux(io_wrEna, UInt<1>("h1"), UInt<1>("h0")) @[InstrMemModule.scala 17:18 13:24]
    node _GEN_7 = validif(io_wrEna, UInt<1>("h1")) @[InstrMemModule.scala 17:18]
    node _GEN_8 = validif(io_wrEna, io_wrData) @[InstrMemModule.scala 17:18]
    io_rdData <= mem.io_rdData_MPORT.data @[InstrMemModule.scala 15:13]
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
    input io_PCScr : UInt<1>
    input io_BranchAddr : UInt<32>
    output io_Instruction : UInt<32>
    output io_PC : UInt<32>
    input io_wrAddr : UInt<10>
    input io_wrData : UInt<32>
    input io_wrEna : UInt<1>

    inst instrMem of InstrMemModule @[IFModule.scala 18:24]
    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[IFModule.scala 17:19]
    node _pc_T = add(pc, UInt<1>("h1")) @[IFModule.scala 27:42]
    node _pc_T_1 = tail(_pc_T, 1) @[IFModule.scala 27:42]
    node _pc_T_2 = mux(io_PCScr, io_BranchAddr, _pc_T_1) @[IFModule.scala 27:12]
    io_Instruction <= instrMem.io_rdData @[IFModule.scala 30:18]
    io_PC <= pc @[IFModule.scala 32:9]
    pc <= mux(reset, UInt<32>("h0"), _pc_T_2) @[IFModule.scala 17:{19,19} 27:6]
    instrMem.clock <= clock
    instrMem.reset <= reset
    instrMem.io_rdAddr <= bits(pc, 9, 0) @[IFModule.scala 24:22]
    instrMem.io_wrAddr <= io_wrAddr @[IFModule.scala 20:22]
    instrMem.io_wrData <= io_wrData @[IFModule.scala 21:22]
    instrMem.io_wrEna <= io_wrEna @[IFModule.scala 19:21]
