all: bindshell test shellcode

shellcode:
	nasm -o shellcode bindshell.asm

bindshell:
	gcc -g -m32 -o bindshell bindshell.c

test:
	gcc -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf shellcode bindshell test *~

