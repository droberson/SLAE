; exit(99) Linux x86
;
; Shellcode WITH NULL BYTES to exit(99). Used solely for testing.
; by Daniel Roberson (daniel @ planethacker . net)
;

BITS 32

mov eax, 1
mov ebx, 99
int 0x80

