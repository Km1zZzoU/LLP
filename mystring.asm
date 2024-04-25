section .text
mystrchr:
	mov   rcx,     0
.startloop:
	mov   rdx,     [rsi+rcx]
	and   rdx,     255

	cmp   rdx,     rdi
	je    .endloop

	cmp   rdx,     0
	jne   .notzero
	mov   rsi,     0
	jmp   .end
.notzero:

	inc   rcx
	jmp   .startloop
.endloop:
	add   rsi,     rcx
.end:
	ret

mystrchrsimple:
	push  rsi
	call  mystrchr
	cmp   rsi,     0
	jne   .OK
	mov   rax,     -1
	add   rsp,     8
	ret
.OK:
	pop   rax
	sub   rsi,     rax
	mov   rax,     rsi
	ret

myputs:
	mov   rcx,     0
.startloop:
	mov   rdx,     [rdi+rcx]
	and   rdx,     255

	cmp   rdx,     0
	jne   .notzero
	jmp   .endloop
.notzero:
	push  rcx
	push  rdi
	mov   rsi,     rdi
	add   rsi,     rcx
	mov   rdi,     1
	mov   rdx,     1
	mov   rax,     1

	syscall

	pop  rdi
	pop  rcx
	inc  rcx
	jmp  .startloop
.endloop:
	ret

s2i:
	push r10
	push rdi
	push 0
	push 255
.loop:
	mov rdi,     rsi
	shr rsi,     8
	and rdi,     [rsp]
	cmp rdi,     0
	je .endloop
	sub rdi,     48
	mov rdx,     [rsp+8]
	mov r10,     rdx
	shl r10,     3
	shl rdx,     1
	add rdx,     r10
	add rdx,     rdi
	mov [rsp+8], rdx
	jmp .loop
.endloop:
	add rsp,     8
	pop rax
	pop rdi
	pop r10
	ret
