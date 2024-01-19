# 02114 : Our processor, UART-IG
## How to use our source code
In its base form the project can only run simulation tests. This can be done by writing this in the console:
```
sbt test
```
This will run all tests in the project. Its important to note that the TopLevelCAETest11 and -14 are expected to fail.
This is because they expect byte-sized memory elements and a shared memory for both instructions and data.
This is not the implementation we went with for our processor.

## How to generate verilog file for synthesizing on an FPGA board
Sadly we did not have time to implement scala variable dependent hardware generation to change between version of the project.
Instead we made two separate toplevel files. One for testing and one for synthesizing. Only the TopLevelSynthesize will be compiled when running
```
sbt run
```
The verilog file should then be generated in the root of the repo.
The constraint file can be found in the root of the repo.
The verilog needs to be altered to change the clockfrequency. This is done by copying the following code block into the toplevel in the verilog file:
```
// Clock out ports
    .clock(clock),     // output clock
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk_in1));      // input clk_in1
```
Then changing the clock signal in the toplevel io in verilog to be named `clk_in1` instead of `clock`

We then need to add a clock wizard module that creates the new clock. This can be done usin vivados clock wizard ip. 
We have already done this for you so all you need to do is add the `clk_wiz_0.xci` 

The TopLevelSynthesize toplevel-file has a hardcoded instrmemory that runs the following program:
```
main:
    addi x3 x0 1
    addi x2 x0 0
    addi x5 x0 5
    addi x31 x0 31
    addi x30 x0 1
    ##addi x28 x0 3
    li x29 4096
    j fibo
end:
    li a7, 10
    ecall
fibo:
    add x2 x3 x2 #fibo op 1
    jal x7 checkStatus1
    add x3 x2 x3 #fibo op 2
    jal x7 checkStatus2
    addi x4 x4 1
    bne x4 x5 fibo
    j LED
checkStatus1:
    lw x28 2(x29)
    slli x28 x28 31
    srli x28 x28 31
    bne x28 x30 checkStatus1
    sw x2 1(x29) #memory mapped uart
    jr x7
checkStatus2:
    lw x28 2(x29)
    slli x28 x28 31
    srli x28 x28 31
    bne x28 x30 checkStatus2
    sw x3 1(x29) #memory mapped uart
    jr x7
LED:
    sw x3 0(x29) #memory mapped uart
    j end
```
This program calculates a small sequence of fibonacci numbers and outputs them as raw data bytes to the uart while doing handshaking.
The LED IO is also utilized to display the last number of the sequence in binary.

## Credits
The project was made following the outline given in [02114 Design of a RISC-V Microprocessor](https://github.com/schoeberl/risc-v-lab)
The `Bus` and `MemoryMappedUart` files were written by [Tjark Petersen](https://github.com/tjarker)