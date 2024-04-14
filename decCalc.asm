
.include "baselib.asm"
.include "mulreg.asm"
.include "dec.asm"

plusdec:
  push ra
  sign a3, a1
  unsign a1
  sign a4, a2
  unsign a2
  beqz a3, P3
P1: # if first minus
  beqz a4, P2
  # if second minus
  add a0, a1, a2
  unsign a0
  li tmp 0x80000000
  add a0, a0, tmp
  j endplusdec
P2: #if second plus
  bge a2, a1, P2.1
  sub a0, a1, a2
  unsign a0
  li tmp, 0x80000000
  add a0, a0, tmp
  j endplusdec
P2.1: 
  sub a0, a2, a1
  unsign a0
  j endplusdec
P3: # if first plus
  beqz a4, P4
  # if second minus
  bge a1, a2, P3.1
  sub a0, a2, a1
  unsign a0
  li tmp, 0x80000000
  add a0, a0, tmp
  j endplusdec
P3.1: 
  sub a0, a1, a2
  unsign a0
  j endplusdec
P4: #if second plus
  add a0, a1, a2
  unsign a0
  j endplusdec
endplusdec:
  pop ra 
  ret

minusdec:
  push ra
  sign a3, a1
  unsign a1
  sign a4, a2
  unsign a2
  beqz a3, M3
M1: # if first minus
  beqz a4, M2
  # if second minus
  bge a2, a1, M1.1
  sub a0, a1, a2
  unsign a0
  li tmp, 0x80000000
  add a0, a0, tmp
  j endminusdec
M1.1: 
  sub a0, a2, a1
  unsign a0
  j endminusdec
M2: #if second plus
  add a0, a1, a2
  unsign a0
  li tmp, 0x80000000
  add a0, a0, tmp
  j endminusdec
M3: # if first plus
  beqz a4, M4
  # if second minus
  add a0, a1, a2
  unsign a0
  j endminusdec
M4: #if second plus
  bge a1, a2, M3.1
  sub a0, a2, a1
  unsign a0
  li tmp, 0x80000000
  add a0, a0, tmp
  j endminusdec
M3.1: 
  sub a0, a1, a2
  unsign a0
  j endminusdec
endminusdec:
  pop ra 
  ret

.globl main
main:
  println
  call scandec
  mv s1, a0
  call scandec
  mv s2, a0
  mv a1, s1
  mv a2, s2
  
  scanf # читаем че делаем
  mv a3, a0
  println
  mv a1, s1
  mv a2, s2
  
  li tmp, 43
  bne a3, tmp, D1
  call plusdec
  j D5
D1:
  li tmp, 45
  bne a3, tmp, D2
  call minusdec
  j D5
D2:
  li tmp, 42
  bne a3, tmp, D3
  call muldec
  j D5
D3:
  li tmp, 47
  bne a3, tmp, D4
  call divdec
  j D5
D4:
  li tmp, 37
  bne a3, tmp, endcalcdec
  call moddec
D5:
  call printdec
endcalcdec:
  exit 0
