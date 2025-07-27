all: hello-world.bin

hello-world.bin: hello-world.asm
	nasm -f bin hello-world.asm -o hello-world.bin

run: hello-world.bin
	qemu-system-i386 -fda hello-world.bin

clean:
	rm -rf hello-world.bin