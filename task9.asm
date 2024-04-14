
.include "baselib.asm"
.include "div.asm"
.include "dec.asm"
.include "mulreg.asm"

.globl main
main:
  println
  call scandec
  mv s1, a0
  call scandec
  mv s2, a0
  println
  mv a1, s1
  mv a2, s2
  
  call sdiv
  call printdec