#Winston Shih
#WXS190012
#CS 2340.003
.text #Makes the machine code executable.
    li $a0, 3 #Assigns 3 to parameter N and passes it to Myfun function.
    jal Myfun        #Calls the Myfun function.
    move $a0, $v0    #Moves contents of register $a0 to register $v0.
    li $v0, 1 #Loads print integer service.
    syscall #Prints Myfun(3).
    li $v0, 10 #Requests exit service.
    syscall #Terminates program.
Myfun: #Represents the Myfun function.
     addi $sp, $sp, -8 #Adjusts stack pointer to have space to push $ra and $a0 into $sp stack.
     sw $a0, 0($sp) #Pushes $a0 in stack and stores its return address.
     sw $ra, 4($sp) #Pushes $ra in stack and stores its return address.
     bgt $a0, 3, base #Checks to see if N>3. If N>3, then loop jumps to base case.
     add $v0, $zero, $zero #If N<=3, then $v0=0.
     addi $sp, $sp, 8   #Adjusts stack pointer to remove the unused space in $sp stack.
     jr $ra #Returns value of 0.
base: addi $a0, $a0, -2  #$a0=N-2.
      jal Myfun  #Calls Myfun(N-2).
      lw $a0, 0($sp)  #Pops $a0 out of stack.
      lw $ra, 4($sp)  #Pops $ra out of stack.
      addi $sp, $sp, 8  #Adjusts stack pointer to remove space after $a0 and $ra were removed from $sp stack.
      sll $s0, $a0, 1 #$s0=2*N
      add $v0, $v0, $s0  #$v0=Myfun(N-2)+2N.
      jr $ra  #Returns value of Myfun(N-2)+2N.
     

        
