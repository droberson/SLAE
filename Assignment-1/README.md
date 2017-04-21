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



## Step 3

I got sick of manually entering in shellcode to test.c, so I refactored it to be able to
simply load and output shellcodes as I wrote them. See test.c for clarification.

## Step 4

I need to determine which system call numbers correlate with socket, bind, listen, dup2,
accept, and execve. I referenced this on the site http://syscalls.kernelgrok.com/

- socket = MULTIPLEXED THROUGH socketcall() -- 1
- bind =  MULTIPLEXED THROUGH socketcall() -- 2
- listen = MULTIPLEXED THROUGH socketcall() -- 4
- accept = MULTIPLEXED THROUGH socketcall() -- 5
- socketcall = 102
- dup2 = 63
- execve = 11


socketcall() combines many networking functions into a single system call. Its syntax is as follows:

       int socketcall(int call, unsigned long *args);

The calls are defined in /usr/include/linux/net.h:

```
$ grep SYS_ /usr/include/linux/net.h
#define SYS_SOCKET      1               /* sys_socket(2)                */
#define SYS_BIND        2               /* sys_bind(2)                  */
#define SYS_CONNECT     3               /* sys_connect(2)               */
#define SYS_LISTEN      4               /* sys_listen(2)                */
#define SYS_ACCEPT      5               /* sys_accept(2)                */
#define SYS_GETSOCKNAME 6               /* sys_getsockname(2)           */
#define SYS_GETPEERNAME 7               /* sys_getpeername(2)           */
#define SYS_SOCKETPAIR  8               /* sys_socketpair(2)            */
#define SYS_SEND        9               /* sys_send(2)                  */
#define SYS_RECV        10              /* sys_recv(2)                  */
#define SYS_SENDTO      11              /* sys_sendto(2)                */
#define SYS_RECVFROM    12              /* sys_recvfrom(2)              */
#define SYS_SHUTDOWN    13              /* sys_shutdown(2)              */
#define SYS_SETSOCKOPT  14              /* sys_setsockopt(2)            */
#define SYS_GETSOCKOPT  15              /* sys_getsockopt(2)            */
#define SYS_SENDMSG     16              /* sys_sendmsg(2)               */
#define SYS_RECVMSG     17              /* sys_recvmsg(2)               */
#define SYS_ACCEPT4     18              /* sys_accept4(2)               */
#define SYS_RECVMMSG    19              /* sys_recvmmsg(2)              */
#define SYS_SENDMMSG    20              /* sys_sendmmsg(2)              */
```
 
## Step 5

So I now have all of the information I need to write this shellcode:

- The C equivalent of what I want the shellcode to do
- The calling convention for system calls on x86 Linux
- The syscall numbers for the relevant system calls
- An idea of how socketcall() works

I translate the C into assembler, not caring about NULL bytes for now:

```
CODE HERE
```

## Step 6

Remove NULL bytes.

## Step 7

Optimization/shortening of shellcode.

## Final product



