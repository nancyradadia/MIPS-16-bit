# MIPS-16-bit

It is a 16 bit RISC based single core microprocessor which is used to perform various arithmetic and logical operations designed in Verilog. It has been divided into different blocks and further compiled to one verilog file.
Each block has its own testing file.

## Specifications
- It is a 16 bit processor.
- The instruction set size is 28.
- Additionally, Booth's multipler and divider using restoring algorithm. Hence, there are 30 instructions.
- It is a RISC based Instruction Set Architecture.
- Address bit - 16
- Registers - 32
- Instruction format: R type

## Building Components

- Execution Block
- Program Memory Block
- Register Bank Block
- Data Memory Block
- Writeback Block
- Jump Control Block
- Stall Control Block
- Dependency Check Block

Complete Block Diagram:.
![BlockDiagram](https://github.com/dhatrikapuriya/MIPS-16-bit/blob/master/BlockDiagram.png?raw=true)

## ALU Instructions

| Instruction | Description |
| ------ | -------- |
| ADD | Addition |
| SUB | Subtraction |
| MOV | Move |
| AND | Logical |
| OR | Logical |
| XOR | Logical |
| NOT | Logical |
| ADI | Add with one immediate value |
| SBI | Subtract with one immediate value |
| MVI | Move immediate value |
| ANI | Logical with one immediate value |
| ORI | Logical with one immediate value |
| XRI | Logical with one immediate value |
| NTI | Logical with one immediate value |
| RET | Return from an interrupt |
| HLT | Halt |
| LD | Load from data memory |
| ST | Store to data memory |
| IN | Take serial data in |
| OUT | Give serial data out |
| JMP | Unconditional jump |
| LS | Left shift |
| RS | Right shift |
| RSA | Right shift arithmetic |
| JV | Jump if overflow |
| JNV | Jump if not overflow |
| JZ | Jump if zero |
| JNZ | Jump if not zero |
| MUL | Multiplication using Booth's algorithm |
| DIV | Division Using Restoring Algorithm |
