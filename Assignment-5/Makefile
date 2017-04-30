all: test

test:
	gcc -g -m32 -fno-stack-protector -z execstack -o test test.c

clean: rm -rf test *~


