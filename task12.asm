global _start

section .text
%INCLUDE "mystring.asm"
%INCLUDE "RIF.asm"
%INCLUDE "printdec.asm"

_start:
	call  rif
	push  -1
.loop:
	mov   rdx,     [rsp]
	inc   rdx
	mov   [rsp],   rdx
	mov   rdi,     10
	call  mystrchr
	cmp   rsi,     0
	je    .endloop
	inc   rsi
	jmp   .loop
.endloop:
	mov   rsi,     [rsp]
	call  printdec
	mov   rdi,     0
	mov   rax,     60
	syscall
