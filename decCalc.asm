
.include "dec.asm"

.globl main
main:
  println
  call scandec
  mv s1, a0
  call scandec
  mv s2, a0
  mv a1, s1
  mv a2, s2
  call muldec
  call printdec
  println
  mv a1, s1
  mv a2, s2
  call divdec
  call printdec
  println
  mv a1, s1
  mv a2, s2
  call moddec
  call printdec
  println