BITS 32

cdq
mov edx, 0x424a424a
loop:
	inc eax
	cmp DWORD [eax], edx
	jne loop
	jmp eax

