section .text

%macro print 1
push  rsi
push  rdi
push  rdx
push  rax

mov   rsi,     %1
mov   [rsp-8], rsi
mov   rsi,     rsp
sub   rsi,     8

mov   rdi,     1
mov   rdx,     1
mov   rax,     1

syscall

pop   rax
pop   rdx
pop   rdi
pop   rsi
%endmacro
