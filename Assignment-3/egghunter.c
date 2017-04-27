/* egghunter.c -- by Daniel Roberson SLAE 877
 *
 */

#include <stdio.h>
#include <string.h>

char egghunter[] = "\xbb\x42\x4a\x42\x4a\x40\x39\x18\x75"
                   "\xfb\xff\xe0";


/* write "hi there\n" to stdout */
char shellcode[] = "\x42\x4a\x42\x4a"
                   /* egg ^^^^^ */ "\x31\xc0\x31\xdb\x31\xc9"
                   "\x31\xd2\x83\xc0\x04\x43\x6a\x0a\x68\x68"
                   "\x65\x72\x65\x68\x68\x69\x20\x74\x89\xe1"
                   "\x83\xc2\x09\xcd\x80\x31\xc0\x40\x4b\xcd"
                   "\x80";


void main() {
  printf ("Egg hunter length: %d\n", strlen (egghunter));
  printf ("Shellcode length: %d\n", strlen (shellcode));

  int (*run) () = (int(*)())egghunter;
  run();
}
