.data
.text 

	move $t0, $s0
	addi $t1, $t0, -7
	add $t2, $t1, $t0
	addi $t3, $t2,2
	add $t4, $t3, $t2
	addi $t5, $t4, -28  
	sub $t6, $t4, $t5
	addi $t7, $t6, 12
	move $a0, $t7
	li $v0, 1
	syscall