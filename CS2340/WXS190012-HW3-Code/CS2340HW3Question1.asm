#Winston Shih
#WXS190012
#CS 2340.003
.data #Section represents data section of machine code.
     x: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 #Stores the x array.
     message: .asciiz "Element at x[" #Stores "Element at x[" string.
     arraybrackets: .asciiz "][" #Stores "][" string.
     arraybracket: .asciiz "] = " #Stores "] = " string.
     newline: .asciiz "\n" #Stores new line.
.text #Section makes machine code executable.
main: #Represents the main(void) method of program.
     addi $s0, $zero, 2 #Sets total number of rows equal to 2
     addi $s1, $zero, 3 #Sets total number of columns equal to 3.
     addi $s2, $zero, 2 #Sets total depth to 2.
     addi $t0, $zero, 0 #Initializes i to 0.
     outerloop: slti $s3, $t0, 2 #Checks to see if i<2 and stores result in $s3.
                beq $s3, $zero, exit #If $s3=0, then i<2 is false and program jumps to exit. 
                addi $t1, $zero, 0 #int j=0
     middleloop: slti $s4, $t1, 3 #Checks to see if j<3 and stores result in $s4.
                 beq $s4, $zero, exit2 #If $s4=0, then j<3 is false and jump to exit2.
                 addi $t2, $zero, 0 #Sets k=0.
    innerloop: slti $s5, $t2, 2 #Checks to see if k<2 and stores result in $s5.
               beq $s5, $zero, exit3 #If $s5=0, then condition k<2 is false and jump to exit3.
               li $v0, 4 #Requests print string service.
               la $a0, message #Loads message address to $a0.
               syscall #Prints "Element at x[".
               li $v0, 1 #Requests print string service
               move $a0, $t0 #Moves index i's address to $a0.
               syscall #Prints index i.
               li $v0, 4 #Requests print string service.
               la $a0, arraybrackets #Loads address of arraybrackets to $a0.
               syscall #Prints "]["
               li $v0, 1 #Requests print string service.
               move $a0, $t1 #Loads address for index j.
               syscall #Prints index j.
               li $v0, 4 #Requests print string service.
               la $a0, arraybrackets #Loads address of arraybrackets to $a0.
               syscall #Prints "]["
               li $v0, 1 #Requests print string service.
               move $a0, $t2 #prints index k.
               syscall #Prints index k.
               li $v0, 4 #Requests service to print string.
               la $a0, arraybracket #Loads address of arraybracket to $a0.
               syscall #Prints "] = "
               mul $t3, $t0, $s1 #$t3=i*total columns
               mul $t3, $t3, $s2 #$t3=i*total columns*total depth
               mul $t4, $t1, $s2 #$t4=j*total depth
               add $t5, $t3, $t4 #$t5=i*total columns*total depth+j*total depth
               add $t5, $t5, $t2 #$t5=i*total columns*total depth+j*total depth+k
               li $v0, 1 #Requests print integer service.
               move $a0, $t5 #Moves address of x[i][j][k] to $a0.
               syscall #Prints number located at x[i][j][k].
               li $v0, 4  #Requests print string service.
               la $a0, newline #Loads address of newline ro $a0.
               syscall #Prints newline.
               add $t2, $t2, 1 #Increments k by 1.
               j innerloop #Jumps back to beginning of innerloop.
    exit3: addi $t1, $t1, 1 #Increments j by 1.
           j middleloop #Jumps back to beginning of middleloop.
    exit2: addi $t0, $t0, 1 #Increments i by 1.
           j outerloop #Jumps back to beginning of outerloop.
    exit: li $v0, 10 #Requests service to end program.
          syscall #Terminates the program.