; add_big.asm
; adding two-digit numbers in assembly and printing result

; adding 23 and 41

[org 0x7C00]
bits 16

mov bx, 23
mov cx, 41
mov si, 10  ; need to divide by 10 to convert to single digits to print correctly

mov ax, bx
add ax, cx

; clear dx for div
; dont get to decide where results go for division
; ax for quotient, dx for remainder
xor dx, dx
div si  ; ax = 6, dx = 4

; have to move to ax to print (only prints from al) -> ax is full 16 bits
; two teletype interrupts for each digit

add ax, '0'
mov ah, 0x0E
int 0x10

mov ax, dx
add ax, '0'
mov ah, 0x0E
int 0x10

jmp $
times 510 - ($-$$) db 0

dw 0xAA55