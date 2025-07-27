; boot.asm

[org 0x7C00]    ; This tells the assembler that the code will be loaded by BIOS at memory address 0x7C00
                ; BIOS loads from boot sector from disk (first 512 bytes) of memory starting at 0x0000:0x7C00 (physical address 0x7C00)
                ; Write code as if it is at 0x7C00, even though file starts at byte 0
                ; Without this addresses like jumps and labels would be off by 0x7C00

mov ah, 0x0E    ; Tells BIOS to use teletype output -> this means print one character to screen and move cursor
mov al, 'A'     ; Putting ASCII code of 'A' into al (lower half of AX register) -> BIOS now knows what to print
int 0x10        ; BIOS video interrupt (INT 10h) -> performs screen-related task like printing text or changing video modes
                ; Because AH = 0x0E it runs the 'print character'
                ; Because AL = 'A' it tells it what character to print
                ; So this will print the letter 'A' to the screen in text mode

jmp $           ; This means jump to the current address -> i.e. don't go anywhere
                ; $ = current instruction address
                ; Creates an infinite loop -> effectively halts the bootloader
                ; Without it CPU would keep running into random memory

times 510 - ($ - $$) db 0   ; Very important for making bootloader exactly 512 bytes long
                            ; times N db 0 -> write N zero bytes
                            ; $ = current address (where we are in the file)
                            ; $$ = beginning of the file
                            ; ($ - $$) = how many bytes written so far
                            ; This line calculates how many bytes left until we reach 510 bytes
                            ; Fills the rest of the space with 0s
                            ; 510 because last 2 bytes must be magic number (0xAA55) to signal it's bootable sector

dw 0xAA55       ; boot signature
                ; dw = define word (2 bytes)
                ; Without this, the BIOS would not run the bootloader