import os, sys

"""
Generate the base for the Logisim-evolution's 'hex words addressed' format.
The base is split into a list of strings for easier modification.
"""
def generate_hex_words_base():
    ret = []
    ret.append("v3.0 hex words addressed\n")
    for i in range(2048):
        ret.append(
            f"{i * 8:04x}: "
            "00000000 00000000 00000000 00000000 "
            "00000000 00000000 00000000 00000000\n"
        );
    return ret

"""
Write a byte of data at a specified address into the string representation of the dataset.
"""
def write_byte(byte_in, address, base):
    line = (address // 32) + 1
    column = address % 32
    column = 6 + (column // 4) * 9 + 2 * (3 - (column % 4))

    base[line] = base[line][:column] + byte_in + base[line][column + 2:]

"""
Transform data from the Intel HEX format into the Logisim-evolution's 'hex words addressed' format.
"""
def hex_to_logisim(hex_in, base):
    segment_offset = 0
    linear_offset = 0
    for line in hex_in:
        line = line.split(":")[1]
        count = int(line[0:2], 16)
        address = int(line[2:6], 16)
        rectype = line[6:8]
        data = line[8:-2]

        match rectype:
            case "00": # Data
                address += segment_offset + linear_offset
                for i in range(count):
                    chunk = data[(2 * i):(2 * i + 2)]
                    write_byte(chunk, address + i, base)
            case "01": # End Of File
                break
            case "02": # Extended Segment Address
                segment_offset = int(data, 16) * 16
            case "04": # Extended Linear Address
                segment_offset = int(data + "0000", 16)
            case _:
                print(f"Unsupported record type: {rectype}.")
                exit(1)

"""
Assemble, link and convert a RISC-V assembly source file into the Logisim-evolution's 'hex words
addressed' format.
This script has only been tested on Arch Linux, using `riscv64-elf-gcc` and `riscv64-elf-binutils`
packages.
The script creates some intermediate files that remain on disk, unless you uncomment the final line.
"""
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(f"Usage: python {sys.argv[0]} [linker script] [input file].s", file=sys.stderr)

    linker_script = sys.argv[1]
    fname = sys.argv[2]
    fname, _ = os.path.splitext(fname)

    # Assemble the source.
    err = os.system(f"riscv64-elf-as -march=rv32i -mlittle-endian -o {fname}.o {fname}.s")
    if err != 0:
        print("'as' failed.", file=sys.stderr)
        exit(err)

    # Link the assembled output.
    err = os.system(f"riscv64-elf-ld -melf32lriscv -T {linker_script} -o {fname}.l.o {fname}.o")
    if err != 0:
        print("'ld' failed.", file=sys.stderr)
        exit(err)

    # Convert the ELF file into an Intel HEX file.
    err = os.system(f"riscv64-elf-objcopy -O ihex {fname}.l.o {fname}.hex")
    if err != 0:
        print("'objcopy' failed.", file=sys.stderr)
        exit(err)

    # Convert the Intel HEX file into the Logisim-evolution's 'v3.0 hex words addressed' format.
    base = generate_hex_words_base()
    with open(f"{fname}.hex", "r") as f_in:
        hex_in = f_in.readlines()
    hex_to_logisim(hex_in, base)

    with open(f"{fname}.lgs", "w") as f_out:
        for l in base:
            f_out.write(l)

    # Optional: cleanup.
    # os.system(f"rm -f {fname}.o {fname}.l.o {fname}.hex")
