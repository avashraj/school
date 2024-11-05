.data
str_pq: .asciiz "p + q: "

.text
.globl main

main:
    #saving s0 to s2 on the stack
    addi $sp, $sp, -12
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    # Initialize x = 2, y = 4, z = 6
    li $s0, 2       # x
    li $s1, 4       # y
    li $s2, 6       # z

    # Prepare arguments and call foo(x, y, z)
    move $a0, $s0   # m = x
    move $a1, $s1   # n = y
    move $a2, $s2   # o = z
    jal foo

    # Compute z = x + y + z + foo_ret
    add $t0, $s0, $s1
    add $t0, $t0, $s2
    add $s2, $t0, $v0   

    # Print the value of z
    move $a0, $s2
    li $v0, 1           
    syscall
    li $a0, '\n'
    li $v0, 11          
    syscall

    # Function epilogue: Restore $s0-$s2 and exit
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    addi $sp, $sp, 12
    li $v0, 10          
    syscall

foo:
    # saving $ra andn s0 - s4 on stack
    addi $sp, $sp, -28
    sw $ra, 24($sp)
    sw $s0, 20($sp)     # p
    sw $s1, 16($sp)     # q
    sw $s2, 12($sp)     # m
    sw $s3, 8($sp)      # n
    sw $s4, 4($sp)      # o

    # Copy m, n, o into saved registers
    move $s2, $a0       # m
    move $s3, $a1       # n
    move $s4, $a2       # o

    #### First call to bar ####
    add $t0, $s2, $s4
    add $t1, $s3, $s4
    add $t2, $s2, $s3

    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    jal bar
    move $s0, $v0       

    #### Second call to bar ####
    sub $t0, $s2, $s4
    sub $t1, $s3, $s2
    add $t2, $s3, $s3

    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    jal bar
    move $s1, $v0       

    add $t0, $s0, $s1   # p + q

    la $a0, str_pq
    li $v0, 4           
    syscall
    move $a0, $t0
    li $v0, 1           
    syscall
    li $a0, '\n'
    li $v0, 11          
    syscall

    move $v0, $t0

    lw $s4, 4($sp)
    lw $s3, 8($sp)
    lw $s2, 12($sp)
    lw $s1, 16($sp)
    lw $s0, 20($sp)
    lw $ra, 24($sp)
    addi $sp, $sp, 28
    jr $ra

bar:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # Compute (b - a) << c
    sub $t0, $a1, $a0
    sllv $v0, $t0, $a2  

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
