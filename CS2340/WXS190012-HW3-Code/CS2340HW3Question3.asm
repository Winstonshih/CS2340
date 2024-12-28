#Winston Shih
#WXS190012
#CS 2340.003
.data #Represents the data section of machine code.
     arr: .space 64 #4*4 matrix has 16 integers*4 bytes/integer= 64 total bytes.
.text #Key word that makes machine code executable.
     addi $s0, $zero, 4 #M=4.
     addi $s1, $zero, 4 #N=4.
     main: #Represents the main methof of program.
          la $a0, arr #Loads arr's address to $a0.
          addi $t0, $zero, 1 #Initializes x to 1.
          addi $t1, $zero, 0 #Initializes i to 0.
     mainouterloop: beq $t1, $s0, printsum #Checks to see if i equals M. If true,program jumps to printsum.
                    addi $t2, $zero, 0 #Initializes j to 0.
     maininnerloop: beq $t2, $s1, nextimain #Jumps to nextimain if j=N.
                    mul $t3, $t1, $s1 #$t3=i*N
                    add $t3, $t3, $t2 #$t3=i*N+j
                    sll $t3, $t3, 2 #Creates offset for arr[i][j].
                    add $t3, $t3, $a0 #Creates arr[i][j]'s address.
                    sw $t0, ($t3) #Stores x's value to arr[i][j].
                    addi $t0, $t0, 1 #x is incremented by 1.
                    addi $t2, $t2, 1 #j is incremented by 1.
                    j maininnerloop #Jumps back to beginning of maininnerloop.
     nextimain: addi $t1, $t1, 1 #i is incremented by 1.
                j mainouterloop #Jumps to mainouterloop.
     printsum: la $a0, arr #Loads address of arr array to $a0.
               jal sum #Calls back sum function.
               move $a0, $v0 #Moves return value of sum from $v0 to $a0.
               li $v0, 1 #Requests print integer service.
               syscall #Prints value of sum.
               li $v0, 10 #Requests service to end program.
               syscall #Ends program.
     sum: addi $t4, $zero, 0 #Initializes sum to 0.
          addi $t1, $zero, 0 #Initializes i to 0.
     sumouterloop: beq $t1, $s0, exit #Jumps to exit.
                   sub $t2, $t2, $t2 #initializes j to 0.
     suminnerloop: beq $t2, $s1, nextisum #Jumps to nextisum.
                   mul $t5, $t1, $s1 #$t5=i*N
                   add $t5, $t5, $t2 #$t5=i*N+j
                   sll $t5, $t5, 2 #Creates offset for arr[i][j].
                   add $t5, $t5, $a0 #Creates address for arr[i][j]
                   lw $t6, ($t5) #Loads arr[i][j]'s address to $t6.
                   add $t4, $t4, $t6 #sum=sum+arr[i][j]
                   addi $t2, $t2, 1 #j increments by 1.
                   j suminnerloop #Jumps to suminnerloop.
     nextisum: addi $t1, $t1, 1 #i increments by 1.
               j sumouterloop #Jumps to sumouterloop.   
     exit: move $v0, $t4 #Moves sum to register $v0.
           jr $ra #Returns the sum.  