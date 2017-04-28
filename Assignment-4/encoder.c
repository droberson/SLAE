/* ror 4 encoded shellcode generator
 * by Daniel Roberson @dmfroberson daniel@planethacker.net
 * SLAE 877
 */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>


/* ror 4 decoder stubs */
unsigned char decoder1[] = "\xeb\x15\x5e\x56\x31\xc9\x8a\x06\xc0\xc8"
                           "\x04\x88\x06\x46\x41\x83\xf9";

unsigned char decoder2[] = "\x75\xf2\xff\x14\x24\xe8\xe6\xff\xff\xff";


int main (int argc, char *argv[]) {
  int i;
  int fd;
  int len;
  unsigned char *shellcode, *buf;
  struct stat s;


  if (!argv[1]) {
    fprintf (stderr, "usage: %s <file>\n", argv[0]);
    exit (EXIT_FAILURE);
  }

  printf ("ROR 4 encoding shellcode contained in %s\n\n", argv[1]);

  if (stat (argv[1], &s) == -1) {
    perror ("stat");
    exit (EXIT_FAILURE);
  }

  /* This currently does not work on shellcodes larger than 255 bytes :( */
  if (s.st_size > 255) {
    fprintf (stderr, "Shellcode larger than 255 bytes (%ld).\n",
	     s.st_size);
    exit (EXIT_FAILURE);
  }

  fd = open (argv[1], O_RDONLY);
  if (fd == -1) {
    perror ("open");
    exit (EXIT_FAILURE);
  }

  /* buffer will be decoder stubs, size byte, and encoded shellcode */
  len = s.st_size + strlen (decoder1) + strlen (decoder2) + 1;
  shellcode = malloc (len);
  buf = malloc (s.st_size);

  if (read (fd, buf, s.st_size) != s.st_size) {
    fprintf (stderr, "Unable to read %ld bytes from %s\n", s.st_size, argv[1]);
    exit (EXIT_FAILURE);
  }

  close (fd);

  /* Check for NULL bytes in the shellcode */
  for (i = 0; i < s.st_size; i++) {
    if (buf[i] == 0x00) {
      fprintf (stderr, "SHELLCODE CONTAINS NULL BYTES!\n");
      break;
    }
  }

  /* Rotate each character in buf 4 bits */
  for (i = 0; i < s.st_size; i++) {
    buf[i] = buf[i] >> 4 | buf[i] << 4;
  }

  /* Assemble finished product */
  sprintf (shellcode, "%s%c%s%s",
	   decoder1,
	   (unsigned char)s.st_size,
	   decoder2,
	   buf);

  /* Display shellcode in C format */
  printf ("char shellcode[] = \"");

  for (i = 0; i < len; i++) {
    if ((i % 10 == 0) && (i != 0)) {
      printf ("\"\n");
      printf ("                   \"");
    }
    printf ("\\x%.2x", shellcode[i]);
  }

  printf ("\";\n\n");

  printf ("Length: %d\n\n", len);

  /* Execute shellcode */
  int (*run) () = (int(*)())shellcode;
  run ();

  free (shellcode);
  free (buf);

  return EXIT_SUCCESS;
}
