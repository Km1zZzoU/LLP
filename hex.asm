
.include "baselib.asm"

scanint16: #в t6 закидывает все, что вводится с клавиатуры до enter
  push ra
  
  li t6, 0 # здесь будем собирать сумму
startfunc:
  #scan and check on enter
  scanf
  li tmp, 10
  beq a0, tmp, endfunc

  addi a0, a0, -48 #в а0 лежит число

  inside tmp, a0, 0, 9    #proverka ot 0 do 9
  bne tmp, zero, skip

  inside tmp, a0, 17, 22   #proverka ot A do F 
  bne tmp, zero, skipBIG # if tmp == zero then skipBIG

  inside tmp, a0, 49, 54           #proverka ot a do f
  bne tmp, zero, skipSMALL
  exit 1
skipSMALL:
  addi a0, a0, -32
skipBIG:
  addi a0, a0, -7
skip:
  slli t6, t6, 4 #сдвигаем разряд влево (* 2^4)
  add t6, t6, a0
  j startfunc
endfunc:
  mv a0, t6
  pop ra
  ret