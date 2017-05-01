all: test wget

wget:
	nasm -o wget-original wget-original.asm
	nasm -o wget-modified wget-modified.asm

test:
	gcc -g -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf test *~ wget-modified wget-original

