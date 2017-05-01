all: test wget passwd

wget:
	nasm -o wget-original wget-original.asm
	nasm -o wget-modified wget-modified.asm

passwd:
	nasm -o passwd-original passwd-original.asm
	nasm -o passwd-modified passwd-modified.asm

test:
	gcc -g -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf test *~ wget-modified wget-original

