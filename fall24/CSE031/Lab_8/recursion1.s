.data
prompt: .asciiz "Please enter a number: "
newline: .asciiz "\n"

.text
.globl main
main:

    # printing prompt
    la $a0, prompt      
    li $v0, 4           
    syscall

    # reading integer from user
    li $v0, 5           
    syscall
    move $a0, $v0       

    # calling recursive function
    jal recursion       
    # Result is in $v0

    # printing result
    move $a0, $v0       
    li $v0, 1           
    syscall

    
    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10          
    syscall

#recursion function
recursion:
    # prologue
    addi $sp, $sp, -16   
    sw $ra, 12($sp)
    sw $s0, 8($sp)       
    sw $s1, 4($sp)       
    sw $s2, 0($sp)       

    move $s0, $a0        

    # if(m == -1)
    li $t0, -1
    beq $s0, $t0, ret_3

    # else if(m <= -2)
    li $t0, -2
    slt $t1, $t0, $s0       
    beq $t1, $zero, check_m_less_than_neg2

    # else
    
    addi $a0, $s0, -3       
    jal recursion           # recursion(m - 3)
    move $s1, $v0           # result in $s1

    
    addi $a0, $s0, -2       
    jal recursion           # recursion(m - 2)
    move $s2, $v0           #result in $s2

    
    add $v0, $s1, $s2      
    add $v0, $v0, $s0       

    #  epilogue
    lw $s2, 0($sp)          
    lw $s1, 4($sp)          
    lw $s0, 8($sp)         
    lw $ra, 12($sp)         
    addi $sp, $sp, 16       
    jr $ra                  

check_m_less_than_neg2:
    # if(m < -2)
    li $t0, -2
    slt $t1, $s0, $t0       
    bne $t1, $zero, ret_2   

    # else (m == -2), return 1
    li $v0, 1               


    lw $s2, 0($sp)          
    lw $s1, 4($sp)          
    lw $s0, 8($sp)         
    lw $ra, 12($sp)        
    addi $sp, $sp, 16       
    jr $ra                  

ret_2:
    li $v0, 2               


    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra

ret_3:
    li $v0, 3               

    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
