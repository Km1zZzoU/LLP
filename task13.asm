global _start

section .text:

%INCLUDE "import.asm"

import "RIF.asm"
import "printdec.asm"
import "mystring.asm"
import "printany.asm"

_start:
	call  rif
	push  rsi
	mov   rax,      [rsp+8]
	cmp   rax,      2
	je    .optional
	mov   rax,      [rsp+32]
	mov   rsi,      [rax]
	call  s2i
	pop   rsi
	push  rax
	jmp   .setinf
.optional:
	pop   rsi
	push  -1
.setinf:
	xor   r12,      r12
	mov   r13,      rsp
.loop:
	push  rsi
	mov   rdi,      10
	call  mystrchr
	cmp   rsi,      0
	je    .endloop
	xor   al,       al
	mov   [rsi],    al
	inc   rsi
	inc   r12
	jmp   .loop
.endloop:
	push  0
	cmp   qword [r13], r12
	jae   .loop2
	mov   rsi,      r12
	sub   rsi,      [r13]
	shl   rsi,      3
	sub   r13,      rsi
	shr   rsi,      3
	sub   r12,      rsi
.loop2:
	cmp   r12, 0
	je    .endloop2
	dec   r12

	inc   qword     [rsp]
	mov   rsi,      [rsp]
	call  putsdec

	print 32
	sub   r13,      8
	mov   rsi,      [r13]
	mov   rdi,      0
	call  mystrchrsimple
	mov   rdx,      rax

	mov   rsi,      [r13]
	mov   rax,      [rsi]
	cmp   al,       0     
	je   .empty     
	mov   rdi,      1
	mov   rax,      1

	syscall
.empty:
	print 10

	jmp   .loop2
.endloop2:
	mov   rax,       60
	mov   rdi,       0

	syscall
