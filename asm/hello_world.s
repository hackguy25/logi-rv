# A simple program that prints out "Hello, World!" to the TTY.

.globl _boot
.section .text

.equ RAM, 0x10000
.equ TTY, 0x20000
.local hello

_boot:
    li a0, 0x2c
    jal puts
    j end

# a0: address of string to print to tty
# t0: char at a0
# t1: TTY address
puts:
    li t1, TTY
puts_loop:
    lbu t0, 0(a0)
    beq t0, zero, puts_ret
    sb t0, 0(t1)
    addi a0, a0, 1
    j puts_loop
puts_ret:
    ret

end:
    .word 0x00000000

hello:
    .string "Hello, World!\n"
