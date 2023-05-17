# A program that executes all valid RV32I instructions and prints the results.
# Meant to verify the correctness of the core implementation.

.globl _boot
.section .text

.equ RAM, 0x10000
.equ TTY, 0x20000

_boot:
    # Print header.
    la a0, header
    jal print_str
    la a0, separator
    jal print_str

    # OP instructions
    la a0, test_OP
    jal print_str

    la a0, test_OP_add
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    add a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_sub
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    sub a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_xor
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    xor a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_or
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    or a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_and
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    and a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_sll
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    sll a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_srl
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    srl a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_sra
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    sra a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_slt
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    slt a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_sltu
    jal print_str
    li t0, 0x01234567
    li t1, 0x89abcdef
    sltu a0, t0, t1
    jal print_u32
    la a0, newline
    jal print_str

    la a0, separator
    jal print_str

    # OP_IMM instructions
    la a0, test_OP_IMM
    jal print_str

    la a0, test_OP_IMM_addi
    jal print_str
    li t0, 0x01234567
    addi a0, t0, 0x123
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_addi_neg
    jal print_str
    li t0, 0x01234567
    addi a0, t0, -0x123
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_xori
    jal print_str
    li t0, 0x01234567
    xori a0, t0, 0x123
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_ori
    jal print_str
    li t0, 0x01234567
    ori a0, t0, 0x123
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_andi
    jal print_str
    li t0, 0x01234567
    andi a0, t0, 0x123
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_slli
    jal print_str
    li t0, 0x89abcdef
    slli a0, t0, 0x12
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_srli
    jal print_str
    li t0, 0x89abcdef
    srli a0, t0, 0x12
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_srai
    jal print_str
    li t0, 0x89abcdef
    srai a0, t0, 0x12
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_slti
    jal print_str
    li t0, 0x89abcdef
    slti a0, t0, 0x12
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_OP_IMM_sltiu
    jal print_str
    li t0, 0x89abcdef
    sltiu a0, t0, 0x12
    jal print_u32
    la a0, newline
    jal print_str

    la a0, separator
    jal print_str

    # BRANCH instructions
    la a0, test_BRANCH
    jal print_str

    la a0, test_BRANCH_beq_n
    jal print_str
    li t0, 0x123
    li t1, 0x456
    beq t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_beq_y
    jal print_str
    li t0, 0x123
    li t1, 0x123
    beq t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bne_y
    jal print_str
    li t0, 0x123
    li t1, 0x456
    bne t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bne_n
    jal print_str
    li t0, 0x123
    li t1, 0x123
    bne t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_blt_l
    jal print_str
    li t0, 0x123
    li t1, 0x456
    blt t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_blt_e
    jal print_str
    li t0, 0x123
    li t1, 0x123
    blt t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_blt_g
    jal print_str
    li t0, 0x456
    li t1, 0x123
    blt t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bge_l
    jal print_str
    li t0, 0x123
    li t1, 0x456
    bge t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bge_e
    jal print_str
    li t0, 0x123
    li t1, 0x123
    bge t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bge_g
    jal print_str
    li t0, 0x456
    li t1, 0x123
    bge t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bltu_l
    jal print_str
    li t0, 0x12300000
    li t1, 0xf4560000
    bltu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bltu_e
    jal print_str
    li t0, 0x12300000
    li t1, 0x12300000
    bltu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bltu_g
    jal print_str
    li t0, 0xf4560000
    li t1, 0x12300000
    bltu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bgeu_l
    jal print_str
    li t0, 0x12300000
    li t1, 0xf4560000
    bgeu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bgeu_e
    jal print_str
    li t0, 0x12300000
    li t1, 0x12300000
    bgeu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, test_BRANCH_bgeu_g
    jal print_str
    li t0, 0xf4560000
    li t1, 0x12300000
    bgeu t0, t1, 1f
    la a0, no
    j 2f
1:
    la a0, yes
