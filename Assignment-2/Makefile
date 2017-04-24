all: revshell shellcode test

revshell:
	gcc -o revshell revshell.c

shellcode:
	nasm -o shellcode revshell.asm

test:
	gcc -m32 -fno-stack-protector -z execstack  -o test test.c

clean:
	rm -rf *~ revshell test

