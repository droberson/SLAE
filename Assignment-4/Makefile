all: test shellcode

shellcode:
	nasm -o shellcode decoder.asm

test:
	gcc -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf shellcode test *~

