all: crypter decrypter write

write:
	nasm -o write write.asm

crypter:
	gcc -o crypter crypter.c

decrypter:
	gcc -m32 -fno-stack-protector -z execstack -o decrypter decrypter.c

clean:
	rm -rf crypter decrypter write *~
