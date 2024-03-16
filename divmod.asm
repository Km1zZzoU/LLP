
.include "divmod10lib.asm"
.globl main

main:
  println
  call scanint10
  mv s1, a0
  
  scanf
  mv s2, a0
  li tmp, 0x0000002F
  bne s2, tmp, L1
  mv a0, s1
  call div10bcd
  j enddivmod10
L1:
  li tmp, 0x00000025
  bne s2, tmp, enddivmod10
  mv a0, s1
  call mod10bcd
enddivmod10:
  call printint
