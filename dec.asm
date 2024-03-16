j enddec
.include "baselib.asm"

.macro sign %r %x
li tmp, 1
slli tmp, tmp, 31
and %r, %x, tmp
.end_macro

muldec: #a0 = a1 * a2
  push ra
  
  sign a3, a1
  slli a1, a1, 1
  srli a1, a1, 1
  sign a4, a2
  slli a2, a2, 1
  srli a2, a2, 1
  
  add a3, a3, a4
  push a3
  li a0, 0
L1:
  beq a1, zero, L2
  add a0, a0, a2
  addi a1, a1, -1
  j L1

L2:
  slli a0, a0, 1
  srli a0, a0, 1
  pop a3
  add a0, a0, a3
  pop ra
  ret


divdec: #a0 = a1 // a2
  push ra
  sign a3, a1
  slli a1, a1, 1
  srli a1, a1, 1
  sign a4, a2
  slli a2, a2, 1
  srli a2, a2, 1
  add a3, a3, a4
  push a3
  li a3, 0
checkdivdec:
   less tmp, a1, a2
   bne tmp, zero, enddivdec
   sub a1, a1, a2
   addi a3, a3, 1
   j checkdivdec
enddivdec:
  mv a0, a3
  pop a3
  slli a0, a0, 1
  srli a0, a0, 1
  add a0, a0, a3  
  pop ra
  ret

recdiv10:
  push ra
  push a1
  
  li tmp, 100
  bge a1, tmp, rec
  li a2, 10
  call divdec
  pop ra
  pop ra
  ret
rec:
  srli a1, a1, 1
  call recdiv10
  pop a1
  srli a1, a1, 2
  sub a0, a1, a0
  srli a0, a0, 1
  pop ra 
  ret

moddec: #a0 = a1 % a2 
  push ra
  slli a1, a1, 1
  srli a1, a1, 1
  slli a2, a2, 1
  srli a2, a2, 1 
  push a1
  push a2
  call divdec
  mv a1, a0
  pop a2
  push a2
  call muldec
  pop a1
  pop a1
  sub a0, a1, a0 
  pop ra
  ret

scandec:
  push ra
  li a5, 0
  
  scanf
  li tmp, 0
  push tmp
  li tmp, 45
  bne a0, tmp, L4
  pop tmp
  li tmp, 0x80000000
  push tmp
L3:
  scanf
L4:
  li tmp, 10
  beq a0, tmp, endfuncscandec
  
  addi a0, a0, -48
  inside tmp, a0, 0, 10
  beqz tmp, L3
  
  mv a2, a5 #сохраняем то, что считали
  mv a5, a0 #новая цифра в а5 
  li a1, 10
  call muldec
  add a5, a5, a0
  j L3
  
endfuncscandec:
  pop tmp
  slli a5, a5, 1
  srli a5, a5, 1
  add a0, a5, tmp
  
  pop ra 
  ret


printdec:
  push ra
  
  srli tmp, a0, 31
  beqz tmp, skipprintminus
  push a0
  li a0, 45
  printch
  pop a0
skipprintminus:
  slli a0, a0, 1
  srli a0, a0, 1
  li a5, 0x3b9aca00 #10**9
  push a0
  li a6, 10
startprintdec:
  seek a0
  beqz a6, endprintdec
  mv a2, a5
  mv a1, a0
  call divdec
  mv a1, a0

  addi a0, a0, 48
  printch
  
  mv a2, a5
  call muldec
  pop a1 #(a0)
  sub a0, a1, a0
  push a0
  mv a1, a5
  call recdiv10
  mv a5, a0
  addi a6, a6, -1
  j startprintdec
endprintdec:
  pop ra
  pop ra
  ret

enddec: