j endmul
mulreg:
  push ra
  li a0, 0
L1:
  beqz a1, endmulreg
  add a0, a0, a2
  addi a1, a1, -1
  j L1
endmulreg:
  pop ra
  ret
endmul: