# Alpha

A simple RV32I core.

## Instruction types

Internally the core recognizes 11 instruction type values, of which 9 are legal.
The core considers SYSTEM instructions illegal, but the distinct value was added to more closely follow the RISC-V specification.
When the core encounters an illegal instruction, it halts immediately until reset.

| value | name    |
| ----- | ------- |
| 0     | ILLEGAL |
| 1     | OP      |
| 2     | OP_IMM  |
| 3     | AUIPC   |
| 4     | LUI     |
| 5     | LOAD    |
| 6     | STORE   |
| 7     | BRANCH  |
| 8     | JALR    |
| 9     | JAL     |
| 10    | SYSTEM  |

## State machine

The core operates as a state machine with 4 states: `continue`, `single`, `double` and `halt`.

In `single` state the core has loaded an instruction that can be executed in a single clock cycle.
This includes all instructions that do not access memory and do modify the program counter.
As such the next instruction can be loaded immediately, in parallel with execution of the current instruction.

In `double` state the core has loaded an instruction that needs to be executed in two clock cycles.
This includes all instructions that access memory or modify the program counter.
Since in this state either the memory bus is busy or the program counter can change unpredictably, the next instruction cannot be loaded in parallel.

In `continue` state the core does not have the appropriate instruction loaded.
The core enters this state following either a reset signal or a `double` state.

In `halt` state the core does not execute anything.
The core enters this state when an illegal instruction is detected, and it only exits this state when a reset signal is provided.

## Instruction clock count

The core executes instructions in 1 or 2 clock cycles, depending on the instruction type.
Instructions of the OP, OP_IMM, AUIPC and LUI type execute in one clock cycle, while instructions of the LOAD, STORE, BRANCH, JALR and JAL type execute in two clock cycles.
The LOAD and STORE instructions use one clock cycle to access memory, and the other to load the next instruction.
The BRANCH, JALR and JAL instructions use one clock cycle to adjust the program counter, and the other to load the next instruction at the loaded address.

## Memory and address space

The core can access the whole 32-bit address space, but the included examples only provide 16kwords of ROM and 16kwords of RAM.
Additionally, various IO devices can be mapped into the address space, such as a TTY in the examples.

The core does not support unaligned memory accesses and will halt when it encounters one.
The writes to non-writable memory (ROM) are ignored, as the core does not distinguish between read-only, writable and executable sections of the address space.