; exit(100) Linux x86
;
; Simple shellcode that calls exit(100) 
; by Daniel Roberson (daniel @ planethacker . net)
;

BITS 32

xor eax, eax
inc eax
mov ebx, eax
add ebx, 99
int 0x80

