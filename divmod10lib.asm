
.include "bcd.asm"

div10bcd:
  srli a0, a0, 4
ret

mod10bcd:
  slli a0, a0, 28
  srli a0, a0, 28
ret