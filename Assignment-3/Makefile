all: egghunter egghunter-asm shellcode test write

egghunter:
	gcc -m32 -fno-stack-protector -z execstack -o egghunter egghunter.c

shellcode:
	nasm -o shellcode write.asm

egghunter-asm:
	nasm -o egghunter-asm egghunter.asm

test:
	gcc -m32 -fno-stack-protector -z execstack -o test test.c

clean:
	rm -rf egghunter egghunter-asm write shellcode test *~

