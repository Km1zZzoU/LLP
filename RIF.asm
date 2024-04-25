section .rodata

O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR   equ 2
limit    equ 4096

section .bss

buf    resb 256

section .text
rif:
	mov rdi,          [rsp+24]     ;name
	mov r15,          rdi
	xor rax,          rax
	mov rcx,          -1
	repne scasb                   ;find \0
	mov byte [rdi-1], 0
	sub rdi,          [rsp+24]    ;take len
	mov r14,          rdi

	mov r13,          rsp
	and rsp,          -16
	mov rax,          2        ;for syscall open
	mov rdi,          r15      ;filename
	mov rsi,          O_RDONLY

	syscall

	mov rdi,          rax      ;mov fd
	mov rsi,          buf      ;for read
	mov rdx,          limit    ;set count
	mov rax,          0        ;for syscall read

	syscall

	mov rsp,          r13
	ret
