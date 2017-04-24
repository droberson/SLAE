all: revshell test

revshell:
	gcc -o revshell revshell.c

test:
	gcc -m32 -fno-stack-protector -z execstack  -o test test.c

clean:
	rm -rf *~ revshell test