2:
    jal print_str

    la a0, separator
    jal print_str

    # JAL, JALR, LUI, AUIPC
    la a0, test_JAL_JALR_AUIPC
    jal print_str

    la a0, test_JAL
    jal print_str

    la a0, test_JALR
    la t0, print_str
    jalr t0

    la a0, test_LUI
    jal print_str
    lui a0, 0x12345
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_AUIPC
    jal print_str
    auipc a0, 0x12345
    jal print_u32
    la a0, newline
    jal print_str

    la a0, separator
    jal print_str

    # LOAD, STORE instructions
    la a0, test_LOAD_STORE
    jal print_str

    li a1, RAM
    sw zero, 0(a1)
    sw zero, 4(a1)
    sw zero, 8(a1)
    la a0, test_LOAD_STORE_init
    jal print_str
    la a0, test_LOAD_STORE_checking
    jal print_str
    lw a0, 0(a1)
    jal print_u32
    la a0, comma_sep
    jal print_str
    lw a0, 4(a1)
    jal print_u32
    la a0, comma_sep
    jal print_str
    lw a0, 8(a1)
    jal print_u32
    la a0, newline
    jal print_str

    li a0, 0x12345678
    sw a0, 0(a1)
    la a0, test_LOAD_STORE_sw_1
    jal print_str
    li a0, 0xabcdefff
    sw a0, 4(a1)
    la a0, test_LOAD_STORE_sw_2
    jal print_str
    li a0, 0x76543210
    sw a0, 8(a1)
    la a0, test_LOAD_STORE_sw_3
    jal print_str
    la a0, test_LOAD_STORE_checking
    jal print_str
    lw a0, 0(a1)
    jal print_u32
    la a0, comma_sep
    jal print_str
    lw a0, 4(a1)
    jal print_u32
    la a0, comma_sep
    jal print_str
    lw a0, 8(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lw
    jal print_str
    lw a0, 4(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lh_pos
    jal print_str
    lh a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lh_neg
    jal print_str
    lh a0, 4(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lhu_pos
    jal print_str
    lhu a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lhu_neg
    jal print_str
    lhu a0, 4(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lb_pos
    jal print_str
    lb a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lb_neg
    jal print_str
    lb a0, 4(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lbu_pos
    jal print_str
    lbu a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    la a0, test_LOAD_STORE_lbu_neg
    jal print_str
    lbu a0, 4(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sh_1
    jal print_str
    li a0, 0x1234
    sh a0, 0(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sh_2
    jal print_str
    li a0, 0x1234
    sh a0, 2(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sb_1
    jal print_str
    li a0, 0x12
    sb a0, 0(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sb_2
    jal print_str
    li a0, 0x12
    sb a0, 1(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sb_3
    jal print_str
    li a0, 0x12
    sb a0, 2(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    sw zero, 0(a1)
    la a0, test_LOAD_STORE_sb_4
    jal print_str
    li a0, 0x12
    sb a0, 3(a1)
    lw a0, 0(a1)
    jal print_u32
    la a0, newline
    jal print_str

    j end

# Print a string to the TTY.
# a0: address of string to print to TTY
# t0: char at a0
# t1: TTY address
print_str:
    li t1, TTY
print_str_loop:
    lbu t0, 0(a0)
    beq t0, zero, print_str_ret
    sb t0, 0(t1)
    addi a0, a0, 1
    j print_str_loop
print_str_ret:
    ret

# Print an unsigned integer in hexadecimal format to the TTY.
# a0: integer to print to TTY
# t0: char to print
# t1: TTY address
# t2: byte counter
# t3: constant 57
print_u32:
    li t1, TTY
    li t0, '0'
    sb t0, 0(t1)
    li t0, 'x'
    sb t0, 0(t1)
    li t2, 8
    li t3, 58
print_u32_loop:
    srli t0, a0, 28
    slli a0, a0, 4
    or a0, a0, t0
    addi t2, t2, -1
    addi t0, t0, 48 # '0'
    blt t0, t3, print_u32_alpha
    addi t0, t0, 39 # 'a' - 10 - 48
print_u32_alpha:
    sb t0, 0(t1)
    bgtz t2, print_u32_loop
    ret

end:
    .word 0x00000000

# Output structure
header:
    .string "RV32I core: 'alpha'\nTesting all instructions.\n"
test_OP:
    .string "OP instructions:\n"
test_OP_add:
    .string "    add  0x01234567, 0x89abcdef: "
test_OP_sub:
    .string "    sub  0x01234567, 0x89abcdef: "
test_OP_xor:
    .string "    xor  0x01234567, 0x89abcdef: "
test_OP_or:
    .string "    or   0x01234567, 0x89abcdef: "
test_OP_and:
    .string "    and  0x01234567, 0x89abcdef: "
test_OP_sll:
    .string "    sll  0x01234567, 0x89abcdef: "
test_OP_srl:
    .string "    srl  0x01234567, 0x89abcdef: "
test_OP_sra:
    .string "    sra  0x01234567, 0x89abcdef: "
test_OP_slt:
    .string "    slt  0x01234567, 0x89abcdef: "
test_OP_sltu:
    .string "    sltu 0x01234567, 0x89abcdef: "
test_OP_IMM:
    .string "OP_IMM instructions:\n"
test_OP_IMM_addi:
    .string "    addi  0x01234567,  0x123: "
test_OP_IMM_addi_neg:
    .string "    addi  0x01234567, -0x123: "
test_OP_IMM_xori:
    .string "    xori  0x01234567,  0x123: "
test_OP_IMM_ori:
    .string "    ori   0x01234567,  0x123: "
test_OP_IMM_andi:
    .string "    andi  0x01234567,  0x123: "
test_OP_IMM_slli:
    .string "    slli  0x89abcdef,   0x12: "
test_OP_IMM_srli:
    .string "    srli  0x89abcdef,   0x12: "
test_OP_IMM_srai:
    .string "    srai  0x89abcdef,   0x12: "
test_OP_IMM_slti:
    .string "    slti  0x89abcdef,   0x12: "
test_OP_IMM_sltiu:
    .string "    sltiu 0x89abcdef,   0x12: "
test_BRANCH:
    .string "BRANCH instructions:\n"
test_BRANCH_beq_n:
    .string "    beq  0x123, 0x456: "
test_BRANCH_beq_y:
    .string "    beq  0x123, 0x123: "
test_BRANCH_bne_y:
    .string "    bne  0x123, 0x456: "
test_BRANCH_bne_n:
    .string "    bne  0x123, 0x123: "
test_BRANCH_blt_l:
    .string "    blt  0x123, 0x456: "
test_BRANCH_blt_e:
    .string "    blt  0x123, 0x123: "
test_BRANCH_blt_g:
    .string "    blt  0x456, 0x123: "
test_BRANCH_bge_l:
    .string "    bge  0x123, 0x456: "
test_BRANCH_bge_e:
    .string "    bge  0x123, 0x123: "
test_BRANCH_bge_g:
    .string "    bge  0x456, 0x123: "
test_BRANCH_bltu_l:
    .string "    bltu 0x12300000, 0xf4560000: "
test_BRANCH_bltu_e:
    .string "    bltu 0x12300000, 0x12300000: "
test_BRANCH_bltu_g:
    .string "    bltu 0xf4560000, 0x12300000: "
test_BRANCH_bgeu_l:
    .string "    bgeu 0x12300000, 0xf4560000: "
test_BRANCH_bgeu_e:
    .string "    bgeu 0x12300000, 0x12300000: "
test_BRANCH_bgeu_g:
    .string "    bgeu 0xf4560000, 0x12300000: "
test_JAL_JALR_AUIPC:
    .string "JAL, JALR, LUI, AUIPC instructions:\n"
test_JAL:
    .string "    Successfully jumped using JAL!\n"
test_JALR:
    .string "    Successfully jumped using JALR!\n"
test_LUI:
    .string "    lui   0x12345: "
test_AUIPC:
    .string "    auipc 0x12345: "
test_LOAD_STORE:
    .string "LOAD and STORE instructions:\n"
test_LOAD_STORE_init:
    .string "    Initialized RAM to zero\n"
test_LOAD_STORE_checking:
    .string "    Checking: "
test_LOAD_STORE_sw_1:
    .string "    Stored 0x12345678 to RAM @ 0x10000\n"
test_LOAD_STORE_sw_2:
    .string "    Stored 0xabcdefff to RAM @ 0x10004\n"
test_LOAD_STORE_sw_3:
    .string "    Stored 0x76543210 to RAM @ 0x10008\n"
test_LOAD_STORE_lw:
    .string "    lw  RAM @ 10004: "
test_LOAD_STORE_lh_pos:
    .string "    lh  RAM @ 10000: "
test_LOAD_STORE_lh_neg:
    .string "    lh  RAM @ 10004: "
test_LOAD_STORE_lhu_pos:
    .string "    lhu RAM @ 10000: "
test_LOAD_STORE_lhu_neg:
    .string "    lhu RAM @ 10004: "
test_LOAD_STORE_lb_pos:
    .string "    lb  RAM @ 10000: "
test_LOAD_STORE_lb_neg:
    .string "    lb  RAM @ 10004: "
test_LOAD_STORE_lbu_pos:
    .string "    lbu RAM @ 10000: "
test_LOAD_STORE_lbu_neg:
    .string "    lbu RAM @ 10004: "
test_LOAD_STORE_sh_1:
    .string "    sh 0x1234 @ 10000: "
test_LOAD_STORE_sh_2:
    .string "    sh 0x1234 @ 10002: "
test_LOAD_STORE_sb_1:
    .string "    sb 0x12 @ 10000: "
test_LOAD_STORE_sb_2:
    .string "    sb 0x12 @ 10001: "
test_LOAD_STORE_sb_3:
    .string "    sb 0x12 @ 10002: "
test_LOAD_STORE_sb_4:
    .string "    sb 0x12 @ 10003: "

# Various strings
hello:
    .string "Hello, World!\n"
newline:
    .string "\n"
comma_sep:
    .string ", "
separator:
    .string "-------------------------\n"
yes:
    .string "Yes\n"
no:
    .string "No\n"
