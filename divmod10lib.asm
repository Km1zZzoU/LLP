
.include "bcd.asm"

j endlibdivmod10

div10bcd:
  srli a0, a0, 4
  j enddivmod10

mod10bcd:
  slli a0, a0, 28
  srli a0, a0, 28
  j enddivmod10

endlibdivmod10: