.text
.macro syscall %n
    li a7, %n
    ecall
.end_macro

.macro scanf
    syscall 12
.end_macro

.macro printch
    syscall 11
.end_macro

.macro println
	mv a1, a0
    li a0, 10
    syscall 11 #печатает перенос строки
    mv a0, a1
.end_macro

.macro exit %ecode
    li, a0, %ecode
    syscall 93
.end_macro

main:
	scanf
	li s0, 10
	beq a0, s0, end
	println
	andi a0, a0, 0xff #обрубаем до чара
	printch
	addi a0, a0, 1
	printch
	println
	j main
end:
	exit 0
