
.include "bcd.asm"

main:
  println
  call scanint10
  mv s1, a0
  call scanint10
  mv s2, a0
  
  scanf # читаем че делаем
  mv a3, a0
  println
  mv a1, s1
  mv a2, s2
  
  # делаем
  li tmp, 43
  bne a3, tmp, L1
  call plusbcd
L1:
  li tmp, 45
  bne a3, tmp, endcalcbcd
  call minusbcd
endcalcbcd:
  call printbcd
  exit 0
