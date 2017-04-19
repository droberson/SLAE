# Assignment 1: TCP Bindshell

- Bind to port.
- Exec shell on incoming connection
- Port number should be easily configurable


## Step 1

First, I wrote what I want my shellcode to do in C. This helps me understand exactly what I need to write
in assembler in order to be successful. Its source is located in bindshell.c and will be compiled with
by typing 'make'.

## Step 2

I wrote a small program to execute my shellcodes from here on out. I will just need to dump the shellcode
as hex into the "shellcode" variable, recompile the program, and run ./test. To make sure this is working right,
I did a simple call to exit(100):

```
BITS 32

xor eax, eax
inc eax
mov ebx, eax
add ebx, 99
int 0x80
```

	$ nasm -o exit exit.asm
	$ ndisasm -b 32 exit

```
00000000  31C0              xor eax,eax
00000002  40                inc eax
00000003  89C3              mov ebx,eax
00000005  83C363            add ebx,byte +0x63
00000008  CD80              int 0x80
```

Plugged this into test.c, ran ./test, and checked the return value:

```
#include <stdio.h>

//00000000  31C0              xor eax,eax
//00000002  40                inc eax
//00000003  89C3              mov ebx,eax
//00000005  83C363            add ebx,byte +0x63
//00000008  CD80              int 0x80

char shellcode[] = \
"\x31\xc0"
"\x40"
"\x89\xc3"
"\x83\xc3\x63"
"\xcd\x80"
;

int main () {
  printf("Length: %d\n", sizeof(shellcode) - 1);
  int (*run)() = (int(*)())shellcode;
  run();
}
```

	$ gcc -m32 -fno-stack-protector -z execstack -o test test.c
	$ ./test
	Length: 10
	$ echo $?
	100

