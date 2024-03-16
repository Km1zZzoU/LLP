
.include "hex.asm"
.include "mulreg.asm"

.globl main
main:
  println
  call scanint16
  mv s1, a0
  call scanint16
  mv s2, a0
  println
  mv a1, s1
  mv a2, s2
  call mulreg
  call printint
