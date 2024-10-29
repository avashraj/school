.data
prompt: .asciiz "Please enter a number: "
even_msg: .asciiz "\nSum of even numbers is: "
odd_msg: .asciiz "\nSum of odd numbers is: "

.text
main:
	li $t1, 0 #t1 odd sum
	li $t2, 0 #t0 even sum
	
loop:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, $zero, end_loop
	
	srl $t3, $t0, 1
	sll, $t3, $t3, 1
	bne $t0, $t3, odd_number
	
even_number:
	add $t2, $t2, $t0
	j loop
	
odd_number:
	add $t1, $t1, $t0
	j loop
	
end_loop:
	li $v0, 4
	la $a0, even_msg
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 4
	la $a0, odd_msg
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 10
	syscall
	
	
	