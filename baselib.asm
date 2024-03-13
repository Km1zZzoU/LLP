
j endlib
#далее будут описаны самые
#   базовые конструкции
#---------------------------------------
#регистры
# t0 - самый временный регистр (tmp)
#
# t1 - t6 тоже временные, на них ничего не хранить
#
# a0 - a6 используем для передачи  и возврата чего - то в функцию и из нее
# a7 - регистр под syscall
#
# s0 - s11 основные переменные

.text

.eqv tmp, t0

.macro syscall %n
mv tmp, a7
li a7, %n
ecall
mv a7, tmp
.end_macro

.macro scanf
syscall 12
.end_macro

.macro printch
syscall 11
.end_macro

.macro println
push a0
li a0, 10
syscall 11 #печатает перенос строки
pop a0
.end_macro

.macro exit %ecode
li, a0, %ecode
syscall 93
.end_macro

.macro no %x
not %x, %x
andi %x, %x, 1
.end_macro

.macro eq %x %y %z # x = (y == z)
sub t1, %y, %z
beq t1, zero, eq
noeq:
li %x, 0
j endmacro
eq:
li %x, 1
endmacro:
.end_macro

.macro noeq %x %y %z # x = (y != z) 
eq %x, %y, %z
no %x
.end_macro

.macro eqi %x %y %zi # x = (y == zi)
li tmp, %zi
sub t5, %y, tmp
beq t5, zero, eqi
noeqi:
li %x, 0
j endmacro
eqi:
li %x, 1
endmacro:
.end_macro

.macro noeqi %x %y %zi # x = (y != zi) 
eqi %x, %y, %zi
no %x
.end_macro

.macro more %x %y %z # x = y > z
slt t1, %y, %z  # t1 = y < z
no t1           # t1 = y >= z
noeq t2, %y, %z # t2 = (y != z)
and %x, t1, t2
.end_macro

.macro morei %x %y %zi # x = y > zi
slti t1, %y, %zi  # t1 = y < z
no t1             # t1 = y >= z
noeqi t2, %y, %zi  # t2 = (y != z)
and %x, t1, t2
.end_macro

.macro less %x %y %z # x = y < z
slt %x, %y, %z
.end_macro

.macro lessi %x %y %z # x = y < z
slti %x, %y, %z
.end_macro

.macro moreeq %x %y %z # x = y >= z
less %x, %y, %z
no %x
.end_macro

.macro moreeqi %x %y %zi # x = y >= z
lessi %x, %y, %zi
no %x
.end_macro

.macro lesseq %x %y %z # x = y <= z
more %x, %y, %z,
no %x
.end_macro

.macro lesseqi %x %y %zi # x = y <= z
morei %x %y %zi
no %x
.end_macro

.macro inside %r %x %yi %zi
moreeqi t3, %x, %yi
lesseqi t4, %x, %zi
and %r, t3, t4
.end_macro

.macro pop %r
lw %r, 0(sp)
addi sp, sp, 4
.end_macro

.macro push %r
addi sp, sp, -4
sw %r, 0(sp)
.end_macro

addrightint:
  slli t6, t6, 4 #сдвигаем разряд влево (* 2^4)
  add t6, t6, a0
  ret

take4bit: #a0 = a1[a2:a2+4]
  push ra
  
  li t1, 0xf0000000
  srl t1, t1, a2
  and a0, a1, t1 
  
  li tmp, 28
  sub tmp, tmp, a2
  
  srl a0, a0, tmp
  
  pop ra
  ret

printint: #println(a0)
  push ra
  
  mv a1, a0
  li a2, 0
checkonover:
  li tmp, 32
  beq a2, tmp, endprintint
  
  call take4bit
  addi a2, a2, 4
  
  inside tmp, a0, 0, 10
  addi a0, a0, 48
  bne tmp, zero, print
  addi a0, a0, 39
print:
  printch
  j checkonover
endprintint:
  pop ra
  ret
  
endlib:
