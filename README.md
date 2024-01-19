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
The verilog file should then be generated in the root of the project.

## Credits
The project was made following the outline given in [02114 Design of a RISC-V Microprocessor](https://github.com/schoeberl/risc-v-lab)
The `Bus` and `MemoryMappedUart` files were written by [Tjark Petersen](https://github.com/tjarker)