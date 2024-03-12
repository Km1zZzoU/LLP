
.include "baselib.asm"
  
main:
  println
  call scanint16
  mv s1, t6
  call scanint16
  mv s2, t6
  
  scanf # читаем че делаем
  mv a3, a0
  println
  mv a1, s1
  mv a2, s2
  
  # делаем
  li tmp, 43
  beq a3, tmp, plushex
  li tmp, 45
  beq a3, tmp, minushex
  li tmp, 38
  beq a3, tmp, andhex
  li tmp, 124
  beq a3, tmp, orhex
endcalchex:
  call printint
