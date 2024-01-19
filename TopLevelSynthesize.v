module Tx(
  input        clock,
  input        reset,
  output       io_txd,
  output       io_channel_ready,
  input        io_channel_valid,
  input  [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] shiftReg; // @[Uart.scala 30:25]
  reg [19:0] cntReg; // @[Uart.scala 31:23]
  reg [3:0] bitsReg; // @[Uart.scala 32:24]
  wire  _io_channel_ready_T = cntReg == 20'h0; // @[Uart.scala 34:31]
  wire [9:0] shift = shiftReg[10:1]; // @[Uart.scala 41:28]
  wire [10:0] _shiftReg_T_1 = {1'h1,shift}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 43:26]
  wire [10:0] _shiftReg_T_3 = {2'h3,io_channel_bits,1'h0}; // @[Cat.scala 33:92]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 54:22]
  assign io_txd = shiftReg[0]; // @[Uart.scala 35:21]
  assign io_channel_ready = cntReg == 20'h0 & bitsReg == 4'h0; // @[Uart.scala 34:40]
  always @(posedge clock) begin
    if (reset) begin // @[Uart.scala 30:25]
      shiftReg <= 11'h7ff; // @[Uart.scala 30:25]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 40:27]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 42:16]
      end else if (io_channel_valid) begin // @[Uart.scala 45:30]
        shiftReg <= _shiftReg_T_3; // @[Uart.scala 46:18]
      end else begin
        shiftReg <= 11'h7ff; // @[Uart.scala 49:18]
      end
    end
    if (reset) begin // @[Uart.scala 31:23]
      cntReg <= 20'h0; // @[Uart.scala 31:23]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      cntReg <= 20'h1660; // @[Uart.scala 39:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[Uart.scala 54:12]
    end
    if (reset) begin // @[Uart.scala 32:24]
      bitsReg <= 4'h0; // @[Uart.scala 32:24]
    end else if (_io_channel_ready_T) begin // @[Uart.scala 37:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 40:27]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 43:15]
      end else if (io_channel_valid) begin // @[Uart.scala 45:30]
        bitsReg <= 4'hb; // @[Uart.scala 47:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shiftReg = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[19:0];
  _RAND_2 = {1{`RANDOM}};
  bitsReg = _RAND_2[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Rx(
  input        clock,
  input        reset,
  input        io_rxd,
  input        io_channel_ready,
  output       io_channel_valid,
  output [7:0] io_channel_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[Uart.scala 76:30]
  reg  rxReg; // @[Uart.scala 76:22]
  reg [7:0] shiftReg; // @[Uart.scala 78:25]
  reg [19:0] cntReg; // @[Uart.scala 79:23]
  reg [3:0] bitsReg; // @[Uart.scala 80:24]
  reg  valReg; // @[Uart.scala 81:23]
  wire [19:0] _cntReg_T_1 = cntReg - 20'h1; // @[Uart.scala 84:22]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[Cat.scala 33:92]
  wire [3:0] _bitsReg_T_1 = bitsReg - 4'h1; // @[Uart.scala 88:24]
  wire  _GEN_0 = bitsReg == 4'h1 | valReg; // @[Uart.scala 90:27 91:14 81:23]
  assign io_channel_valid = valReg; // @[Uart.scala 103:20]
  assign io_channel_bits = shiftReg; // @[Uart.scala 102:19]
  always @(posedge clock) begin
    rxReg_REG <= reset | io_rxd; // @[Uart.scala 76:{30,30,30}]
    rxReg <= reset | rxReg_REG; // @[Uart.scala 76:{22,22,22}]
    if (reset) begin // @[Uart.scala 78:25]
      shiftReg <= 8'h0; // @[Uart.scala 78:25]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        shiftReg <= _shiftReg_T_1; // @[Uart.scala 87:14]
      end
    end
    if (reset) begin // @[Uart.scala 79:23]
      cntReg <= 20'h0; // @[Uart.scala 79:23]
    end else if (cntReg != 20'h0) begin // @[Uart.scala 83:24]
      cntReg <= _cntReg_T_1; // @[Uart.scala 84:12]
    end else if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
      cntReg <= 20'h1660; // @[Uart.scala 86:12]
    end else if (~rxReg) begin // @[Uart.scala 93:29]
      cntReg <= 20'h2191; // @[Uart.scala 94:12]
    end
    if (reset) begin // @[Uart.scala 80:24]
      bitsReg <= 4'h0; // @[Uart.scala 80:24]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        bitsReg <= _bitsReg_T_1; // @[Uart.scala 88:13]
      end else if (~rxReg) begin // @[Uart.scala 93:29]
        bitsReg <= 4'h8; // @[Uart.scala 95:13]
      end
    end
    if (reset) begin // @[Uart.scala 81:23]
      valReg <= 1'h0; // @[Uart.scala 81:23]
    end else if (valReg & io_channel_ready) begin // @[Uart.scala 98:36]
      valReg <= 1'h0; // @[Uart.scala 99:12]
    end else if (!(cntReg != 20'h0)) begin // @[Uart.scala 83:24]
      if (bitsReg != 4'h0) begin // @[Uart.scala 85:31]
        valReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[19:0];
  _RAND_4 = {1{`RANDOM}};
  bitsReg = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  valReg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [3:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemoryMappedUart(
  input         clock,
  input         reset,
  input         io_port_read,
  input         io_port_write,
  input  [31:0] io_port_addr,
  input  [31:0] io_port_wrData,
  output [31:0] io_port_rdData,
  output        io_pins_tx,
  input         io_pins_rx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  transmitter_clock; // @[MemoryMappedUart.scala 58:27]
  wire  transmitter_reset; // @[MemoryMappedUart.scala 58:27]
  wire  transmitter_io_txd; // @[MemoryMappedUart.scala 58:27]
  wire  transmitter_io_channel_ready; // @[MemoryMappedUart.scala 58:27]
  wire  transmitter_io_channel_valid; // @[MemoryMappedUart.scala 58:27]
  wire [7:0] transmitter_io_channel_bits; // @[MemoryMappedUart.scala 58:27]
  wire  receiver_clock; // @[MemoryMappedUart.scala 59:24]
  wire  receiver_reset; // @[MemoryMappedUart.scala 59:24]
  wire  receiver_io_rxd; // @[MemoryMappedUart.scala 59:24]
  wire  receiver_io_channel_ready; // @[MemoryMappedUart.scala 59:24]
  wire  receiver_io_channel_valid; // @[MemoryMappedUart.scala 59:24]
  wire [7:0] receiver_io_channel_bits; // @[MemoryMappedUart.scala 59:24]
  wire  txBuffer_clock; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_reset; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_io_enq_ready; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_io_enq_valid; // @[MemoryMappedUart.scala 62:24]
  wire [7:0] txBuffer_io_enq_bits; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_io_deq_ready; // @[MemoryMappedUart.scala 62:24]
  wire  txBuffer_io_deq_valid; // @[MemoryMappedUart.scala 62:24]
  wire [7:0] txBuffer_io_deq_bits; // @[MemoryMappedUart.scala 62:24]
  wire  rxBuffer_clock; // @[MemoryMappedUart.scala 63:24]
  wire  rxBuffer_reset; // @[MemoryMappedUart.scala 63:24]
  wire  rxBuffer_io_enq_ready; // @[MemoryMappedUart.scala 63:24]
  wire  rxBuffer_io_enq_valid; // @[MemoryMappedUart.scala 63:24]
  wire [7:0] rxBuffer_io_enq_bits; // @[MemoryMappedUart.scala 63:24]
  wire  rxBuffer_io_deq_ready; // @[MemoryMappedUart.scala 63:24]
  wire  rxBuffer_io_deq_valid; // @[MemoryMappedUart.scala 63:24]
  wire [7:0] rxBuffer_io_deq_bits; // @[MemoryMappedUart.scala 63:24]
  wire  _hadDataReadRequest_T = io_port_addr == 32'h0; // @[Bus.scala 81:30]
  wire  _hadDataReadRequest_T_1 = io_port_read & io_port_addr == 32'h0; // @[Bus.scala 81:17]
  reg  hadDataReadRequest; // @[MemoryMappedUart.scala 71:12]
  wire [1:0] _io_port_rdData_T = {rxBuffer_io_deq_valid,txBuffer_io_enq_ready}; // @[MemoryMappedUart.scala 91:27]
  wire [7:0] _io_port_rdData_T_1 = hadDataReadRequest ? rxBuffer_io_deq_bits : {{6'd0}, _io_port_rdData_T}; // @[MemoryMappedUart.scala 88:24]
  Tx transmitter ( // @[MemoryMappedUart.scala 58:27]
    .clock(transmitter_clock),
    .reset(transmitter_reset),
    .io_txd(transmitter_io_txd),
    .io_channel_ready(transmitter_io_channel_ready),
    .io_channel_valid(transmitter_io_channel_valid),
    .io_channel_bits(transmitter_io_channel_bits)
  );
  Rx receiver ( // @[MemoryMappedUart.scala 59:24]
    .clock(receiver_clock),
    .reset(receiver_reset),
    .io_rxd(receiver_io_rxd),
    .io_channel_ready(receiver_io_channel_ready),
    .io_channel_valid(receiver_io_channel_valid),
    .io_channel_bits(receiver_io_channel_bits)
  );
  Queue txBuffer ( // @[MemoryMappedUart.scala 62:24]
    .clock(txBuffer_clock),
    .reset(txBuffer_reset),
    .io_enq_ready(txBuffer_io_enq_ready),
    .io_enq_valid(txBuffer_io_enq_valid),
    .io_enq_bits(txBuffer_io_enq_bits),
    .io_deq_ready(txBuffer_io_deq_ready),
    .io_deq_valid(txBuffer_io_deq_valid),
    .io_deq_bits(txBuffer_io_deq_bits)
  );
  Queue rxBuffer ( // @[MemoryMappedUart.scala 63:24]
    .clock(rxBuffer_clock),
    .reset(rxBuffer_reset),
    .io_enq_ready(rxBuffer_io_enq_ready),
    .io_enq_valid(rxBuffer_io_enq_valid),
    .io_enq_bits(rxBuffer_io_enq_bits),
    .io_deq_ready(rxBuffer_io_deq_ready),
    .io_deq_valid(rxBuffer_io_deq_valid),
    .io_deq_bits(rxBuffer_io_deq_bits)
  );
  assign io_port_rdData = {{24'd0}, _io_port_rdData_T_1}; // @[MemoryMappedUart.scala 88:18]
  assign io_pins_tx = transmitter_io_txd; // @[MemoryMappedUart.scala 84:14]
  assign transmitter_clock = clock;
  assign transmitter_reset = reset;
  assign transmitter_io_channel_valid = txBuffer_io_deq_valid; // @[MemoryMappedUart.scala 66:19]
  assign transmitter_io_channel_bits = txBuffer_io_deq_bits; // @[MemoryMappedUart.scala 66:19]
  assign receiver_clock = clock;
  assign receiver_reset = reset;
  assign receiver_io_rxd = io_pins_rx; // @[MemoryMappedUart.scala 85:19]
  assign receiver_io_channel_ready = rxBuffer_io_enq_ready; // @[MemoryMappedUart.scala 67:23]
  assign txBuffer_clock = clock;
  assign txBuffer_reset = reset;
  assign txBuffer_io_enq_valid = io_port_write & _hadDataReadRequest_T; // @[Bus.scala 74:18]
  assign txBuffer_io_enq_bits = io_port_wrData[7:0]; // @[MemoryMappedUart.scala 77:24]
  assign txBuffer_io_deq_ready = transmitter_io_channel_ready; // @[MemoryMappedUart.scala 66:19]
  assign rxBuffer_clock = clock;
  assign rxBuffer_reset = reset;
  assign rxBuffer_io_enq_valid = receiver_io_channel_valid; // @[MemoryMappedUart.scala 67:23]
  assign rxBuffer_io_enq_bits = receiver_io_channel_bits; // @[MemoryMappedUart.scala 67:23]
  assign rxBuffer_io_deq_ready = hadDataReadRequest; // @[MemoryMappedUart.scala 81:25]
  always @(posedge clock) begin
    if (reset) begin // @[MemoryMappedUart.scala 71:12]
      hadDataReadRequest <= 1'h0; // @[MemoryMappedUart.scala 71:12]
    end else begin
      hadDataReadRequest <= _hadDataReadRequest_T_1; // @[MemoryMappedUart.scala 71:12]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hadDataReadRequest = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IFModuleTest(
  input         clock,
  input         reset,
  input         io_pcSrc,
  input  [31:0] io_branchAddr,
  output [31:0] io_instruction,
  output [31:0] io_pc,
  input         io_running
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc; // @[IFModuleTest.scala 17:19]
  wire [31:0] _pcAdded_T_1 = pc + 32'h1; // @[IFModuleTest.scala 117:32]
  wire [31:0] _GEN_1 = 5'h1 == pc[4:0] ? 32'h100193 : 32'h893; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_2 = 5'h2 == pc[4:0] ? 32'h113 : _GEN_1; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_3 = 5'h3 == pc[4:0] ? 32'h500293 : _GEN_2; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_4 = 5'h4 == pc[4:0] ? 32'h1f00f93 : _GEN_3; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_5 = 5'h5 == pc[4:0] ? 32'h100f13 : _GEN_4; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_6 = 5'h6 == pc[4:0] ? 32'h1eb7 : _GEN_5; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_7 = 5'h7 == pc[4:0] ? 32'h4000337 : _GEN_6; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_8 = 5'h8 == pc[4:0] ? 32'h213 : _GEN_7; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_9 = 5'h9 == pc[4:0] ? 32'h40006f : _GEN_8; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_10 = 5'ha == pc[4:0] ? 32'h218133 : _GEN_9; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_11 = 5'hb == pc[4:0] ? 32'h18003ef : _GEN_10; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_12 = 5'hc == pc[4:0] ? 32'h3101b3 : _GEN_11; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_13 = 5'hd == pc[4:0] ? 32'h24003ef : _GEN_12; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_14 = 5'he == pc[4:0] ? 32'h120213 : _GEN_13; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_15 = 5'hf == pc[4:0] ? 32'hfe5216e3 : _GEN_14; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_16 = 5'h10 == pc[4:0] ? 32'h2c0006f : _GEN_15; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_17 = 5'h11 == pc[4:0] ? 32'h2eae03 : _GEN_16; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_18 = 5'h12 == pc[4:0] ? 32'h1ee7e33 : _GEN_17; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_19 = 5'h13 == pc[4:0] ? 32'hffee1ce3 : _GEN_18; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_20 = 5'h14 == pc[4:0] ? 32'h2ea0a3 : _GEN_19; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_21 = 5'h15 == pc[4:0] ? 32'h38067 : _GEN_20; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_22 = 5'h16 == pc[4:0] ? 32'h2eae03 : _GEN_21; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_23 = 5'h17 == pc[4:0] ? 32'h1ee7e33 : _GEN_22; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_24 = 5'h18 == pc[4:0] ? 32'hffee1ce3 : _GEN_23; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_25 = 5'h19 == pc[4:0] ? 32'h3ea0a3 : _GEN_24; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_26 = 5'h1a == pc[4:0] ? 32'h38067 : _GEN_25; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_27 = 5'h1b == pc[4:0] ? 32'h3ea023 : _GEN_26; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_28 = 5'h1c == pc[4:0] ? 32'hfff30313 : _GEN_27; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_29 = 5'h1d == pc[4:0] ? 32'hffe31ee3 : _GEN_28; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _GEN_30 = 5'h1e == pc[4:0] ? 32'hf89ff06f : _GEN_29; // @[IFModuleTest.scala 125:{39,39}]
  wire [31:0] _io_instruction_T_1 = io_pcSrc ? 32'h13 : _GEN_30; // @[IFModuleTest.scala 125:39]
  wire [33:0] _io_pc_T = {pc, 2'h0}; // @[IFModuleTest.scala 129:15]
  assign io_instruction = io_running ? _io_instruction_T_1 : 32'h13; // @[IFModuleTest.scala 125:24]
  assign io_pc = _io_pc_T[31:0]; // @[IFModuleTest.scala 129:9]
  always @(posedge clock) begin
    if (reset) begin // @[IFModuleTest.scala 17:19]
      pc <= 32'h0; // @[IFModuleTest.scala 17:19]
    end else if (io_pcSrc) begin // @[IFModuleTest.scala 121:15]
      pc <= {{2'd0}, io_branchAddr[31:2]};
    end else if (io_running) begin // @[IFModuleTest.scala 117:17]
      pc <= _pcAdded_T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pc = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDModule(
  input         clock,
  input         reset,
  input  [31:0] io_pcIn,
  input  [4:0]  io_writeRegIdx,
  input         io_regWriteIn,
  input  [31:0] io_writeRegData,
  input  [31:0] io_instr,
  output [31:0] io_rs1data,
  output [31:0] io_rs2data,
  output [31:0] io_pcOut,
  output [4:0]  io_rd,
  output [31:0] io_imm,
  output [31:0] io_branchAddr,
  output        io_pcSrc,
  output        io_halt,
  input  [31:0] io_resEX,
  input  [31:0] io_resMEM,
  input  [1:0]  io_forward1,
  input  [1:0]  io_forward2,
  input  [1:0]  io_ecallForward,
  input         io_ldBraHazard,
  output        io_exControl_sigBundle_memWrite,
  output        io_exControl_sigBundle_regWrite,
  output        io_exControl_sigBundle_memToReg,
  output [2:0]  io_exControl_sigBundle_memSize,
  output        io_exControl_aluSRC,
  output [3:0]  io_exControl_aluOpSelect,
  output [4:0]  io_exControl_rs1Idx,
  output [4:0]  io_exControl_rs2Idx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcIn; // @[IDModule.scala 52:21]
  reg [31:0] instr; // @[IDModule.scala 53:22]
  reg [31:0] registerFile_1; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_2; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_3; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_4; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_5; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_6; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_7; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_8; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_9; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_10; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_11; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_12; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_13; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_14; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_15; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_16; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_17; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_18; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_19; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_20; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_21; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_22; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_23; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_24; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_25; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_26; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_27; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_28; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_29; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_30; // @[IDModule.scala 56:29]
  reg [31:0] registerFile_31; // @[IDModule.scala 56:29]
  wire [31:0] _GEN_1 = 5'h1 == instr[19:15] ? $signed(registerFile_1) : $signed(32'sh0); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_2 = 5'h2 == instr[19:15] ? $signed(registerFile_2) : $signed(_GEN_1); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_3 = 5'h3 == instr[19:15] ? $signed(registerFile_3) : $signed(_GEN_2); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_4 = 5'h4 == instr[19:15] ? $signed(registerFile_4) : $signed(_GEN_3); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_5 = 5'h5 == instr[19:15] ? $signed(registerFile_5) : $signed(_GEN_4); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_6 = 5'h6 == instr[19:15] ? $signed(registerFile_6) : $signed(_GEN_5); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_7 = 5'h7 == instr[19:15] ? $signed(registerFile_7) : $signed(_GEN_6); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_8 = 5'h8 == instr[19:15] ? $signed(registerFile_8) : $signed(_GEN_7); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_9 = 5'h9 == instr[19:15] ? $signed(registerFile_9) : $signed(_GEN_8); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_10 = 5'ha == instr[19:15] ? $signed(registerFile_10) : $signed(_GEN_9); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_11 = 5'hb == instr[19:15] ? $signed(registerFile_11) : $signed(_GEN_10); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_12 = 5'hc == instr[19:15] ? $signed(registerFile_12) : $signed(_GEN_11); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_13 = 5'hd == instr[19:15] ? $signed(registerFile_13) : $signed(_GEN_12); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_14 = 5'he == instr[19:15] ? $signed(registerFile_14) : $signed(_GEN_13); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_15 = 5'hf == instr[19:15] ? $signed(registerFile_15) : $signed(_GEN_14); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_16 = 5'h10 == instr[19:15] ? $signed(registerFile_16) : $signed(_GEN_15); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_17 = 5'h11 == instr[19:15] ? $signed(registerFile_17) : $signed(_GEN_16); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_18 = 5'h12 == instr[19:15] ? $signed(registerFile_18) : $signed(_GEN_17); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_19 = 5'h13 == instr[19:15] ? $signed(registerFile_19) : $signed(_GEN_18); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_20 = 5'h14 == instr[19:15] ? $signed(registerFile_20) : $signed(_GEN_19); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_21 = 5'h15 == instr[19:15] ? $signed(registerFile_21) : $signed(_GEN_20); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_22 = 5'h16 == instr[19:15] ? $signed(registerFile_22) : $signed(_GEN_21); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_23 = 5'h17 == instr[19:15] ? $signed(registerFile_23) : $signed(_GEN_22); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_24 = 5'h18 == instr[19:15] ? $signed(registerFile_24) : $signed(_GEN_23); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_25 = 5'h19 == instr[19:15] ? $signed(registerFile_25) : $signed(_GEN_24); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_26 = 5'h1a == instr[19:15] ? $signed(registerFile_26) : $signed(_GEN_25); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_27 = 5'h1b == instr[19:15] ? $signed(registerFile_27) : $signed(_GEN_26); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_28 = 5'h1c == instr[19:15] ? $signed(registerFile_28) : $signed(_GEN_27); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_29 = 5'h1d == instr[19:15] ? $signed(registerFile_29) : $signed(_GEN_28); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_30 = 5'h1e == instr[19:15] ? $signed(registerFile_30) : $signed(_GEN_29); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _GEN_31 = 5'h1f == instr[19:15] ? $signed(registerFile_31) : $signed(_GEN_30); // @[IDModule.scala 57:{48,48}]
  wire [31:0] _rs1data_T_3 = io_forward1[1] ? $signed(io_resMEM) : $signed(_GEN_31); // @[IDModule.scala 57:48]
  wire [31:0] rs1data = io_forward1[0] ? $signed(io_resEX) : $signed(_rs1data_T_3); // @[IDModule.scala 57:20]
  wire [31:0] _GEN_33 = 5'h1 == instr[24:20] ? $signed(registerFile_1) : $signed(32'sh0); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_34 = 5'h2 == instr[24:20] ? $signed(registerFile_2) : $signed(_GEN_33); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_35 = 5'h3 == instr[24:20] ? $signed(registerFile_3) : $signed(_GEN_34); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_36 = 5'h4 == instr[24:20] ? $signed(registerFile_4) : $signed(_GEN_35); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_37 = 5'h5 == instr[24:20] ? $signed(registerFile_5) : $signed(_GEN_36); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_38 = 5'h6 == instr[24:20] ? $signed(registerFile_6) : $signed(_GEN_37); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_39 = 5'h7 == instr[24:20] ? $signed(registerFile_7) : $signed(_GEN_38); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_40 = 5'h8 == instr[24:20] ? $signed(registerFile_8) : $signed(_GEN_39); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_41 = 5'h9 == instr[24:20] ? $signed(registerFile_9) : $signed(_GEN_40); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_42 = 5'ha == instr[24:20] ? $signed(registerFile_10) : $signed(_GEN_41); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_43 = 5'hb == instr[24:20] ? $signed(registerFile_11) : $signed(_GEN_42); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_44 = 5'hc == instr[24:20] ? $signed(registerFile_12) : $signed(_GEN_43); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_45 = 5'hd == instr[24:20] ? $signed(registerFile_13) : $signed(_GEN_44); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_46 = 5'he == instr[24:20] ? $signed(registerFile_14) : $signed(_GEN_45); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_47 = 5'hf == instr[24:20] ? $signed(registerFile_15) : $signed(_GEN_46); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_48 = 5'h10 == instr[24:20] ? $signed(registerFile_16) : $signed(_GEN_47); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_49 = 5'h11 == instr[24:20] ? $signed(registerFile_17) : $signed(_GEN_48); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_50 = 5'h12 == instr[24:20] ? $signed(registerFile_18) : $signed(_GEN_49); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_51 = 5'h13 == instr[24:20] ? $signed(registerFile_19) : $signed(_GEN_50); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_52 = 5'h14 == instr[24:20] ? $signed(registerFile_20) : $signed(_GEN_51); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_53 = 5'h15 == instr[24:20] ? $signed(registerFile_21) : $signed(_GEN_52); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_54 = 5'h16 == instr[24:20] ? $signed(registerFile_22) : $signed(_GEN_53); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_55 = 5'h17 == instr[24:20] ? $signed(registerFile_23) : $signed(_GEN_54); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_56 = 5'h18 == instr[24:20] ? $signed(registerFile_24) : $signed(_GEN_55); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_57 = 5'h19 == instr[24:20] ? $signed(registerFile_25) : $signed(_GEN_56); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_58 = 5'h1a == instr[24:20] ? $signed(registerFile_26) : $signed(_GEN_57); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_59 = 5'h1b == instr[24:20] ? $signed(registerFile_27) : $signed(_GEN_58); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_60 = 5'h1c == instr[24:20] ? $signed(registerFile_28) : $signed(_GEN_59); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_61 = 5'h1d == instr[24:20] ? $signed(registerFile_29) : $signed(_GEN_60); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_62 = 5'h1e == instr[24:20] ? $signed(registerFile_30) : $signed(_GEN_61); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _GEN_63 = 5'h1f == instr[24:20] ? $signed(registerFile_31) : $signed(_GEN_62); // @[IDModule.scala 59:{45,45}]
  wire [31:0] _rs2data_T_3 = io_forward2[1] ? $signed(io_resMEM) : $signed(_GEN_63); // @[IDModule.scala 59:45]
  wire [31:0] rs2data = io_forward2[0] ? $signed(io_resEX) : $signed(_rs2data_T_3); // @[IDModule.scala 59:17]
  wire  _T_1 = 3'h0 == instr[14:12]; // @[IDModule.scala 66:3]
  wire  _T_2 = 3'h1 == instr[14:12]; // @[IDModule.scala 66:3]
  wire  _T_3 = 3'h4 == instr[14:12]; // @[IDModule.scala 66:3]
  wire  _T_4 = 3'h5 == instr[14:12]; // @[IDModule.scala 66:3]
  wire  _T_5 = 3'h6 == instr[14:12]; // @[IDModule.scala 66:3]
  wire [31:0] _branchCheck_T_4 = io_forward1[0] ? $signed(io_resEX) : $signed(_rs1data_T_3); // @[IDModule.scala 80:31]
  wire [31:0] _branchCheck_T_5 = io_forward2[0] ? $signed(io_resEX) : $signed(_rs2data_T_3); // @[IDModule.scala 80:48]
  wire  _T_6 = 3'h7 == instr[14:12]; // @[IDModule.scala 66:3]
  wire  _GEN_64 = 3'h7 == instr[14:12] & _branchCheck_T_4 >= _branchCheck_T_5; // @[IDModule.scala 66:3 83:19 64:32]
  wire  _GEN_65 = 3'h6 == instr[14:12] ? _branchCheck_T_4 < _branchCheck_T_5 : _GEN_64; // @[IDModule.scala 66:3 80:19]
  wire  _GEN_66 = 3'h5 == instr[14:12] ? $signed(rs1data) >= $signed(rs2data) : _GEN_65; // @[IDModule.scala 66:3 77:19]
  wire  _GEN_67 = 3'h4 == instr[14:12] ? $signed(rs1data) < $signed(rs2data) : _GEN_66; // @[IDModule.scala 66:3 74:19]
  wire  _GEN_68 = 3'h1 == instr[14:12] ? $signed(rs1data) != $signed(rs2data) : _GEN_67; // @[IDModule.scala 66:3 71:19]
  wire  _GEN_69 = 3'h0 == instr[14:12] ? $signed(rs1data) == $signed(rs2data) : _GEN_68; // @[IDModule.scala 66:3 68:19]
  wire [31:0] _io_imm_T_2 = {instr[31:20],20'hfffff}; // @[IDModule.scala 125:47]
  wire [11:0] _io_imm_T_3 = _io_imm_T_2[31:20]; // @[IDModule.scala 125:54]
  wire  _T_12 = 6'h33 == instr[6:1]; // @[IDModule.scala 113:22]
  wire [31:0] _io_imm_T_20 = {instr[31:25],instr[11:7],20'hfffff}; // @[IDModule.scala 159:63]
  wire [11:0] _io_imm_T_21 = _io_imm_T_20[31:20]; // @[IDModule.scala 159:70]
  wire [31:0] _io_imm_T_30 = {instr[31],instr[7],instr[30:25],instr[11:8],20'hfffff}; // @[IDModule.scala 170:88]
  wire [12:0] _io_imm_T_31 = _io_imm_T_30[31:19]; // @[IDModule.scala 170:95]
  wire  _T_15 = 6'h37 == instr[6:1]; // @[IDModule.scala 113:22]
  wire [20:0] _io_imm_T_40 = {instr[31],instr[19:12],instr[20],instr[30:21],1'h0}; // @[IDModule.scala 180:86]
  wire  _T_16 = 6'h1b == instr[6:1]; // @[IDModule.scala 113:22]
  wire [31:0] _io_imm_T_42 = instr & 32'hfffff000; // @[IDModule.scala 184:53]
  wire  _T_17 = 6'hb == instr[6:1]; // @[IDModule.scala 113:22]
  wire [31:0] _GEN_70 = 6'hb == instr[6:1] ? $signed(_io_imm_T_42) : $signed(32'sh0); // @[IDModule.scala 112:10 113:22 185:24]
  wire [31:0] _GEN_71 = 6'h1b == instr[6:1] ? $signed(_io_imm_T_42) : $signed(_GEN_70); // @[IDModule.scala 113:22 184:24]
  wire [31:0] _GEN_72 = 6'h37 == instr[6:1] ? $signed({{11{_io_imm_T_40[20]}},_io_imm_T_40}) : $signed(_GEN_71); // @[IDModule.scala 113:22 180:14]
  wire  _GEN_73 = 6'h37 == instr[6:1] | _GEN_69; // @[IDModule.scala 113:22 181:19]
  wire [31:0] _GEN_75 = 6'h31 == instr[6:1] ? $signed({{19{_io_imm_T_31[12]}},_io_imm_T_31}) : $signed(_GEN_72); // @[IDModule.scala 113:22 170:14]
  wire  _GEN_77 = 6'h31 == instr[6:1] | 6'h37 == instr[6:1]; // @[IDModule.scala 113:22 174:14]
  wire  _GEN_78 = 6'h31 == instr[6:1] ? 1'h0 : 1'h1; // @[IDModule.scala 113:22 176:39 93:35]
  wire  _GEN_79 = 6'h31 == instr[6:1] ? _GEN_69 : _GEN_73; // @[IDModule.scala 113:22]
  wire [31:0] _GEN_80 = 6'h11 == instr[6:1] ? $signed({{20{_io_imm_T_21[11]}},_io_imm_T_21}) : $signed(_GEN_75); // @[IDModule.scala 113:22 159:14]
  wire [1:0] _GEN_81 = 6'h11 == instr[6:1] ? 2'h2 : 2'h0; // @[IDModule.scala 113:22 160:17 105:30]
  wire  _GEN_83 = 6'h11 == instr[6:1] ? 1'h0 : _GEN_77; // @[IDModule.scala 113:22 164:14]
  wire  _GEN_84 = 6'h11 == instr[6:1] ? 1'h0 : _GEN_78; // @[IDModule.scala 113:22 166:39]
  wire  _GEN_86 = 6'h11 == instr[6:1] ? _GEN_69 : _GEN_79; // @[IDModule.scala 113:22]
  wire [31:0] _GEN_87 = 6'h33 == instr[6:1] ? $signed({{20{_io_imm_T_3[11]}},_io_imm_T_3}) : $signed(_GEN_80); // @[IDModule.scala 113:22 153:14]
  wire  _GEN_89 = 6'h33 == instr[6:1] | _GEN_86; // @[IDModule.scala 113:22 155:19]
  wire  _GEN_90 = 6'h33 == instr[6:1] | _GEN_83; // @[IDModule.scala 113:22 156:14]
  wire [1:0] _GEN_91 = 6'h33 == instr[6:1] ? 2'h0 : _GEN_81; // @[IDModule.scala 113:22 105:30]
  wire  _GEN_92 = 6'h33 == instr[6:1] ? 1'h0 : 6'h11 == instr[6:1]; // @[IDModule.scala 113:22 91:23]
  wire [31:0] _GEN_95 = 6'h39 == instr[6:1] ? $signed({{20{_io_imm_T_3[11]}},_io_imm_T_3}) : $signed(_GEN_87); // @[IDModule.scala 113:22 148:14]
  wire  _GEN_97 = 6'h39 == instr[6:1] ? 1'h0 : 6'h33 == instr[6:1]; // @[IDModule.scala 113:22 90:29]
  wire  _GEN_98 = 6'h39 == instr[6:1] ? _GEN_69 : _GEN_89; // @[IDModule.scala 113:22]
  wire  _GEN_99 = 6'h39 == instr[6:1] ? 1'h0 : _GEN_90; // @[IDModule.scala 113:22 89:27]
  wire [1:0] _GEN_100 = 6'h39 == instr[6:1] ? 2'h0 : _GEN_91; // @[IDModule.scala 113:22 105:30]
  wire  _GEN_101 = 6'h39 == instr[6:1] ? 1'h0 : _GEN_92; // @[IDModule.scala 113:22 91:23]
  wire  _GEN_102 = 6'h39 == instr[6:1] | (6'h33 == instr[6:1] | _GEN_84); // @[IDModule.scala 113:22 93:35]
  wire [31:0] _GEN_104 = 6'h1 == instr[6:1] ? $signed({{20{_io_imm_T_3[11]}},_io_imm_T_3}) : $signed(_GEN_95); // @[IDModule.scala 113:22 136:14]
  wire [1:0] _GEN_105 = 6'h1 == instr[6:1] ? 2'h2 : _GEN_100; // @[IDModule.scala 113:22 137:17]
  wire  _GEN_106 = 6'h1 == instr[6:1] | _GEN_101; // @[IDModule.scala 113:22 140:27]
  wire  _GEN_107 = 6'h1 == instr[6:1] ? 1'h0 : _GEN_99; // @[IDModule.scala 113:22 141:14]
  wire  _GEN_108 = 6'h1 == instr[6:1] ? 1'h0 : _GEN_101; // @[IDModule.scala 113:22 142:39]
  wire  _GEN_109 = 6'h1 == instr[6:1] | _GEN_102; // @[IDModule.scala 113:22 143:39]
  wire  _GEN_111 = 6'h1 == instr[6:1] ? 1'h0 : 6'h39 == instr[6:1]; // @[IDModule.scala 113:22 96:26]
  wire  _GEN_112 = 6'h1 == instr[6:1] ? 1'h0 : _GEN_97; // @[IDModule.scala 113:22 90:29]
  wire  _GEN_113 = 6'h1 == instr[6:1] ? _GEN_69 : _GEN_98; // @[IDModule.scala 113:22]
  wire [31:0] _GEN_114 = 6'h9 == instr[6:1] ? $signed({{20{_io_imm_T_3[11]}},_io_imm_T_3}) : $signed(_GEN_104); // @[IDModule.scala 113:22 125:14]
  wire [1:0] _GEN_115 = 6'h9 == instr[6:1] ? 2'h1 : _GEN_105; // @[IDModule.scala 113:22 126:17]
  wire  _GEN_116 = 6'h9 == instr[6:1] | _GEN_106; // @[IDModule.scala 113:22 129:27]
  wire  _GEN_117 = 6'h9 == instr[6:1] ? 1'h0 : _GEN_107; // @[IDModule.scala 113:22 130:14]
  wire  _GEN_118 = 6'h9 == instr[6:1] ? 1'h0 : _GEN_108; // @[IDModule.scala 113:22 131:39]
  wire  _GEN_119 = 6'h9 == instr[6:1] | _GEN_109; // @[IDModule.scala 113:22 132:39]
  wire  _GEN_120 = 6'h9 == instr[6:1] ? 1'h0 : 6'h1 == instr[6:1]; // @[IDModule.scala 113:22 133:39]
  wire  _GEN_121 = 6'h9 == instr[6:1] ? 1'h0 : _GEN_111; // @[IDModule.scala 113:22 96:26]
  wire  _GEN_122 = 6'h9 == instr[6:1] ? 1'h0 : _GEN_112; // @[IDModule.scala 113:22 90:29]
  wire  _GEN_123 = 6'h9 == instr[6:1] ? _GEN_69 : _GEN_113; // @[IDModule.scala 113:22]
  wire [1:0] aluOPType = 6'h19 == instr[6:1] ? 2'h0 : _GEN_115; // @[IDModule.scala 113:22 115:17]
  wire  branch = 6'h19 == instr[6:1] ? 1'h0 : _GEN_117; // @[IDModule.scala 113:22 119:14]
  wire  ecall = 6'h19 == instr[6:1] ? 1'h0 : _GEN_121; // @[IDModule.scala 113:22 96:26]
  wire  pcSelect = 6'h19 == instr[6:1] ? 1'h0 : _GEN_122; // @[IDModule.scala 113:22 90:29]
  wire  branchCheck = 6'h19 == instr[6:1] ? _GEN_69 : _GEN_123; // @[IDModule.scala 113:22]
  wire [31:0] _a7_T_2 = io_ecallForward[1] ? $signed(io_resMEM) : $signed(registerFile_17); // @[IDModule.scala 189:47]
  wire [31:0] a7 = io_ecallForward[0] ? $signed(io_resEX) : $signed(_a7_T_2); // @[IDModule.scala 189:15]
  wire [3:0] _T_21 = {instr[30],instr[14:12]}; // @[IDModule.scala 197:24]
  wire [3:0] _GEN_134 = 4'h3 == _T_21 ? 4'h9 : 4'h0; // @[IDModule.scala 194:28 197:40 207:48]
  wire [3:0] _GEN_135 = 4'h2 == _T_21 ? 4'h8 : _GEN_134; // @[IDModule.scala 197:40 206:48]
  wire [3:0] _GEN_136 = 4'hd == _T_21 ? 4'h7 : _GEN_135; // @[IDModule.scala 197:40 205:48]
  wire [3:0] _GEN_137 = 4'h5 == _T_21 ? 4'h6 : _GEN_136; // @[IDModule.scala 197:40 204:48]
  wire [3:0] _GEN_138 = 4'h1 == _T_21 ? 4'h5 : _GEN_137; // @[IDModule.scala 197:40 203:48]
  wire [3:0] _GEN_139 = 4'h7 == _T_21 ? 4'h4 : _GEN_138; // @[IDModule.scala 197:40 202:48]
  wire [3:0] _GEN_140 = 4'h6 == _T_21 ? 4'h3 : _GEN_139; // @[IDModule.scala 197:40 201:48]
  wire [3:0] _GEN_141 = 4'h4 == _T_21 ? 4'h2 : _GEN_140; // @[IDModule.scala 197:40 200:48]
  wire [3:0] _GEN_142 = 4'h8 == _T_21 ? 4'h1 : _GEN_141; // @[IDModule.scala 197:40 199:48]
  wire [3:0] _GEN_143 = 4'h0 == _T_21 ? 4'h0 : _GEN_142; // @[IDModule.scala 197:40 198:48]
  wire  _io_exControl_aluOpSelect_T_1 = io_imm[11:5] == 7'h0; // @[IDModule.scala 216:67]
  wire [2:0] _io_exControl_aluOpSelect_T_2 = io_imm[11:5] == 7'h0 ? 3'h5 : 3'h0; // @[IDModule.scala 216:53]
  wire [2:0] _io_exControl_aluOpSelect_T_7 = io_imm[11:5] == 7'h20 ? 3'h7 : 3'h0; // @[IDModule.scala 217:93]
  wire [2:0] _io_exControl_aluOpSelect_T_8 = _io_exControl_aluOpSelect_T_1 ? 3'h6 : _io_exControl_aluOpSelect_T_7; // @[IDModule.scala 217:53]
  wire [3:0] _GEN_144 = 3'h3 == instr[14:12] ? 4'h9 : 4'h0; // @[IDModule.scala 211:27 194:28 219:47]
  wire [3:0] _GEN_145 = 3'h2 == instr[14:12] ? 4'h8 : _GEN_144; // @[IDModule.scala 211:27 218:47]
  wire [3:0] _GEN_146 = _T_4 ? {{1'd0}, _io_exControl_aluOpSelect_T_8} : _GEN_145; // @[IDModule.scala 211:27 217:47]
  wire [3:0] _GEN_147 = _T_2 ? {{1'd0}, _io_exControl_aluOpSelect_T_2} : _GEN_146; // @[IDModule.scala 211:27 216:47]
  wire [3:0] _GEN_148 = _T_6 ? 4'h4 : _GEN_147; // @[IDModule.scala 211:27 215:47]
  wire [3:0] _GEN_149 = _T_5 ? 4'h3 : _GEN_148; // @[IDModule.scala 211:27 214:47]
  wire [3:0] _GEN_150 = _T_3 ? 4'h2 : _GEN_149; // @[IDModule.scala 211:27 213:47]
  wire [3:0] _GEN_151 = _T_1 ? 4'h0 : _GEN_150; // @[IDModule.scala 211:27 212:47]
  wire [2:0] _GEN_153 = 2'h2 == aluOPType ? instr[14:12] : 3'h2; // @[IDModule.scala 195:20 224:38 95:34]
  wire [3:0] _GEN_154 = 2'h1 == aluOPType ? _GEN_151 : 4'h0; // @[IDModule.scala 195:20]
  wire [2:0] _GEN_155 = 2'h1 == aluOPType ? 3'h2 : _GEN_153; // @[IDModule.scala 195:20 95:34]
  wire [3:0] _GEN_156 = 2'h0 == aluOPType ? _GEN_143 : _GEN_154; // @[IDModule.scala 195:20]
  wire [3:0] _GEN_158 = _T_17 ? 4'hc : _GEN_156; // @[IDModule.scala 229:21 233:46]
  wire [3:0] _GEN_159 = _T_16 ? 4'hb : _GEN_158; // @[IDModule.scala 229:21 232:46]
  wire [3:0] _GEN_160 = _T_12 ? 4'ha : _GEN_159; // @[IDModule.scala 229:21 231:46]
  wire  ldBranchHazard = io_pcSrc & io_ldBraHazard; // @[IDModule.scala 243:33]
  wire [31:0] _io_branchAddr_T_2 = $signed(rs1data) + $signed(io_imm); // @[IDModule.scala 246:68]
  wire [31:0] _io_branchAddr_T_6 = $signed(pcIn) + $signed(io_imm); // @[IDModule.scala 246:90]
  wire [31:0] _io_branchAddr_T_8 = pcSelect ? $signed(_io_branchAddr_T_2) : $signed(_io_branchAddr_T_6); // @[IDModule.scala 246:100]
  assign io_rs1data = io_forward1[0] ? $signed(io_resEX) : $signed(_rs1data_T_3); // @[IDModule.scala 57:20]
  assign io_rs2data = io_forward2[0] ? $signed(io_resEX) : $signed(_rs2data_T_3); // @[IDModule.scala 59:17]
  assign io_pcOut = pcIn; // @[IDModule.scala 249:12]
  assign io_rd = instr[11:7]; // @[IDModule.scala 252:17]
  assign io_imm = 6'h19 == instr[6:1] ? $signed(32'sh0) : $signed(_GEN_114); // @[IDModule.scala 112:10 113:22]
  assign io_branchAddr = ldBranchHazard ? pcIn : _io_branchAddr_T_8; // @[IDModule.scala 246:23]
  assign io_pcSrc = branch & branchCheck; // @[IDModule.scala 242:22]
  assign io_halt = ecall & $signed(a7) == 32'sha; // @[IDModule.scala 190:24]
  assign io_exControl_sigBundle_memWrite = 6'h19 == instr[6:1] ? 1'h0 : _GEN_118; // @[IDModule.scala 113:22 120:39]
  assign io_exControl_sigBundle_regWrite = 6'h19 == instr[6:1] | _GEN_119; // @[IDModule.scala 113:22 121:39]
  assign io_exControl_sigBundle_memToReg = 6'h19 == instr[6:1] ? 1'h0 : _GEN_120; // @[IDModule.scala 113:22 122:39]
  assign io_exControl_sigBundle_memSize = 2'h0 == aluOPType ? 3'h2 : _GEN_155; // @[IDModule.scala 195:20 95:34]
  assign io_exControl_aluSRC = 6'h19 == instr[6:1] ? 1'h0 : _GEN_116; // @[IDModule.scala 113:22 118:27]
  assign io_exControl_aluOpSelect = _T_15 ? 4'ha : _GEN_160; // @[IDModule.scala 229:21 230:46]
  assign io_exControl_rs1Idx = instr[19:15]; // @[IDModule.scala 60:31]
  assign io_exControl_rs2Idx = instr[24:20]; // @[IDModule.scala 61:31]
  always @(posedge clock) begin
    pcIn <= io_pcIn; // @[IDModule.scala 52:21]
    instr <= io_instr; // @[IDModule.scala 53:22]
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_1 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_1 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_2 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h2 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_2 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_3 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h3 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_3 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_4 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h4 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_4 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_5 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h5 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_5 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_6 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h6 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_6 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_7 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h7 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_7 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_8 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h8 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_8 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_9 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h9 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_9 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_10 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'ha == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_10 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_11 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'hb == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_11 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_12 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'hc == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_12 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_13 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'hd == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_13 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_14 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'he == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_14 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_15 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'hf == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_15 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_16 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h10 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_16 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_17 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h11 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_17 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_18 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h12 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_18 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_19 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h13 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_19 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_20 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h14 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_20 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_21 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h15 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_21 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_22 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h16 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_22 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_23 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h17 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_23 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_24 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h18 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_24 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_25 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h19 == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_25 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_26 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1a == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_26 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_27 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1b == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_27 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_28 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1c == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_28 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_29 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1d == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_29 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_30 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1e == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_30 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
    if (reset) begin // @[IDModule.scala 56:29]
      registerFile_31 <= 32'sh0; // @[IDModule.scala 56:29]
    end else if (io_regWriteIn) begin // @[IDModule.scala 237:22]
      if (5'h1f == io_writeRegIdx) begin // @[IDModule.scala 238:34]
        registerFile_31 <= io_writeRegData; // @[IDModule.scala 238:34]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcIn = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  instr = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registerFile_1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registerFile_2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registerFile_3 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registerFile_4 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registerFile_5 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registerFile_6 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registerFile_7 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registerFile_8 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registerFile_9 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registerFile_10 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registerFile_11 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registerFile_12 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registerFile_13 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registerFile_14 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registerFile_15 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registerFile_16 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registerFile_17 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registerFile_18 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registerFile_19 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registerFile_20 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registerFile_21 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registerFile_22 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registerFile_23 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registerFile_24 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registerFile_25 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registerFile_26 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registerFile_27 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registerFile_28 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registerFile_29 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registerFile_30 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  registerFile_31 = _RAND_32[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXModule(
  input         clock,
  input  [31:0] io_rs1data,
  input  [31:0] io_rs2dataIn,
  input  [31:0] io_pc,
  input  [4:0]  io_rdIn,
  input  [31:0] io_imm,
  output [31:0] io_aluResult,
  output [31:0] io_rs2DataOut,
  output [4:0]  io_rdOut,
  input         io_exControl_sigBundle_memWrite,
  input         io_exControl_sigBundle_regWrite,
  input         io_exControl_sigBundle_memToReg,
  input  [2:0]  io_exControl_sigBundle_memSize,
  input         io_exControl_aluSRC,
  input  [3:0]  io_exControl_aluOpSelect,
  input  [4:0]  io_exControl_rs1Idx,
  input  [4:0]  io_exControl_rs2Idx,
  input         io_forward1,
  input         io_forward2,
  input  [31:0] io_resMEM,
  output        io_memControl_sigBundle_memWrite,
  output        io_memControl_sigBundle_regWrite,
  output        io_memControl_sigBundle_memToReg,
  output [2:0]  io_memControl_sigBundle_memSize,
  output [4:0]  io_memControl_rs1Idx,
  output [4:0]  io_memControl_rs2Idx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] rs1data_REG; // @[EXModule.scala 36:54]
  wire [31:0] rs1data = io_forward1 ? $signed(io_resMEM) : $signed(rs1data_REG); // @[EXModule.scala 36:24]
  reg [31:0] rs2dataIn_REG; // @[EXModule.scala 37:54]
  wire [31:0] rs2dataIn = io_forward2 ? $signed(io_resMEM) : $signed(rs2dataIn_REG); // @[EXModule.scala 37:24]
  reg [31:0] pc; // @[EXModule.scala 38:28]
  reg [4:0] rdIn; // @[EXModule.scala 39:28]
  reg [31:0] imm; // @[EXModule.scala 40:28]
  reg  exControl_sigBundle_memWrite; // @[EXModule.scala 43:26]
  reg  exControl_sigBundle_regWrite; // @[EXModule.scala 43:26]
  reg  exControl_sigBundle_memToReg; // @[EXModule.scala 43:26]
  reg [2:0] exControl_sigBundle_memSize; // @[EXModule.scala 43:26]
  reg  exControl_aluSRC; // @[EXModule.scala 43:26]
  reg [3:0] exControl_aluOpSelect; // @[EXModule.scala 43:26]
  reg [4:0] exControl_rs1Idx; // @[EXModule.scala 43:26]
  reg [4:0] exControl_rs2Idx; // @[EXModule.scala 43:26]
  wire [31:0] muxALUinput = exControl_aluSRC ? $signed(imm) : $signed(rs2dataIn); // @[EXModule.scala 48:21]
  wire [31:0] _io_aluResult_T_2 = $signed(rs1data) + $signed(muxALUinput); // @[EXModule.scala 54:37]
  wire [31:0] _io_aluResult_T_5 = $signed(rs1data) - $signed(muxALUinput); // @[EXModule.scala 55:37]
  wire [31:0] _io_aluResult_T_7 = $signed(rs1data) ^ $signed(muxALUinput); // @[EXModule.scala 56:37]
  wire [31:0] _io_aluResult_T_9 = $signed(rs1data) | $signed(muxALUinput); // @[EXModule.scala 57:37]
  wire [31:0] _io_aluResult_T_11 = $signed(rs1data) & $signed(muxALUinput); // @[EXModule.scala 58:37]
  wire [31:0] _io_aluResult_T_12 = exControl_aluSRC ? $signed(imm) : $signed(rs2dataIn); // @[EXModule.scala 59:54]
  wire [62:0] _GEN_16 = {{31{rs1data[31]}},rs1data}; // @[EXModule.scala 59:37]
  wire [62:0] _io_aluResult_T_14 = $signed(_GEN_16) << _io_aluResult_T_12[4:0]; // @[EXModule.scala 59:37]
  wire [31:0] _io_aluResult_T_15 = io_forward1 ? $signed(io_resMEM) : $signed(rs1data_REG); // @[EXModule.scala 60:39]
  wire [31:0] _io_aluResult_T_18 = _io_aluResult_T_15 >> muxALUinput[4:0]; // @[EXModule.scala 60:75]
  wire [31:0] _io_aluResult_T_20 = $signed(rs1data) >>> muxALUinput[4:0]; // @[EXModule.scala 61:37]
  wire [1:0] _GEN_0 = $signed(rs1data) < $signed(muxALUinput) ? $signed(2'sh1) : $signed(2'sh0); // @[EXModule.scala 63:34 64:22 66:22]
  wire [1:0] _GEN_1 = _io_aluResult_T_15 < _io_aluResult_T_12 ? $signed(2'sh1) : $signed(2'sh0); // @[EXModule.scala 70:48 71:22 73:22]
  wire [31:0] _io_aluResult_T_23 = pc + 32'h4; // @[EXModule.scala 76:41]
  wire [31:0] _io_aluResult_T_27 = $signed(pc) + $signed(imm); // @[EXModule.scala 78:42]
  wire [31:0] _GEN_2 = 4'hc == exControl_aluOpSelect ? $signed(_io_aluResult_T_27) : $signed(32'sh0); // @[EXModule.scala 51:16 53:3 78:28]
  wire [31:0] _GEN_3 = 4'hb == exControl_aluOpSelect ? $signed(imm) : $signed(_GEN_2); // @[EXModule.scala 53:3 77:26]
  wire [31:0] _GEN_4 = 4'ha == exControl_aluOpSelect ? $signed(_io_aluResult_T_23) : $signed(_GEN_3); // @[EXModule.scala 53:3 76:27]
  wire [31:0] _GEN_5 = 4'h9 == exControl_aluOpSelect ? $signed({{30{_GEN_1[1]}},_GEN_1}) : $signed(_GEN_4); // @[EXModule.scala 53:3]
  wire [31:0] _GEN_6 = 4'h8 == exControl_aluOpSelect ? $signed({{30{_GEN_0[1]}},_GEN_0}) : $signed(_GEN_5); // @[EXModule.scala 53:3]
  wire [31:0] _GEN_7 = 4'h7 == exControl_aluOpSelect ? $signed(_io_aluResult_T_20) : $signed(_GEN_6); // @[EXModule.scala 53:3 61:26]
  wire [31:0] _GEN_8 = 4'h6 == exControl_aluOpSelect ? $signed(_io_aluResult_T_18) : $signed(_GEN_7); // @[EXModule.scala 53:3 60:26]
  wire [62:0] _GEN_9 = 4'h5 == exControl_aluOpSelect ? $signed(_io_aluResult_T_14) : $signed({{31{_GEN_8[31]}},_GEN_8}); // @[EXModule.scala 53:3 59:26]
  wire [62:0] _GEN_10 = 4'h4 == exControl_aluOpSelect ? $signed({{31{_io_aluResult_T_11[31]}},_io_aluResult_T_11}) :
    $signed(_GEN_9); // @[EXModule.scala 53:3 58:26]
  wire [62:0] _GEN_11 = 4'h3 == exControl_aluOpSelect ? $signed({{31{_io_aluResult_T_9[31]}},_io_aluResult_T_9}) :
    $signed(_GEN_10); // @[EXModule.scala 53:3 57:26]
  wire [62:0] _GEN_12 = 4'h2 == exControl_aluOpSelect ? $signed({{31{_io_aluResult_T_7[31]}},_io_aluResult_T_7}) :
    $signed(_GEN_11); // @[EXModule.scala 53:3 56:26]
  wire [62:0] _GEN_13 = 4'h1 == exControl_aluOpSelect ? $signed({{31{_io_aluResult_T_5[31]}},_io_aluResult_T_5}) :
    $signed(_GEN_12); // @[EXModule.scala 53:3 55:26]
  wire [62:0] _GEN_14 = 4'h0 == exControl_aluOpSelect ? $signed({{31{_io_aluResult_T_2[31]}},_io_aluResult_T_2}) :
    $signed(_GEN_13); // @[EXModule.scala 53:3 54:26]
  assign io_aluResult = _GEN_14[31:0];
  assign io_rs2DataOut = io_forward2 ? $signed(io_resMEM) : $signed(rs2dataIn_REG); // @[EXModule.scala 37:24]
  assign io_rdOut = rdIn; // @[EXModule.scala 86:12]
  assign io_memControl_sigBundle_memWrite = exControl_sigBundle_memWrite; // @[EXModule.scala 83:17]
  assign io_memControl_sigBundle_regWrite = exControl_sigBundle_regWrite; // @[EXModule.scala 83:17]
  assign io_memControl_sigBundle_memToReg = exControl_sigBundle_memToReg; // @[EXModule.scala 83:17]
  assign io_memControl_sigBundle_memSize = exControl_sigBundle_memSize; // @[EXModule.scala 83:17]
  assign io_memControl_rs1Idx = exControl_rs1Idx; // @[EXModule.scala 83:17]
  assign io_memControl_rs2Idx = exControl_rs2Idx; // @[EXModule.scala 83:17]
  always @(posedge clock) begin
    rs1data_REG <= io_rs1data; // @[EXModule.scala 36:54]
    rs2dataIn_REG <= io_rs2dataIn; // @[EXModule.scala 37:54]
    pc <= io_pc; // @[EXModule.scala 38:28]
    rdIn <= io_rdIn; // @[EXModule.scala 39:28]
    imm <= io_imm; // @[EXModule.scala 40:28]
    exControl_sigBundle_memWrite <= io_exControl_sigBundle_memWrite; // @[EXModule.scala 43:26]
    exControl_sigBundle_regWrite <= io_exControl_sigBundle_regWrite; // @[EXModule.scala 43:26]
    exControl_sigBundle_memToReg <= io_exControl_sigBundle_memToReg; // @[EXModule.scala 43:26]
    exControl_sigBundle_memSize <= io_exControl_sigBundle_memSize; // @[EXModule.scala 43:26]
    exControl_aluSRC <= io_exControl_aluSRC; // @[EXModule.scala 43:26]
    exControl_aluOpSelect <= io_exControl_aluOpSelect; // @[EXModule.scala 43:26]
    exControl_rs1Idx <= io_exControl_rs1Idx; // @[EXModule.scala 43:26]
    exControl_rs2Idx <= io_exControl_rs2Idx; // @[EXModule.scala 43:26]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rs1data_REG = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  rs2dataIn_REG = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  rdIn = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  imm = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  exControl_sigBundle_memWrite = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  exControl_sigBundle_regWrite = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  exControl_sigBundle_memToReg = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  exControl_sigBundle_memSize = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  exControl_aluSRC = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  exControl_aluOpSelect = _RAND_10[3:0];
  _RAND_11 = {1{`RANDOM}};
  exControl_rs1Idx = _RAND_11[4:0];
  _RAND_12 = {1{`RANDOM}};
  exControl_rs2Idx = _RAND_12[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memory(
  input         clock,
  input  [11:0] io_rdAddr,
  output [31:0] io_rdData,
  input  [11:0] io_wrAddr,
  input  [31:0] io_wrData,
  input         io_wrEna
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:4095]; // @[Memory.scala 13:24]
  wire  mem_io_rdData_MPORT_en; // @[Memory.scala 13:24]
  wire [11:0] mem_io_rdData_MPORT_addr; // @[Memory.scala 13:24]
  wire [31:0] mem_io_rdData_MPORT_data; // @[Memory.scala 13:24]
  wire [31:0] mem_MPORT_data; // @[Memory.scala 13:24]
  wire [11:0] mem_MPORT_addr; // @[Memory.scala 13:24]
  wire  mem_MPORT_mask; // @[Memory.scala 13:24]
  wire  mem_MPORT_en; // @[Memory.scala 13:24]
  reg  mem_io_rdData_MPORT_en_pipe_0;
  reg [11:0] mem_io_rdData_MPORT_addr_pipe_0;
  assign mem_io_rdData_MPORT_en = mem_io_rdData_MPORT_en_pipe_0;
  assign mem_io_rdData_MPORT_addr = mem_io_rdData_MPORT_addr_pipe_0;
  assign mem_io_rdData_MPORT_data = mem[mem_io_rdData_MPORT_addr]; // @[Memory.scala 13:24]
  assign mem_MPORT_data = io_wrData;
  assign mem_MPORT_addr = io_wrAddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_wrEna;
  assign io_rdData = mem_io_rdData_MPORT_data; // @[Memory.scala 15:13]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Memory.scala 13:24]
    end
    mem_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_io_rdData_MPORT_addr_pipe_0 <= io_rdAddr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_rdData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_rdData_MPORT_addr_pipe_0 = _RAND_2[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEMModule(
  input         clock,
  input         reset,
  input  [31:0] io_aluResult,
  input  [31:0] io_rs2Data,
  input  [4:0]  io_rdIn,
  output [31:0] io_regWriteData,
  output [4:0]  io_rdOut,
  input         io_memControl_memWrite,
  input         io_memControl_regWrite,
  input         io_memControl_memToReg,
  input  [2:0]  io_memControl_memSize,
  output        io_regWriteOut,
  output [15:0] io_ioWrite_ioLED,
  output        io_port_read,
  output        io_port_write,
  output [31:0] io_port_addr,
  output [31:0] io_port_wrData,
  input  [31:0] io_port_rdData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  memory_clock; // @[MEMModule.scala 41:25]
  wire [11:0] memory_io_rdAddr; // @[MEMModule.scala 41:25]
  wire [31:0] memory_io_rdData; // @[MEMModule.scala 41:25]
  wire [11:0] memory_io_wrAddr; // @[MEMModule.scala 41:25]
  wire [31:0] memory_io_wrData; // @[MEMModule.scala 41:25]
  wire  memory_io_wrEna; // @[MEMModule.scala 41:25]
  reg [4:0] rdIn; // @[MEMModule.scala 29:26]
  reg [31:0] aluResult; // @[MEMModule.scala 30:26]
  reg  regWrite; // @[MEMModule.scala 32:26]
  reg  memToReg; // @[MEMModule.scala 33:26]
  reg [2:0] memSize; // @[MEMModule.scala 34:26]
  wire [31:0] _memory_io_rdAddr_T = io_aluResult; // @[MEMModule.scala 45:37]
  wire [31:0] _memory_io_wrData_T = io_rs2Data; // @[MEMModule.scala 47:35]
  reg [15:0] ioLED; // @[MEMModule.scala 52:22]
  reg [31:0] ioOut; // @[MEMModule.scala 54:22]
  wire  _GEN_2 = io_memControl_memWrite ? 1'h0 : 1'h1; // @[Bus.scala 39:17 49:17 MEMModule.scala 64:36]
  wire  _T_11 = ~io_memControl_memWrite; // @[MEMModule.scala 73:12]
  wire [31:0] _GEN_9 = ~io_memControl_memWrite ? $signed(io_port_rdData) : $signed(ioOut); // @[MEMModule.scala 73:37 75:15 54:22]
  wire  _GEN_11 = 32'h1002 == io_aluResult & _T_11; // @[Bus.scala 57:17 MEMModule.scala 57:23]
  wire  _GEN_15 = 32'h1001 == io_aluResult ? _GEN_2 : _GEN_11; // @[MEMModule.scala 57:23]
  wire  _GEN_16 = 32'h1001 == io_aluResult ? 1'h0 : 1'h1; // @[MEMModule.scala 57:23]
  wire [31:0] memOutput = $signed(aluResult) >= 32'sh1000 ? $signed(ioOut) : $signed(memory_io_rdData); // @[MEMModule.scala 86:19]
  wire [31:0] _sizedMemOutput_T_3 = {24'hffffff,memOutput[7:0]}; // @[MEMModule.scala 92:68]
  wire [8:0] _sizedMemOutput_T_5 = {1'h0,memOutput[7:0]}; // @[MEMModule.scala 92:98]
  wire [31:0] _sizedMemOutput_T_7 = memOutput[7] ? _sizedMemOutput_T_3 : {{23'd0}, _sizedMemOutput_T_5}; // @[MEMModule.scala 92:117]
  wire [31:0] _sizedMemOutput_T_11 = {16'hffff,memOutput[15:0]}; // @[MEMModule.scala 93:67]
  wire [16:0] _sizedMemOutput_T_13 = {1'h0,memOutput[15:0]}; // @[MEMModule.scala 93:96]
  wire [31:0] _sizedMemOutput_T_15 = memOutput[15] ? _sizedMemOutput_T_11 : {{15'd0}, _sizedMemOutput_T_13}; // @[MEMModule.scala 93:116]
  wire [8:0] _sizedMemOutput_T_18 = {1'h0,memOutput[7:0]}; // @[MEMModule.scala 95:63]
  wire [16:0] _sizedMemOutput_T_21 = {1'h0,memOutput[15:0]}; // @[MEMModule.scala 96:62]
  wire [31:0] _GEN_25 = 3'h5 == memSize ? $signed({{15{_sizedMemOutput_T_21[16]}},_sizedMemOutput_T_21}) : $signed(32'sh0
    ); // @[MEMModule.scala 91:3 96:28 89:35]
  wire [31:0] _GEN_26 = 3'h4 == memSize ? $signed({{23{_sizedMemOutput_T_18[8]}},_sizedMemOutput_T_18}) : $signed(
    _GEN_25); // @[MEMModule.scala 91:3 95:28]
  wire [31:0] _GEN_27 = 3'h2 == memSize ? $signed(memOutput) : $signed(_GEN_26); // @[MEMModule.scala 91:3 94:28]
  wire [31:0] _GEN_28 = 3'h1 == memSize ? $signed(_sizedMemOutput_T_15) : $signed(_GEN_27); // @[MEMModule.scala 91:3 93:28]
  wire [31:0] sizedMemOutput = 3'h0 == memSize ? $signed(_sizedMemOutput_T_7) : $signed(_GEN_28); // @[MEMModule.scala 91:3 92:28]
  Memory memory ( // @[MEMModule.scala 41:25]
    .clock(memory_clock),
    .io_rdAddr(memory_io_rdAddr),
    .io_rdData(memory_io_rdData),
    .io_wrAddr(memory_io_wrAddr),
    .io_wrData(memory_io_wrData),
    .io_wrEna(memory_io_wrEna)
  );
  assign io_regWriteData = memToReg ? $signed(sizedMemOutput) : $signed(aluResult); // @[MEMModule.scala 100:25]
  assign io_rdOut = rdIn; // @[MEMModule.scala 103:12]
  assign io_regWriteOut = regWrite; // @[MEMModule.scala 104:18]
  assign io_ioWrite_ioLED = ioLED; // @[MEMModule.scala 107:20]
  assign io_port_read = 32'h1000 == io_aluResult ? 1'h0 : _GEN_15; // @[Bus.scala 57:17 MEMModule.scala 57:23]
  assign io_port_write = 32'h1000 == io_aluResult ? 1'h0 : 32'h1001 == io_aluResult & io_memControl_memWrite; // @[Bus.scala 56:18 MEMModule.scala 57:23]
  assign io_port_addr = {{31'd0}, _GEN_16};
  assign io_port_wrData = {{24'd0}, _memory_io_wrData_T[7:0]};
  assign memory_clock = clock;
  assign memory_io_rdAddr = _memory_io_rdAddr_T[11:0]; // @[MEMModule.scala 45:21]
  assign memory_io_wrAddr = _memory_io_rdAddr_T[11:0]; // @[MEMModule.scala 46:21]
  assign memory_io_wrData = io_rs2Data; // @[MEMModule.scala 47:35]
  assign memory_io_wrEna = io_memControl_memWrite; // @[MEMModule.scala 48:21]
  always @(posedge clock) begin
    rdIn <= io_rdIn; // @[MEMModule.scala 29:26]
    aluResult <= io_aluResult; // @[MEMModule.scala 30:26]
    regWrite <= io_memControl_regWrite; // @[MEMModule.scala 32:26]
    memToReg <= io_memControl_memToReg; // @[MEMModule.scala 33:26]
    memSize <= io_memControl_memSize; // @[MEMModule.scala 34:26]
    if (reset) begin // @[MEMModule.scala 52:22]
      ioLED <= 16'h0; // @[MEMModule.scala 52:22]
    end else if (32'h1000 == io_aluResult) begin // @[MEMModule.scala 57:23]
      if (io_memControl_memWrite) begin // @[MEMModule.scala 59:35]
        ioLED <= io_rs2Data[15:0]; // @[MEMModule.scala 60:15]
      end
    end
    if (reset) begin // @[MEMModule.scala 54:22]
      ioOut <= 32'sh0; // @[MEMModule.scala 54:22]
    end else if (!(32'h1000 == io_aluResult)) begin // @[MEMModule.scala 57:23]
      if (32'h1001 == io_aluResult) begin // @[MEMModule.scala 57:23]
        if (!(io_memControl_memWrite)) begin // @[MEMModule.scala 64:36]
          ioOut <= io_port_rdData; // @[MEMModule.scala 68:15]
        end
      end else if (32'h1002 == io_aluResult) begin // @[MEMModule.scala 57:23]
        ioOut <= _GEN_9;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdIn = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  aluResult = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regWrite = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  memToReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  memSize = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  ioLED = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  ioOut = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ForwardingModule(
  input  [4:0] io_rs1IdxID,
  input  [4:0] io_rs1IdxEX,
  input  [4:0] io_rs2IdxID,
  input  [4:0] io_rs2IdxEX,
  input        io_exHasLoad,
  input  [4:0] io_rdEX,
  input  [4:0] io_rdMEM,
  input        io_regWriteEX,
  input        io_regWriteMEM,
  output [1:0] io_branchControl1,
  output [1:0] io_branchControl2,
  output       io_aluControl1,
  output       io_aluControl2,
  output       io_ldBraHazard,
  output [1:0] io_ecallForward
);
  wire  _T_8 = io_rs1IdxID != 5'h0; // @[ForwardingModule.scala 54:21]
  wire [1:0] _GEN_2 = io_rs1IdxID != 5'h0 & io_regWriteMEM & io_rdMEM == io_rs1IdxID ? 2'h2 : 2'h0; // @[ForwardingModule.scala 32:21 54:76 55:23]
  wire  _T_14 = io_rdEX == io_rs1IdxID; // @[ForwardingModule.scala 58:57]
  wire  _T_16 = io_rs2IdxID != 5'h0; // @[ForwardingModule.scala 63:21]
  wire [1:0] _GEN_4 = io_rs2IdxID != 5'h0 & io_regWriteMEM & io_rdMEM == io_rs2IdxID ? 2'h2 : 2'h0; // @[ForwardingModule.scala 33:21 63:76 64:23]
  wire  _T_22 = io_rdEX == io_rs2IdxID; // @[ForwardingModule.scala 67:57]
  wire [1:0] _GEN_7 = io_regWriteMEM & io_rdMEM == 5'h11 ? 2'h2 : 2'h0; // @[ForwardingModule.scala 37:19 76:43 77:21]
  assign io_branchControl1 = _T_8 & io_regWriteEX & io_rdEX == io_rs1IdxID ? 2'h1 : _GEN_2; // @[ForwardingModule.scala 58:74 59:23]
  assign io_branchControl2 = _T_16 & io_regWriteEX & io_rdEX == io_rs2IdxID ? 2'h1 : _GEN_4; // @[ForwardingModule.scala 67:74 68:23]
  assign io_aluControl1 = io_rs1IdxEX != 5'h0 & io_rs1IdxEX == io_rdMEM & io_regWriteMEM; // @[ForwardingModule.scala 43:59]
  assign io_aluControl2 = io_rs2IdxEX != 5'h0 & io_rs2IdxEX == io_rdMEM & io_regWriteMEM; // @[ForwardingModule.scala 48:59]
  assign io_ldBraHazard = io_rdEX != 5'h0 & io_exHasLoad & (_T_14 | _T_22); // @[ForwardingModule.scala 72:41]
  assign io_ecallForward = io_regWriteEX & io_rdEX == 5'h11 ? 2'h1 : _GEN_7; // @[ForwardingModule.scala 80:41 81:21]
endmodule
module TopLevelSynthesize(
  input         clk_in1,
  input         reset,
  output [15:0] io_ioLED,
  output        io_uart_tx,
  input         io_uart_rx
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  mmUart_clock; // @[MemoryMappedUart.scala 115:31]
  wire  mmUart_reset; // @[MemoryMappedUart.scala 115:31]
  wire  mmUart_io_port_read; // @[MemoryMappedUart.scala 115:31]
  wire  mmUart_io_port_write; // @[MemoryMappedUart.scala 115:31]
  wire [31:0] mmUart_io_port_addr; // @[MemoryMappedUart.scala 115:31]
  wire [31:0] mmUart_io_port_wrData; // @[MemoryMappedUart.scala 115:31]
  wire [31:0] mmUart_io_port_rdData; // @[MemoryMappedUart.scala 115:31]
  wire  mmUart_io_pins_tx; // @[MemoryMappedUart.scala 115:31]
  wire  mmUart_io_pins_rx; // @[MemoryMappedUart.scala 115:31]
  wire  ifModule_clock; // @[TopLevelSynthesize.scala 33:24]
  wire  ifModule_reset; // @[TopLevelSynthesize.scala 33:24]
  wire  ifModule_io_pcSrc; // @[TopLevelSynthesize.scala 33:24]
  wire [31:0] ifModule_io_branchAddr; // @[TopLevelSynthesize.scala 33:24]
  wire [31:0] ifModule_io_instruction; // @[TopLevelSynthesize.scala 33:24]
  wire [31:0] ifModule_io_pc; // @[TopLevelSynthesize.scala 33:24]
  wire  ifModule_io_running; // @[TopLevelSynthesize.scala 33:24]
  wire  idModule_clock; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_reset; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_pcIn; // @[TopLevelSynthesize.scala 34:24]
  wire [4:0] idModule_io_writeRegIdx; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_regWriteIn; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_writeRegData; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_instr; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_rs1data; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_rs2data; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_pcOut; // @[TopLevelSynthesize.scala 34:24]
  wire [4:0] idModule_io_rd; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_imm; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_branchAddr; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_pcSrc; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_halt; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_resEX; // @[TopLevelSynthesize.scala 34:24]
  wire [31:0] idModule_io_resMEM; // @[TopLevelSynthesize.scala 34:24]
  wire [1:0] idModule_io_forward1; // @[TopLevelSynthesize.scala 34:24]
  wire [1:0] idModule_io_forward2; // @[TopLevelSynthesize.scala 34:24]
  wire [1:0] idModule_io_ecallForward; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_ldBraHazard; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_exControl_sigBundle_memWrite; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_exControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_exControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 34:24]
  wire [2:0] idModule_io_exControl_sigBundle_memSize; // @[TopLevelSynthesize.scala 34:24]
  wire  idModule_io_exControl_aluSRC; // @[TopLevelSynthesize.scala 34:24]
  wire [3:0] idModule_io_exControl_aluOpSelect; // @[TopLevelSynthesize.scala 34:24]
  wire [4:0] idModule_io_exControl_rs1Idx; // @[TopLevelSynthesize.scala 34:24]
  wire [4:0] idModule_io_exControl_rs2Idx; // @[TopLevelSynthesize.scala 34:24]
  wire  exModule_clock; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_rs1data; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_rs2dataIn; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_pc; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_rdIn; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_imm; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_aluResult; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_rs2DataOut; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_rdOut; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_exControl_sigBundle_memWrite; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_exControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_exControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 35:24]
  wire [2:0] exModule_io_exControl_sigBundle_memSize; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_exControl_aluSRC; // @[TopLevelSynthesize.scala 35:24]
  wire [3:0] exModule_io_exControl_aluOpSelect; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_exControl_rs1Idx; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_exControl_rs2Idx; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_forward1; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_forward2; // @[TopLevelSynthesize.scala 35:24]
  wire [31:0] exModule_io_resMEM; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_memControl_sigBundle_memWrite; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_memControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 35:24]
  wire  exModule_io_memControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 35:24]
  wire [2:0] exModule_io_memControl_sigBundle_memSize; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_memControl_rs1Idx; // @[TopLevelSynthesize.scala 35:24]
  wire [4:0] exModule_io_memControl_rs2Idx; // @[TopLevelSynthesize.scala 35:24]
  wire  memModule_clock; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_reset; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_aluResult; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_rs2Data; // @[TopLevelSynthesize.scala 36:25]
  wire [4:0] memModule_io_rdIn; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_regWriteData; // @[TopLevelSynthesize.scala 36:25]
  wire [4:0] memModule_io_rdOut; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_memControl_memWrite; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_memControl_regWrite; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_memControl_memToReg; // @[TopLevelSynthesize.scala 36:25]
  wire [2:0] memModule_io_memControl_memSize; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_regWriteOut; // @[TopLevelSynthesize.scala 36:25]
  wire [15:0] memModule_io_ioWrite_ioLED; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_port_read; // @[TopLevelSynthesize.scala 36:25]
  wire  memModule_io_port_write; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_port_addr; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_port_wrData; // @[TopLevelSynthesize.scala 36:25]
  wire [31:0] memModule_io_port_rdData; // @[TopLevelSynthesize.scala 36:25]
  wire [4:0] forwardingModule_io_rs1IdxID; // @[TopLevelSynthesize.scala 37:32]
  wire [4:0] forwardingModule_io_rs1IdxEX; // @[TopLevelSynthesize.scala 37:32]
  wire [4:0] forwardingModule_io_rs2IdxID; // @[TopLevelSynthesize.scala 37:32]
  wire [4:0] forwardingModule_io_rs2IdxEX; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_exHasLoad; // @[TopLevelSynthesize.scala 37:32]
  wire [4:0] forwardingModule_io_rdEX; // @[TopLevelSynthesize.scala 37:32]
  wire [4:0] forwardingModule_io_rdMEM; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_regWriteEX; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_regWriteMEM; // @[TopLevelSynthesize.scala 37:32]
  wire [1:0] forwardingModule_io_branchControl1; // @[TopLevelSynthesize.scala 37:32]
  wire [1:0] forwardingModule_io_branchControl2; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_aluControl1; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_aluControl2; // @[TopLevelSynthesize.scala 37:32]
  wire  forwardingModule_io_ldBraHazard; // @[TopLevelSynthesize.scala 37:32]
  wire [1:0] forwardingModule_io_ecallForward; // @[TopLevelSynthesize.scala 37:32]
  reg  halted; // @[TopLevelSynthesize.scala 39:23]
  reg  runningReg; // @[TopLevelSynthesize.scala 41:27]
  wire  _GEN_0 = halted ? 1'h0 : runningReg; // @[TopLevelSynthesize.scala 42:14 44:15 45:16]
  wire  _GEN_1 = idModule_io_halt | halted; // @[TopLevelSynthesize.scala 103:25 104:12 40:10]
  MemoryMappedUart mmUart ( // @[MemoryMappedUart.scala 115:31]
    .clock(mmUart_clock),
    .reset(mmUart_reset),
    .io_port_read(mmUart_io_port_read),
    .io_port_write(mmUart_io_port_write),
    .io_port_addr(mmUart_io_port_addr),
    .io_port_wrData(mmUart_io_port_wrData),
    .io_port_rdData(mmUart_io_port_rdData),
    .io_pins_tx(mmUart_io_pins_tx),
    .io_pins_rx(mmUart_io_pins_rx)
  );
  IFModuleTest ifModule ( // @[TopLevelSynthesize.scala 33:24]
    .clock(ifModule_clock),
    .reset(ifModule_reset),
    .io_pcSrc(ifModule_io_pcSrc),
    .io_branchAddr(ifModule_io_branchAddr),
    .io_instruction(ifModule_io_instruction),
    .io_pc(ifModule_io_pc),
    .io_running(ifModule_io_running)
  );
  IDModule idModule ( // @[TopLevelSynthesize.scala 34:24]
    .clock(idModule_clock),
    .reset(idModule_reset),
    .io_pcIn(idModule_io_pcIn),
    .io_writeRegIdx(idModule_io_writeRegIdx),
    .io_regWriteIn(idModule_io_regWriteIn),
    .io_writeRegData(idModule_io_writeRegData),
    .io_instr(idModule_io_instr),
    .io_rs1data(idModule_io_rs1data),
    .io_rs2data(idModule_io_rs2data),
    .io_pcOut(idModule_io_pcOut),
    .io_rd(idModule_io_rd),
    .io_imm(idModule_io_imm),
    .io_branchAddr(idModule_io_branchAddr),
    .io_pcSrc(idModule_io_pcSrc),
    .io_halt(idModule_io_halt),
    .io_resEX(idModule_io_resEX),
    .io_resMEM(idModule_io_resMEM),
    .io_forward1(idModule_io_forward1),
    .io_forward2(idModule_io_forward2),
    .io_ecallForward(idModule_io_ecallForward),
    .io_ldBraHazard(idModule_io_ldBraHazard),
    .io_exControl_sigBundle_memWrite(idModule_io_exControl_sigBundle_memWrite),
    .io_exControl_sigBundle_regWrite(idModule_io_exControl_sigBundle_regWrite),
    .io_exControl_sigBundle_memToReg(idModule_io_exControl_sigBundle_memToReg),
    .io_exControl_sigBundle_memSize(idModule_io_exControl_sigBundle_memSize),
    .io_exControl_aluSRC(idModule_io_exControl_aluSRC),
    .io_exControl_aluOpSelect(idModule_io_exControl_aluOpSelect),
    .io_exControl_rs1Idx(idModule_io_exControl_rs1Idx),
    .io_exControl_rs2Idx(idModule_io_exControl_rs2Idx)
  );
  EXModule exModule ( // @[TopLevelSynthesize.scala 35:24]
    .clock(exModule_clock),
    .io_rs1data(exModule_io_rs1data),
    .io_rs2dataIn(exModule_io_rs2dataIn),
    .io_pc(exModule_io_pc),
    .io_rdIn(exModule_io_rdIn),
    .io_imm(exModule_io_imm),
    .io_aluResult(exModule_io_aluResult),
    .io_rs2DataOut(exModule_io_rs2DataOut),
    .io_rdOut(exModule_io_rdOut),
    .io_exControl_sigBundle_memWrite(exModule_io_exControl_sigBundle_memWrite),
    .io_exControl_sigBundle_regWrite(exModule_io_exControl_sigBundle_regWrite),
    .io_exControl_sigBundle_memToReg(exModule_io_exControl_sigBundle_memToReg),
    .io_exControl_sigBundle_memSize(exModule_io_exControl_sigBundle_memSize),
    .io_exControl_aluSRC(exModule_io_exControl_aluSRC),
    .io_exControl_aluOpSelect(exModule_io_exControl_aluOpSelect),
    .io_exControl_rs1Idx(exModule_io_exControl_rs1Idx),
    .io_exControl_rs2Idx(exModule_io_exControl_rs2Idx),
    .io_forward1(exModule_io_forward1),
    .io_forward2(exModule_io_forward2),
    .io_resMEM(exModule_io_resMEM),
    .io_memControl_sigBundle_memWrite(exModule_io_memControl_sigBundle_memWrite),
    .io_memControl_sigBundle_regWrite(exModule_io_memControl_sigBundle_regWrite),
    .io_memControl_sigBundle_memToReg(exModule_io_memControl_sigBundle_memToReg),
    .io_memControl_sigBundle_memSize(exModule_io_memControl_sigBundle_memSize),
    .io_memControl_rs1Idx(exModule_io_memControl_rs1Idx),
    .io_memControl_rs2Idx(exModule_io_memControl_rs2Idx)
  );
  MEMModule memModule ( // @[TopLevelSynthesize.scala 36:25]
    .clock(memModule_clock),
    .reset(memModule_reset),
    .io_aluResult(memModule_io_aluResult),
    .io_rs2Data(memModule_io_rs2Data),
    .io_rdIn(memModule_io_rdIn),
    .io_regWriteData(memModule_io_regWriteData),
    .io_rdOut(memModule_io_rdOut),
    .io_memControl_memWrite(memModule_io_memControl_memWrite),
    .io_memControl_regWrite(memModule_io_memControl_regWrite),
    .io_memControl_memToReg(memModule_io_memControl_memToReg),
    .io_memControl_memSize(memModule_io_memControl_memSize),
    .io_regWriteOut(memModule_io_regWriteOut),
    .io_ioWrite_ioLED(memModule_io_ioWrite_ioLED),
    .io_port_read(memModule_io_port_read),
    .io_port_write(memModule_io_port_write),
    .io_port_addr(memModule_io_port_addr),
    .io_port_wrData(memModule_io_port_wrData),
    .io_port_rdData(memModule_io_port_rdData)
  );
  ForwardingModule forwardingModule ( // @[TopLevelSynthesize.scala 37:32]
    .io_rs1IdxID(forwardingModule_io_rs1IdxID),
    .io_rs1IdxEX(forwardingModule_io_rs1IdxEX),
    .io_rs2IdxID(forwardingModule_io_rs2IdxID),
    .io_rs2IdxEX(forwardingModule_io_rs2IdxEX),
    .io_exHasLoad(forwardingModule_io_exHasLoad),
    .io_rdEX(forwardingModule_io_rdEX),
    .io_rdMEM(forwardingModule_io_rdMEM),
    .io_regWriteEX(forwardingModule_io_regWriteEX),
    .io_regWriteMEM(forwardingModule_io_regWriteMEM),
    .io_branchControl1(forwardingModule_io_branchControl1),
    .io_branchControl2(forwardingModule_io_branchControl2),
    .io_aluControl1(forwardingModule_io_aluControl1),
    .io_aluControl2(forwardingModule_io_aluControl2),
    .io_ldBraHazard(forwardingModule_io_ldBraHazard),
    .io_ecallForward(forwardingModule_io_ecallForward)
  );
    clk_wiz_0 instance_name
   (
    // Clock out ports
    .clock(clock),     // output clock
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_in1));      // input clk_in1
  assign io_ioLED = memModule_io_ioWrite_ioLED; // @[TopLevelSynthesize.scala 109:12]
  assign io_uart_tx = mmUart_io_pins_tx; // @[TopLevelSynthesize.scala 111:11]
  assign mmUart_clock = clock;
  assign mmUart_reset = reset;
  assign mmUart_io_port_read = memModule_io_port_read; // @[TopLevelSynthesize.scala 110:21]
  assign mmUart_io_port_write = memModule_io_port_write; // @[TopLevelSynthesize.scala 110:21]
  assign mmUart_io_port_addr = memModule_io_port_addr; // @[TopLevelSynthesize.scala 110:21]
  assign mmUart_io_port_wrData = memModule_io_port_wrData; // @[TopLevelSynthesize.scala 110:21]
  assign mmUart_io_pins_rx = io_uart_rx; // @[TopLevelSynthesize.scala 111:11]
  assign ifModule_clock = clock;
  assign ifModule_reset = reset;
  assign ifModule_io_pcSrc = idModule_io_pcSrc; // @[TopLevelSynthesize.scala 49:21]
  assign ifModule_io_branchAddr = idModule_io_branchAddr; // @[TopLevelSynthesize.scala 50:26]
  assign ifModule_io_running = runningReg; // @[TopLevelSynthesize.scala 101:23]
  assign idModule_clock = clock;
  assign idModule_reset = reset;
  assign idModule_io_pcIn = ifModule_io_pc; // @[TopLevelSynthesize.scala 53:20]
  assign idModule_io_writeRegIdx = memModule_io_rdOut; // @[TopLevelSynthesize.scala 54:27]
  assign idModule_io_regWriteIn = memModule_io_regWriteOut; // @[TopLevelSynthesize.scala 55:26]
  assign idModule_io_writeRegData = memModule_io_regWriteData; // @[TopLevelSynthesize.scala 56:28]
  assign idModule_io_instr = idModule_io_halt ? 32'h13 : ifModule_io_instruction; // @[TopLevelSynthesize.scala 103:25 105:23 57:21]
  assign idModule_io_resEX = exModule_io_aluResult; // @[TopLevelSynthesize.scala 58:21]
  assign idModule_io_resMEM = memModule_io_regWriteData; // @[TopLevelSynthesize.scala 59:22]
  assign idModule_io_forward1 = forwardingModule_io_branchControl1; // @[TopLevelSynthesize.scala 60:24]
  assign idModule_io_forward2 = forwardingModule_io_branchControl2; // @[TopLevelSynthesize.scala 61:24]
  assign idModule_io_ecallForward = forwardingModule_io_ecallForward; // @[TopLevelSynthesize.scala 63:28]
  assign idModule_io_ldBraHazard = forwardingModule_io_ldBraHazard; // @[TopLevelSynthesize.scala 62:27]
  assign exModule_clock = clock;
  assign exModule_io_rs1data = idModule_io_rs1data; // @[TopLevelSynthesize.scala 66:23]
  assign exModule_io_rs2dataIn = idModule_io_rs2data; // @[TopLevelSynthesize.scala 67:25]
  assign exModule_io_pc = idModule_io_pcOut; // @[TopLevelSynthesize.scala 68:18]
  assign exModule_io_rdIn = idModule_io_rd; // @[TopLevelSynthesize.scala 69:20]
  assign exModule_io_imm = idModule_io_imm; // @[TopLevelSynthesize.scala 70:19]
  assign exModule_io_exControl_sigBundle_memWrite = idModule_io_exControl_sigBundle_memWrite; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_sigBundle_regWrite = idModule_io_exControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_sigBundle_memToReg = idModule_io_exControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_sigBundle_memSize = idModule_io_exControl_sigBundle_memSize; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_aluSRC = idModule_io_exControl_aluSRC; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_aluOpSelect = idModule_io_exControl_aluOpSelect; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_rs1Idx = idModule_io_exControl_rs1Idx; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_exControl_rs2Idx = idModule_io_exControl_rs2Idx; // @[TopLevelSynthesize.scala 71:25]
  assign exModule_io_forward1 = forwardingModule_io_aluControl1; // @[TopLevelSynthesize.scala 73:24]
  assign exModule_io_forward2 = forwardingModule_io_aluControl2; // @[TopLevelSynthesize.scala 74:24]
  assign exModule_io_resMEM = memModule_io_regWriteData; // @[TopLevelSynthesize.scala 72:22]
  assign memModule_clock = clock;
  assign memModule_reset = reset;
  assign memModule_io_aluResult = exModule_io_aluResult; // @[TopLevelSynthesize.scala 77:26]
  assign memModule_io_rs2Data = exModule_io_rs2DataOut; // @[TopLevelSynthesize.scala 78:24]
  assign memModule_io_rdIn = exModule_io_rdOut; // @[TopLevelSynthesize.scala 79:21]
  assign memModule_io_memControl_memWrite = exModule_io_memControl_sigBundle_memWrite; // @[TopLevelSynthesize.scala 80:27]
  assign memModule_io_memControl_regWrite = exModule_io_memControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 80:27]
  assign memModule_io_memControl_memToReg = exModule_io_memControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 80:27]
  assign memModule_io_memControl_memSize = exModule_io_memControl_sigBundle_memSize; // @[TopLevelSynthesize.scala 80:27]
  assign memModule_io_port_rdData = mmUart_io_port_rdData; // @[TopLevelSynthesize.scala 110:21]
  assign forwardingModule_io_rs1IdxID = idModule_io_exControl_rs1Idx; // @[TopLevelSynthesize.scala 89:32]
  assign forwardingModule_io_rs1IdxEX = exModule_io_memControl_rs1Idx; // @[TopLevelSynthesize.scala 87:32]
  assign forwardingModule_io_rs2IdxID = idModule_io_exControl_rs2Idx; // @[TopLevelSynthesize.scala 90:32]
  assign forwardingModule_io_rs2IdxEX = exModule_io_memControl_rs2Idx; // @[TopLevelSynthesize.scala 88:32]
  assign forwardingModule_io_exHasLoad = exModule_io_memControl_sigBundle_memToReg; // @[TopLevelSynthesize.scala 91:33]
  assign forwardingModule_io_rdEX = exModule_io_rdOut; // @[TopLevelSynthesize.scala 83:28]
  assign forwardingModule_io_rdMEM = memModule_io_rdOut; // @[TopLevelSynthesize.scala 84:29]
  assign forwardingModule_io_regWriteEX = exModule_io_memControl_sigBundle_regWrite; // @[TopLevelSynthesize.scala 85:34]
  assign forwardingModule_io_regWriteMEM = memModule_io_regWriteOut; // @[TopLevelSynthesize.scala 86:35]
  always @(posedge clock) begin
    if (reset) begin // @[TopLevelSynthesize.scala 39:23]
      halted <= 1'h0; // @[TopLevelSynthesize.scala 39:23]
    end else begin
      halted <= _GEN_1;
    end
    runningReg <= reset | _GEN_0; // @[TopLevelSynthesize.scala 41:{27,27}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  halted = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  runningReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
