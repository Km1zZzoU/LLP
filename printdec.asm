section .text
printdec:
	mov r13,     10
	mov rax,     rsi
.loop:
	cmp rax,     0
	je  .endloop
	mov rdx,     0

	mov rbx,     10
	div rbx

	shl r13,     8
	add r13,     rdx
	add r13,     48
	jmp .loop
.endloop:
	mov [rsp-8], r13
	mov rsi,     rsp
	sub rsi,     8

	mov rdi,     1
	mov rdx,     8
	mov rax,     1
	syscall
	ret

