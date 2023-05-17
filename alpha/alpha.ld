MEMORY {
    rom (rx) : org = 0,       len = 64k
    ram (wx) : org = 0x10000, len = 64k
    io (w)   : org = 0x20000, len = 4
}

SECTIONS {
    .text : {
        *(.text)
    } > rom
}