
.include "hex.asm"

plushex: # a0 = a1 + a2
  add a0, a1, a2
  ret
minushex: # a0 = a1 - a2
  sub a0, a1, a2
  ret
orhex:
  or a0, a1, a2
  ret
andhex:
  and a0, a1, a2
  ret

.globl main
main:
  println
  call scanint16
  mv s1, a0
  call scanint16
  mv s2, a0
  
  scanf # читаем че делаем
  mv a3, a0
  println
  mv a1, s1
  mv a2, s2
  
  # делаем
  li tmp, 43
  bne a3, tmp, skipplus
  call plushex
  j endcalchex
skipplus:
  li tmp, 45
  bne a3, tmp, skipminus
  call minushex
skipminus:
  li tmp, 38
  bne a3, tmp, skipand
  call andhex
  j endcalchex
skipand:
  li tmp, 124
  bne a3, tmp, error
  call orhex
  j endcalchex
error:
  exit 0
endcalchex:
  call printint
