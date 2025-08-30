; add.asm
; adding single digit numbers in assembly

; adding 5 and 3 and printing the result

[org 0x7C00]
bits 16

mov bh, 2
mov bl, 4

mov al, bl
add al, bh

add al, '0'     ; adding 0 to register is how you convert from decimal to ASCII

mov ah, 0x0E    ; teletype output - only used to print characters which is why must be converted to ASCII
int 0x10

jmp $

times 510 - ($ - $$) db 0

dw 0xAA55