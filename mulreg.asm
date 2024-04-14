
mulreg:
	push ra
	
	li t1, 0 #i
	li a0, 0
mulreg1:
	li tmp, 32
	beq t1, tmp, mulreg2
	li tmp, 1
	sll tmp, tmp, t1
	and tmp, tmp, a1
	beqz tmp, mulreg3
	sll tmp, a2, t1
	add a0, a0, tmp
mulreg3:
	incp t1
	j mulreg1
mulreg2:
	pop ra
	ret