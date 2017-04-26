all: egghunter shellcode test

egghunter:
	gcc -m32 -fno-stack-protector -z execstack -o egghunter egghunter.c

shellcode:
	nasm -o shellcode egghunter.asm

test:
	gcc -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf egghunter shellcode test *~

