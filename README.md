# `logi-rv`

A collection of RISC-V cores implemented in Logisim-evolution.

## Status

This project is finished, due to the difficulty of working on complex CPU designs in Logisim-evolution.
For any questions please don't hesitate to open an issue.

## Background

This project began in December 2022, when I wondered how difficult it would be to implement a simple RISC-V core.
I have studied CPU design in the past, and worked with various educational architectures such as [HIP] and [SIC/XE].
For an initial design, I followed the excellent [Nandgame] in [Logisim-evolution], but substituted and added necessary logic as the RISC-V architecture diverged from the one on the site.
In about 5 days I created a simple but functional RV32I core, which I named `alpha`.

In the following months I refined the design, removing the intermediate logic blocks and cleaning up the remaining parts.
Initially I tested the design using handwritten machine code, but I quickly moved to [GNU Assembler], as test programs became larger and harder to keep track of.
The programs I wrote are located in the `asm` directory.
Since Logisim-evolution does not support loading ELF files into ROM components, I wrote a Python script, `asm2logisim.py`, that converts them into a suitable format.
With this I could test all instructions and make sure they work correctly.

During this time I realized that Logisim-evolution is not an optimal tool for CPU design, especially if I want to simulate my designs during development.
The simulation of `alpha` ran at around 100Hz on my computer, which made it very slow to simulate larger programs with thousands of instructions.
While I wanted to iterate on the design and create more RISC-V cores, the low simulation speed made it less enjoyable than the early design stages, so I decided to retire the project instead.

For the last experiment I decided to try to run [Rust] on `alpha`.
This was not hard, as there exists an excellent [`riscv-rt`] crate with instructions for how to compile and link code for a RISC-V core.
The only problem I came across was that while the target `riscv32i-unknown-none-elf` exists, the Rust compiler also emits instructions from the `Zicsr` extension, which I have not implemented.
I couldn't find a way to disable this, so I instead modified the `asm2logisim.py` script to replace all system instructions with `nop`s.
This solution works well enough for a simple Hello world example to run on `alpha`. The code for this example is located in the `rust` directory.

I consider the `logi-rv` project finished, as I have no intention of continuing the work in Logisim-evolution.
I may port the `alpha` core into another environment, such as Verilog or VHDL in the future, and continue exploring there.
I do believe I have learned a lot with this project, but I want to explore other things as well.

[HIP]: https://doi.org/10.1016/0165-6074(87)90144-X
[SIC/XE]: https://en.wikipedia.org/wiki/Simplified_Instructional_Computer
[Nandgame]: https://nandgame.com/
[Logisim-evolution]: https://github.com/logisim-evolution/logisim-evolution
[GNU Assembler]: https://www.gnu.org/software/binutils/
[Rust]: https://www.rust-lang.org/
[`riscv-rt`]: https://docs.rs/riscv-rt/latest/riscv_rt/
