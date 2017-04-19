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
