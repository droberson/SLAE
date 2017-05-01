all: test wget passwd hosts

wget:
	nasm -o wget-original wget-original.asm
	nasm -o wget-modified wget-modified.asm

passwd:
	nasm -o passwd-original passwd-original.asm
	nasm -o passwd-modified passwd-modified.asm

hosts:
	nasm -o hosts-original hosts-original.asm
	nasm -o hosts-modified hosts-modified.asm

test:
	gcc -g -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf test *~ wget-modified wget-original

