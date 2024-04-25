global _start

section .text
%INCLUDE "printdec.asm"
%INCLUDE "mystring.asm"
%INCLUDE "RIF.asm"

_start:
	call rif
	push rax

	mov rsi,     r15      ;namefile
	mov rdi,     1        ;stdout
	mov rdx,     r14      ;count message
	mov rax,     1

	syscall

	mov rdx,     2
	mov rsi,     32
	mov [rsp+8], rsi
	mov rsi,     rsp
	add rsi,     8
	mov rax,     1

	syscall

	pop          rsi
	call         printdec

	mov rax,     60
	mov rdi,     0

	syscall
