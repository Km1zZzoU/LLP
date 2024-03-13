
.include "baselib.asm"

j endbcd

scanint10: #в t6 закидывает все, что вводится с клавиатуры до enter
  push ra
  
  li t6, 0 # здесь будем собирать сумму
  #scan and check on minus
  scanf
  li tmp, 0
  push tmp
  li tmp, 45
  bne a0, tmp, skipminus
  pop tmp
  li tmp, 0x10000000
  push tmp
startscanint10:
  scanf
skipminus:
  li tmp, 10
  beq a0, tmp, endfuncscanint10

  addi a0, a0, -48 #в а0 лежит число

  inside tmp, a0, 0, 10    #proverka ot 0 do 9
  bne tmp, zero, skipscanint10
  j startscanint10
skipscanint10:
  call addrightint
  j startscanint10
endfuncscanint10:
  pop tmp
  add a0, t6, tmp
  pop ra
  ret

plusbcd: #a0 = a1 + a2 mod 10
  push ra
  push a1
  push a2
  
  li a2, 0
  call take4bit
  beq a0, zero, first1signisplus
first1signisminus:
  pop a1 #записываем s2
  push a1
  li a2, 0
  call take4bit
  beq a0, zero, _1minus2plus
_1minus2minus:
  pop a2
  pop a1
  li a3, 0x10000000
  call finalplusbcd
  j endswitchplusbcd
_1minus2plus:
  pop a1
  pop a2
  slli a2, a2, 4
  srli a2, a2, 4
  li a3 0
  call finalminusbcd
  j endswitchplusbcd
first1signisplus:
  pop a1 #записываем s2
  push a1
  li a2, 0
  call take4bit
  beq a0, zero, _1plus2plus
_1plus2minus:
  pop a2
  pop a1
  li a3, 0
  call finalminusbcd
  j endswitchplusbcd
_1plus2plus:
  pop a2
  pop a1
  li a3, 0
  call finalplusbcd
endswitchplusbcd: 
  pop ra
  ret
  
minusbcd:
  push ra
  push a1
  push a2
  
  li a2, 0
  call take4bit
  beq a0, zero, mfirst1signisplus
mfirst1signisminus:
  pop a1 #записываем s2
  push a1
  li a2, 0
  call take4bit
  beq a0, zero, m_1minus2plus
m_1minus2minus:
  pop a1
  pop a2
  li a3, 0
  call finalminusbcd
  j endswitchminusbcd
m_1minus2plus:
  pop a2
  pop a1
  li a3, 0x1000000
  call finalplusbcd
  j endswitchminusbcd
mfirst1signisplus:
  pop a1 #записываем s2
  push a1
  li a2, 0
  call take4bit
  beq a0, zero, m_1plus2plus
m_1plus2minus:
  pop a2
  pop a1
  li a3, 0
  call finalplusbcd
  j endswitchminusbcd
m_1plus2plus:
  pop a2
  pop a1
  li a3, 0
  call finalminusbcd
endswitchminusbcd: 
  pop ra
  ret
  
finalplusbcd: #a0 = a1 + a2 a3(signed) 
#собираем в а5
  li a5, 0
  push ra
  
  li a6, 0 #bonus
  li a7, 28 #for take4bit
  push a3
  push a1
  push a2
calc10plus4bit:
  beq a7, zero, endfpbcd

  pop tmp
  pop a1
  push a1
  push tmp
  mv a2, a7
  call take4bit
  push a0
  
  pop tmp
  pop a1
  push a1
  push tmp
  mv a2, a7
  call take4bit
  mv a2, a0
  pop a1
  
  add a0, a1, a2
  add a0, a0, a6
  li tmp, 10
  bge a0, tmp, overflowbcd
  li a6, 0
  j endifoverflowbcd
overflowbcd:
  addi a0, a0, -10
  li a6, 1
endifoverflowbcd:
  li tmp, 28
  neg a7, a7
  add tmp, tmp, a7
  sll a0, a0, tmp
  add a5, a5, a0
  neg a7, a7
  addi a7, a7, -4
  j calc10plus4bit
endfpbcd:
  slli a5, a5, 4
  srli a5, a5, 4
  pop a3
  pop a3
  pop a3
  add a5, a5, a3
  mv a0, a5
  pop ra
  ret

finalminusbcd: #a0 = a1 - a2 a3(signed) 
#собираем в а5
  li a5, 0
  push ra
  
  li a6, 0 #bonus
  li a7, 28 #for take4bit
  push a3
  push a1
  push a2
calc10minus4bit:
  beq a7, zero, endfmbcd

  pop tmp
  pop a1
  push a1
  push tmp
  mv a2, a7
  call take4bit
  push a0

  pop tmp
  pop a1
  push a1
  push tmp
  mv a2, a7
  call take4bit
  mv a2, a0
  pop a1
  
  
  sub a0, a1, a2
  sub a0, a0, a6
  addi a0, a0, 16
  inside tmp, a0, 6, 15
  bne zero, tmp, overflowbcdinminus
  li a6, 0
  j endifoverflowbcdinminus
overflowbcdinminus:
  addi a0, a0, 10
  li a6, 1
endifoverflowbcdinminus:
  addi a0, a0, -16
  li tmp, 28
  neg a7, a7
  add tmp, tmp, a7
  sll a0, a0, tmp
  add a5, a5, a0
  neg a7, a7
  addi a7, a7, -4
  j calc10minus4bit
endfmbcd:
  slli a5, a5, 4
  srli a5, a5, 4
  pop a3
  pop a3
  pop a3
  add a5, a5, a3
  mv a0, a5
  beq zero, a6, qwe
  li tmp, 0x1999999a #magic
  sub a0, tmp, a0
qwe:
  pop ra
  ret
  
printbcd:
  push ra
  
  mv a1, a0
  li a2, 0
  call take4bit
  
  beq a0, zero, printplusbcd
  li a0, 45
  printch
printplusbcd:
  li a2, 4
checkonoverbcd:
  li tmp, 32
  beq a2, tmp, endprintintbcd
  
  call take4bit
  addi a2, a2, 4
  
  inside tmp, a0, 0, 10
  addi a0, a0, 48
  bne tmp, zero, printbcd2
  addi a0, a0, 39
printbcd2:
  printch
  j checkonoverbcd
endprintintbcd:
  pop ra
  ret

endbcd:
