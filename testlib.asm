section .text

check:
	mov   r8,      [rsp+8]
	inc   r8
	mov   [rsp+8], r8
	mov   r8,      [rsp]
	dec   r8
	mov   [rsp],   r8
	add   rsp,     -8
	push  rdx
	push  r10
	push  rsi
	push  rax
	call  myputs
	pop   rsi
	call  putsdec
	pop   rdi
	call  myputs
	pop   rsi
	call  putsdec
	pop   rdi
	call  myputs
	add   rsp, 8
	jmp   [rsp-8]

%macro FUNC 2

	push 0
	push 0

section .data
testfunc equ %1simple
msg%1 db "Testing function ", %2, "...", 10, 0
section .text
	mov   rdi,     msg%1
	call  myputs
%endmacro

%macro OK 4

section .data
str%4 db %2, 0
ch%4  db %3, 0
failmsg1%4 db "Test falied: strchr(", %2, ", ",  %3, ") results in OK(", 0
failmsg2%4 db "), expected OK(", 0
failmsg3%4 db ")", 10, 0
section .text
	mov   rsi,     str%4
	mov   rdi,     [ch%4]
	and   rdi,     255
	call  testfunc
	mov   rdx,     [rsp]
	inc   rdx
	mov   [rsp],   rdx
	cmp   rax,     %1
	je    .endmacro%4
	mov   rdi,     failmsg1%4
	mov   rsi,     failmsg2%4
	mov   rdx,     failmsg3%4
	mov   r10,     %1
	mov   r8,      .endmacro%4
	mov   [rsp-8], r8
	jmp   check
.endmacro%4:
%endmacro

%macro NONE 3

section .text
OK -1, %1, %2, %3

%endmacro

%macro DONE 0
section .data
msgdone1 db "Passed: ", 0
msgdone2 db ", failed: ", 0
msgdone3 db ".", 10, 0
section .text
	mov   rdi,    msgdone1
	call  myputs
	pop   rsi
	call  putsdec
	mov   rdi,    msgdone2
	call  myputs
	pop   rsi
	call  putsdec
	mov   rdi,    msgdone3
	call  myputs
%endmacro
