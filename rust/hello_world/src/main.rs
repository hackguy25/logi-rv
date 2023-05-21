#![no_std]
#![no_main]

use panic_halt as _;

const TTY_ADDRESS: *mut u8 = 0x20000 as *mut u8;

/// Print given `&str` to the TTY.
fn print_to_tty(text: &str) {
    for byte in text.as_bytes() {
        // SAFETY: TTY is a hardware component which displays any byte as an ASCII charater written
        // to its address. No data is written to memory.
        unsafe {
            TTY_ADDRESS.write_volatile(*byte);
        }
    }
}

#[riscv_rt::entry]
fn main() -> ! {
    print_to_tty("Hello, world!\n");
    panic!();
}
