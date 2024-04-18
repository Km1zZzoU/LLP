global _start

section .rodata

O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR   equ 2
limit    equ 4096

section .bss

buf    resb 256

section .text
%INCLUDE "printdec.asm"

_start:
	mov rdi,         [rsp+16]     ;name
	mov r15,          rdi
	xor rax,          rax
	mov rcx,          -1
	repne scasb                   ;find \0
	mov byte [rdi-1], 0
	sub rdi,          [rsp+16]    ;take len
	mov r14,          rdi

	and rsp,     -16
	mov rax,     2        ;for syscall open
	mov rdi,     r15      ;filename
	mov rsi,     O_RDONLY

	syscall

	mov rdi,     rax      ;mov fd
	mov rsi,     buf      ;for read
	mov rdx,     limit    ;set count
	mov rax,     0        ;for syscall read

	syscall
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

	pop rsi
	call printdec

	mov rax,     60
	mov rdi,     0

	syscall
