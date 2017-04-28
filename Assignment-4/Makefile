all: test shellcode encoder

shellcode:
	nasm -o shellcode decoder.asm

test:
	gcc -m32 -fno-stack-protector -z execstack -o test test.c

encoder:
	gcc -m32 -fno-stack-protector -z execstack -o encoder encoder.c
clean:
	rm -rf shellcode test encoder *~

