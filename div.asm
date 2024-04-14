
udiv: #a0 = a1 / a2 unsigned
	push ra
	
	li a0, 0
	
udiv0:
	blt a1, a2, endudiv
	li tmp, 0 #то сколько раз можно вычесть a2 (степень двойки)
udiv1:
	sll a3, a2, tmp
	blt a1, a3, udiv2
	incp tmp
	j udiv1
udiv2:
	srli a3, a3, 1
	sub a1, a1, a3
	
	incm tmp
	li a4, 1
	sll a4, a4, tmp
	
	add a0, a0, a4
	j udiv0	
	
endudiv:
	pop ra 
	ret

sdiv:
	push ra
	sign a3, a1
	sign a4, a2
	add a0, a3, a4
	push a0
	unsign a1
	unsign a2
	call udiv
	unsign a0
	pop tmp
	add a0, a0, tmp
	pop ra
	ret
