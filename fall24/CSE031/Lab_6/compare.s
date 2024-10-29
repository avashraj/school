.data
n: .word 25
str1: .asciiz "Less than \n"
str2: .asciiz "Less than or equal to \n"
str3: .asciiz "Greater than\n"
str4: .asciiz "Greater than or equal to \n"
prompt: .asciiz "Please enter an integer: "

.text 
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	lw $t1, n
	
#	slt $t2, $t1, $t0
#	bne $t2, $zero, greater
#	j less
	sgt $t2, $t1, $t0
	beq $t2, $zero, greater

less:
	li $v0, 4
	la $a0, str1
	syscall
	j end

greater:
	li $v0, 4
	la $a0, str4
	syscall
	j end

end:
	li $v0, 10
	syscall


#greater:
#	li $v0, 4
#	la $a0, str4
#	syscall
#	j end

#less:
#	li $v0, 4
#	la $a0, str1
#	syscall
	
#end:
#	li $v0, 10
#	syscall