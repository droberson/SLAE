/* decrypter.c -- RC4 decrypt a string using specified key, execute it.
 *           -- by Daniel Roberson @dmfroberson daniel@planethacker.net
 * SLAE-877
 *
 * For more information about RC4: https://en.wikipedia.org/wiki/RC4
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>


/*
 * crypted payload for write(1,"hi there\n",9)
 * passphrase = harharhar
 *
 * generated with ./crypter harharhar write
 */
unsigned char data[] = \
  "\x2a\xfd\x35\x3c\x72\x44\x72\x37\x15\x0d\x6e\xbf\x02\x46\x01\xf4\x25\xc6"
  "\xf6\x63\xab\xf1\x89\x5d\x2c\x8a\xa8\x3c\x69\xfc\x29\x25\x3d\x85\xa6\x21"
  "\x95\x39\x67\xfa\x49";


int main (int argc, char *argv[]) {
  int i;
  int fd;
  int rc4i;
  int rc4j;
  unsigned char rc4s[256];
  unsigned char *key;
  unsigned int tmp;

    
  if (argc != 2) {
    fprintf (stderr, "usage: %s <key>\n", argv[0]);
    exit (EXIT_FAILURE);
  }

  if (strlen (argv[1]) > sizeof (rc4s)) {
    fprintf (stderr, "error: key must be under %d bytes\n", sizeof (rc4s));
    exit (EXIT_FAILURE);
  }

  key = argv[1];

  /* Key-scheduling algorithm */
  for (i = 0; i < sizeof (rc4s); i++) {
    rc4s[i] = i;
  }

  for (rc4i = 0, rc4j = 0; rc4i < sizeof (rc4s); rc4i++) {
    rc4j = (rc4j + rc4s[rc4i] + key[rc4i % strlen (key)]) % sizeof (rc4s);

    /* swap s[i] and s[j] */
    tmp = rc4s[rc4j];
    rc4s[rc4j] = rc4s[rc4i];
    rc4s[rc4i] = tmp;
  }

  /* encrypt the string with supplied key and output as escaped hex */
  for (rc4i = 0, rc4j = 0, i = 0; i < strlen(data); i++) {
    rc4i = (rc4i + 1) % sizeof (rc4s);
    rc4j = (rc4j + rc4s[rc4i]) % sizeof (rc4s);

    /* swap s[i] and s[j] */
    tmp = rc4s[rc4j];
    rc4s[rc4j] = rc4s[rc4i];
    rc4s[rc4i] = tmp;

    tmp = rc4s[(rc4s[rc4i] + rc4s[rc4j]) % sizeof (rc4s)];
    data[i] = data[i] ^ tmp;
  }

  /* attempt to execute decrypted payload */
  int (*run) () = (int(*)())data;
  run();

  return EXIT_SUCCESS;
}
