#Winston Shih
#WXS190012
#CS 2340.003
.data #This represents the data section of the program.
    input1: .asciiz "Enter the size of array: " #Prompt to enter size of array.
    input2: .asciiz "Enter the elements: " #Prompt to insert elements into array.
    input3: .asciiz "Array after swapping: " #Prints message "Array after swapping: ".
    nl: .asciiz "\n" #Prints a new line.
    blank: .asciiz " " #Prints a blank space between two array eleements.
.text #Makes the MIPS machine code executable.
main: #Represents the main method of program.
    li $v0,4 #Loads print string service.
    la $a0, input1 #Loads address of prompt message for array size to register $a0.
    syscall #Prints prompt for array size.
    li $v0, 5 #Reads input for array size.
    syscall #Ensures read input for array size service is implemented.
    move $s0, $v0 #Stores size of array.
    sll $t0, $s0, 2#$t0=$s0*4 calculates array size
    li $v0, 9 #Allocates memory for array size.
    move $a0, $t0 #Moves memory for array size from $t1 to $a0.
    syscall #Ensures memory allocation service is implemented.
    move $s1, $v0 #Stores base address of array.
    li $v0, 4 #Loads print string service.
    la $a0, nl #Loads address for nl.
    syscall #Prints a new line in output.
    li $v0, 4  #Prints array element prompt.
    la $a0, input2 #Loads address of array element prompt to $a0.
    syscall #Ensures service to prompt user for array elements is implemented.
    move $t1, $s1 #Initializes for loop to the first element of array.
    add $t2, $zero, $zero #Creates i and initializes to value of 0.
    forloop1: slt $s2, $t2, $s0 #Checks to see if i<n. If true, $s2=1. Otherwises, $s2=0.
              beq $s2, $zero, exit1 #For loop ends if $s2=0.
              li $v0, 5   #Compiler reads input for array elements.
              syscall #Requests read integer service for array elements.
              sw $v0, 0($t1) #Compiler stores input value at given i.
              addi $t1, $t1, 4 #For loop moves to next element in array a.
              addi $t2, $t2, 1 #i is increased by 1.
              j forloop1 #Repeats loop to input another element.
    exit1: sub $t2, $t2, $t2 #Resets i back to 0
    outerforloop: slt $s3, $t2, $s0 #Checks to see if i<n. If it is true, $s3=1. Else, $s3=0.
                  beq $s3, $zero, exit2  #If $s3=0, then loop branches to exit2
                  addi $t3, $t2, 1  # Declares j and setting it equal to i plus 1.
    innerforloop: slt $s4, $t3, $s0 #Checks to see if j<n. If j<n, $s4=1. If j>=n, then $s4=0.
                  beq $s4, $zero, nexti #Redirects to nexti if $s4=0.
                  sll $t4, $t2, 2  #Calculates offset for a[i] and stores it in $t4.
                  add $t4, $s1, $t4 #Creates address of a[i] and stores it in $t4.
                  sll $t5, $t3, 2  #Calculates offset for a[j] and stores in register $t5.
                  add $t5, $s1, $t5  # Creates a[j]'s address and stores it in $t5.
                  lw $t6, 0($t4)  # Loads address of a[i] into $t6
                  lw $t7, 0($t5)  # Loads address of a[j] into $t7.
                  bgt $t6, $t7, swap  # Checks to see if a[i]>a[j] and will branch if true.
                  addi $t3, $t3, 1 #Increases j counter by 1 if a[i]<=a[j]
                  j innerforloop #Redirects to beginning of innerforloop
    swap: move $t8, $t6 #temp=a[i] moves a[i] into temporary register $t8.
          move $t6, $t7 #a[i]=a[j] moves value of a[j] into $t6.
          move $t7, $t8 #a[j]=temp moves value of temp variable to a[j].
          sw $t6, 0($t4) #Stores a[j] into a[i].
          sw $t7, 0($t5) #Stores a[i] into a[j]. 
          j innerforloop # Redirects to beginning of the inner for loop.
    nexti: addi $t2, $t2, 1 #i++ increases i's value by 1.
           j outerforloop   # Redirects to beginning of the outer for loop.
    exit2: li $v0, 4 #Loads print string service.
           la $a0, nl #Loads address of nl to $a0 register.
           syscall #Prints a new line.
           li $v0, 4  #Loads print string service.
           la $a0, input3 #Loads address of input3.
           syscall  #Prints "Array after swapping: ".
    move $s5, $s1 #Moves base address of array to $s5.
    sub $t2, $t2, $t2 #Resets i back to 0.
    forloop4: slt $t9, $t2, $s0 #Checks to see if i<n. If i<n, $t9=1. Else, $t9=0
              beq $t9, $zero, exit3 #Checks to see if $t9=0. If $t9=0, it redirects to exit3.
              lw $a0, 0($s5)  #Loads address of a[i]
              li $v0, 1  #Loads print integer service
              syscall #Prints a[i]. 
              li $v0, 4 #Loads print string service. 
              la $a0, blank #Loads address for blank.
              syscall  #Prints " " after a[i].
              addi $s5, $s5, 4  #Makes for loop move onto the next element in array a.
              addi $t2, $t2, 1 #Increases i by 1.
              j forloop4 #Redirects to beginning of forloop4
   exit3: li $v0, 10  #Loads service to terminate program
          syscall   #Terminates program.