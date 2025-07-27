## Learning Assembly
### Setup - Linux
- Using nasm (the assembler), qemu (visualiser), make (makefiles)
- ```sudo apt install make nasm qemu-system-i386```
- Look at each folder + program for learning info

### Compiling and Running
- ```nasm -f bin first.asm -o first.bin```
    - ```bin``` -> flat binary file
- ```qemu-system-i386 -fda first.bin```