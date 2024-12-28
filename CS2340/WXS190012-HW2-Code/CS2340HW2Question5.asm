#Winston Shih
#WXS190012
#CS 2340.003
.data #.data represents the data section of the program.
    str1: .asciiz "Geeks" #Stores "Geeks" into str1[100].
    str2: .asciiz "World" #Stores "World" into str2[100]
    print1: .asciiz "First string: " #Stores message "First string: ".
    print2: .asciiz "Second string: " #Stores message "Second string: ".
    print3: .asciiz "Concatenated string: " #Stores message "Concatenated string: ".
    newLine: .asciiz "\n" #Stores "\n".
    str3: .space 100 #Initializes char str3[100]
.text #Makes the machine code executable.
main: #Represents the main method of program.
     li $v0, 4 #Loads print string service.
     la $a0, newLine #Loads address for newline to register $a0.
     syscall #Prints new line.
     li $v0, 4 #Loads print string service.
     la $a0, print1 #Loads address for print1 to register $a0
     syscall #Prints "First string: "
     li $v0, 4 #Loads print string service service
     la $a0, str1 #Loads address for str1[100] to register $a0
     syscall #Prints "Geeks".
     li $v0, 4 #Loads print string service.
     la $a0, newLine #Loads address for newline to register $a0.
     syscall #Prints new line.
     li $v0, 4 #Loads print string service.
     la $a0, print2 #Loads address for print2 to register $a0.
     syscall #Prints "Second string: "
     li $v0, 4 #Loads print string service.
     la $a0, str2 #Loads address for str2[100] to register $a0.
     syscall #Prints "World".
     add $t0, $zero, $zero #$t0=i=0
     add $t1, $zero, $zero #$t1=j=0
     while1: lb $t2, str1($t0) #Loads byte of str1[i] to $t2
             beq $t2, $zero, exit1 #Checks to see if str1[i] equals '\0'. If it does, it branches to exit1.
             sb $t2, str3($t1) #Store byte of str1[i] to str3[j].
             addi $t0, $t0, 1 #Increases i counter by 1.
             addi $t1, $t1, 1 #Increases j counter by 1.
             j while1 #Redirects to beginning of while1 loop.
     exit1: sub $t0, $t0, $t0 #i=i-i rests i counter back to 0.
     while2: lb $t2, str2($t0) #Loads byte of str2[i] to $t2.
             beq $t2, $zero, exit2 #Checks to see if str2[i] equals '\0'. If it does, it branches to exit2.
             sb $t2, str3($t1) #Store byte of str2[i] to str3[j].
             addi $t0, $t0, 1 #Increases i by 1.
             addi $t1, $t1, 1 #Increases j by 1.
             j while2 #redirects to beginning of while2 loop.
     exit2: sb $zero, str3($t1) #Stores '\0' to str3[j]
     li $v0, 4 #Loads print string service.
     la $a0, newLine #Loads address for newline to register $a0.
     syscall #Prints new line.
     li $v0, 4 #Loads print string service.
     la $a0, print3 #Loads address for print3 to register $a0.
     syscall #Prints "Concatenated string: ".
     li $v0, 4 #Loads print string service.
     la $a0, str3 #Loads address for str3 to register $a0.
     syscall #Prints concatenated result of "Geeks" and "World".
     li $v0, 10 #Loads exit service.
     syscall #Ends program.