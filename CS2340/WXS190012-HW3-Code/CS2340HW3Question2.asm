#Winston Shih
#WXS190012
#CS 2340.003
.data #This represents data section of the program.
     s: .asciiz "grrksfoegrrks" #Array s stores "grrksfoegrrks".
     c1: .byte 'e' #c1 stores char 'e'.
     c2: .byte 'r' #c2 stores char 'r'.
.text #This keyword makes the program executable.
     main: #Represents the main function of program.
          la $a0, s #Loads address of "grrksfoegrrks" to $a0.
          lb $a1, c1 #Loads byte of 'e' to $a1.
          lb $a2, c2 #Loads byte of 'r' to 
          jal replace #Calls replace function.
          li $v0, 4 #Loads print string service.
          la $a0, s #Loads address of 
          syscall #Prints the new string stored in s array.
          li $v0, 10 #Requests service to terminate program.
          syscall #Ends the program.
    replace: #Represents the replace method.
            subi $sp, $sp, 8 #Adjusts stack pointer to have space to push $ra into stack.
            sw $ra, ($sp) #Pushes $ra in stack and stores its address.
            la $a3, s #Loads address of "grrksfoegrrks" to $a3.
            addi $t0, $zero, -1 #Sets index for strlen loop to -1, so loop runs at least once.
    strlen: lb $t1, ($a3) #Loads "grrksfoegrrks" from $a3 to $t1.
            addi $a3, $a3, 1 #Increments string pointer by 1.
            addi $t0, $t0, 1 #Increments i by 1.
            bne $t1, $zero, strlen #If s[i] is not null, then program loops back to beginning of strlen.
    addi $t2, $zero, 0 #Initializes i to 0.
    forloop: lb $t3, 0($a0) #Loads "grrksfoegrrks"'s byte into $t3.
             beq $t2, $t0, complete  #If i=l, then jump to complete.
             beq $t3, $a1, replacetor #If s[i]==c1, then jump to replacetor.
             beq $t3, $a2, replacetoe #If s[i]==c2, then jump to replacetoe
             addi $a0, $a0, 1 #Increments string pointer by 1.
             addi $t2, $t2, 1 #Increments i by 1.
             j forloop #Jumps to beginning of forloop.
    replacetor: sb $a2, 0($a0) #Sets s[i] equal to c2.
                addi $a0, $a0, 1 #Increments string pointer by 1.
                addi $t2, $t2, 1 #Increments i by 1.
                j forloop #Jumps to forloop.
    replacetoe: sb $a1, 0($a0) #Sets s[i] equal to c1.
                addi $a0, $a0, 1 #Increments string pointer by 1.
                addi $t2, $t2, 1 #Increments i by 1.
                j forloop #Jumps to forloop.
    complete: lw $ra, ($sp) #Restores return address of replace function.
             addi $sp, $sp, 8 #Pops replace function's return address out of stack.
             jr $ra #Returns result of replace method.