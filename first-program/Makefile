all: first.bin

first.bin: first.asm
	nasm -f bin first.asm -o first.bin

run: first.bin
	qemu-system-i386 -fda first.bin

clean:
	rm -f first.bin