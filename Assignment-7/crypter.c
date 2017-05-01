/* crypter.c -- RC4 encrypt a file using specified key, output as escaped hex
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
#include <sys/types.h>
#include <sys/stat.h>

int main (int argc, char *argv[]) {
  int i;
  int fd;
  int rc4i;
  int rc4j;
  unsigned char rc4s[256];
  unsigned char *key;
  unsigned int tmp;
  unsigned char *data;
  struct stat s;

    
  if (argc != 3) {
    fprintf (stderr, "usage: %s <key> <file>\n", argv[0]);
    exit (EXIT_FAILURE);
  }

  if (strlen (argv[1]) > sizeof (rc4s)) {
    fprintf (stderr, "error: key must be under %ld bytes\n", sizeof (rc4s));
    exit (EXIT_FAILURE);
  }

  key = argv[1];

  /* read input file */
  if (stat (argv[2], &s) == -1) {
    perror ("stat");
    exit (EXIT_FAILURE);
  }

  fd = open (argv[2], O_RDONLY);
  if (fd == -1) {
    perror ("open");
    exit (EXIT_FAILURE);
  }

  data = malloc (s.st_size);
  if (read (fd, data, s.st_size) != s.st_size) {
    fprintf (stderr, "unable to read %ld bytes from %s\n", s.st_size, argv[2]);
    exit (EXIT_FAILURE);
  }

  close (fd);

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
    printf ("\\x%.02x", data[i] ^ tmp);
  }

  printf("\n\n");

  free (data);

  return EXIT_SUCCESS;
}
