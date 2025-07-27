; hello-world.asm

[org 0x7C00]
bits 16

; hex for writing new line
%define ENDL 0x0D, 0x0A

; because puts is written above main, write jump instruction to main
start:
    jmp main

; to print string to screen
; params:
;   - ds:si points to string
;   
puts:
    ; save registers we are going to modify -> push them to stack
    push si
    push ax

; after pushing enters main loop
.loop:
    lodsb       ; loads byte from address ds:si into al register then increments si
                ; loads next character into al
    or al, al   ; verify if character is null -> or instruction performs bitwise or
                ; or-ing a value to itself modifies the flag register -> if result is zero, 0 flag will be set

    jz .done    ; conditional jump -> jumps to done label if 0 flag is set
                ; will jump when the next character is null

    mov ah, 0x0E    ; To print character in teletype mode
    mov bh, 0       ; Set ah -> 0x0E, al -> character to print, bh -> page number (text modes), bl -> foreground pixel colour (graphics modes)
    int 0x10

    jmp .loop

.done:
    pop ax  ; pops registers after done with them
    pop si  ; POPS IN REVERSE ORDER TO WHERE THEY WERE CREATED
    ret     ; returns from function

main:
    ; setting up data segments
    mov ax, 0       ; can't write to ds/es directly -> use intermediary register ax
                    ; ds/es are segment registers, ax is a general-purpose register
    mov ds, ax      ; mov destination, source
    mov es, ax      ; copying value from ax to ds/es

    ; setting up stack segments
    mov ss, ax      ; sets stack segment to 0
    mov sp, 0x7C00  ; sets stack pointer to beginning of program
                    ; stack grows downwards from where we are loaded in memory
                    ; stops it from overwriting program

    ; print message
    mov si, msg_hello
    call puts

    hlt
.halt:
    jmp .halt

msg_hello: db 'Hello World!', ENDL, 0  ; declare string using db directive -> allows to write as many characters as you want

times 510 - ($ - $$) db 0

dw 0xAA55