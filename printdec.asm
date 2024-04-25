section .text
printdec:
	push r13
	call putsdec

	mov r13,     10
	mov [rsp-8], r13
	mov rsi,     rsp
	sub rsi,     8

	mov rdi,     1
	mov rdx,     1
	mov rax,     1
	syscall
	pop r13
	ret

putsdec:
	push r13
	push 1
	xor r13,     r13
	mov rax,     rsi
	cmp rax,     r13
	jge .loop
	xor rax,     rax
	sub rax,     rsi
	mov [rsp],   r13
.loop:
	mov rdx,     0

	mov rbx,     10
	div rbx

	shl r13,     8
	add r13,     rdx
	add r13,     48
	cmp rax,     0
	je  .endloop
	jmp .loop
.endloop:
	pop rdi
	cmp rdi, 1
	je .skipmin
	shl r13,     8
	add r13, 45
.skipmin:
	mov [rsp-8], r13
	mov rsi,     rsp
	sub rsi,     8

	mov rdi,     1
	mov rdx,     8
	mov rax,     1
	syscall
	pop r13
	ret

