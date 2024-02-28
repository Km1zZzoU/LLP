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

.macro inside %x %y # а0 больше или равно х и меньше у
  slti t0, a0, %y
  slti t1, a0, %x
  not t1, t1
  andi t1, t1, 1
  and ra, t0, t1
.end_macro
  
main:
  li gp, 1
scan1:
  scanf
  li s0, 10
  beq a0, s0, scan2
  addi a0, a0, -48 #в а0 лежит число
  addi s10, s10, 48
  inside 0, 10 #proverka ot 0 do 9
  beq ra, gp, addfirst
  li ra 0
  inside 17, 23 #proverka ot A do F 
  addi a0, a0, -7 # B -> 11
  addi s10, s10, 7
  beq ra, gp, addfirst
  li ra 0
  inside 42, 48
  addi a0, a0, -32
  addi s10, s10, 7
  beq ra, gp, addfirst
scan2:
  li s10, 0
  scanf
  li s0, 10
  beq a0, s0, scanop
  addi a0, a0, -48 #в а0 лежит число
  addi s10, s10, 48
  inside 0, 10 #proverka ot 0 do 9
  beq ra, gp, addsecond
  li ra 0
  inside 17, 23 #proverka ot A do F 
  addi a0, a0, -7 # B -> 11
  addi s10, s10, 7
  beq ra, gp, addsecond
  li ra 0
  inside 42, 48
  addi a0, a0, -32
  addi s10, s10, 7
  beq ra, gp, addsecond
scanop:
  scanf
  mv t6, a0
  println
  li t2, 0xf0000000
  li t3, 28
  li s0, 43
  beq a0, s0, plus
  li s0, 45
  beq a0, s0, minus
  li s0, 38
  beq a0, s0, andd
  li s0, 124
  beq a0, s0, orr
minus:
  li s0, -4
  beq t3, s0, end
  sub s3, s1, s2
  and s4, s3, t2
  srli t2, t2, 4
  srl s4, s4, t3
  addi t3, t3, -4
  li ra 0
  mv a0, s4
  inside 0, 10
  beq ra, gp, printnummin
  j printletmin
plus:
  li s0, -4
  beq t3, s0, end
  add s3, s2, s1
  and s4, s3, t2
  srli t2, t2, 4
  srl s4, s4, t3
  addi t3, t3, -4
  li ra 0
  mv a0, s4
  inside 0, 10
  beq ra, gp, printnumplu
  j printletplu
andd:
  li s0, -4
  beq t3, s0, end
  and s3, s2, s1
  and s4, s3, t2
  srli t2, t2, 4
  srl s4, s4, t3
  addi t3, t3, -4
  li ra 0
  mv a0, s4
  inside 0, 10
  beq ra, gp, printnumand
  j printletand
orr:
  li s0, -4
  beq t3, s0, end
  or s3, s2, s1
  and s4, s3, t2
  srli t2, t2, 4
  srl s4, s4, t3
  addi t3, t3, -4
  li ra 0
  mv a0, s4
  inside 0, 10
  beq ra, gp, printnumor
  j printletor
printnumand:
  addi a0, s4, 48
  printch
  j andd
printnumor:
  addi a0, s4, 48
  printch
  j orr
printletand:
  addi a0, s4, 87
  printch
  j andd
printletor:
  addi a0, s4, 87
  printch
  j orr

printnumplu:
  addi a0, s4, 48
  printch
  j plus
printnummin:
  addi a0, s4, 48
  printch
  j minus
printletplu:
  addi a0, s4, 87
  printch
  j plus
printletmin:
  addi a0, s4, 87
  printch
  j minus
addfirst: #увеличиваем наше число на то что считали, и выписываем в консоль символ который считался
  slli s1, s1, 4 #сдвигаем разряд влево (* 2^4)
  add s1, s1, a0
  mv s0, a0
  add a0, a0, s10
  mv a0, s0
  j scan1
addsecond:
  slli s2, s2, 4 #сдвигаем разряд влево (* 2^4)
  add s2, s2, a0
  mv s0, a0
  add a0, a0, s10
  mv a0, s0
  j scan2
end:
  exit 0
