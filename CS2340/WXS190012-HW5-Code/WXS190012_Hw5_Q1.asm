#Winston Shih
#WXS190012
#CS 2340.003
.data #Data section of program.
     PAY_RATE: .float 22.55 #Represents value of PAY_RATE.
     BASE_HOURS: .float 40.50 #Represents value of BASE_HOURS.
     OT_MULTIPLIER: .float 1.5 #Represents value of OT_MULTIPLIER.
     noovertime: .float 0.0 #Represents value of overtime if hours<BASE_HOURS.
     hoursinput: .asciiz "How many hours did you work? " #Input prompt for hours of work.
     basepayoutput: .asciiz "Base pay: $" #Output prompt for base pay.
     overtimepayoutput: .asciiz "Overtime pay $"  #Output prompt got overtime pay.
     totalpayoutput: .asciiz "Total pay $" #Output prompt for total pay.
     newline: .asciiz "\n" #Represents endl.
.text #Executable portion of program.
     constants: l.s $f1,PAY_RATE #PAY_RATE=22.55
                l.s $f2,BASE_HOURS #BASE_HOURS=40.50
                l.s $f3,OT_MULTIPLIER #OT_MULTIPLIER=1.5
                l.s $f4,noovertime #overtime=0.0
     main: la $a0,hoursinput #Loads address for hoursinput prompt.
           li $v0,4 #Loads service for printing string.
           syscall #Prints "How many hours did you work? "
           li $v0,6 #Loads service to read input.
           syscall #Reads user's input for total hours they worked.
           mov.s $f12,$f0 #cin>>hours
           jal getBasePay #Calls getBasePay function with getBasePay(hours) call.
           mov.s $f5,$f0 #Result of getBasePay is stored in basePay.          
           c.lt.s $f2, $f0 #Checks to see if BASE_HOURS<hours.
           bc1f print #If false, then jump to print.
           jal getOverTimePay #If true, then call getOverTimePay.
           mov.s $f4,$f0 #Moves return value of getOverTimePay function to overtime.
           add.s $f7,$f5,$f4 #Makes totalPay equal to basePay plus overtimePay.
     print: la $a0,basepayoutput #Loads address for basepayoutput prompt.
            li $v0,4 #Loads print string service.
            syscall #Prints "Base Pay : $".
            mov.s $f12,$f5 #Moves basePay's value to register $f12.
            li $v0,2 #Loads print float service.
            syscall #Prints base pay.
            jal endl #Prints a new line.
            la $a0,overtimepayoutput #Loads address of overtime pay prompt.
            li $v0,4 #Requests print string service.
            syscall #Prints "Overtime pay $".
            mov.s $f12,$f4 #Moves OT_MULTIPLIER value to register $f12.
            li $v0,2 #Loads print float service.
            syscall #Prints overtime pay.
            jal endl #Prints a new line.
            la $a0,totalpayoutput
            li $v0,4 #Loads print string service.
            syscall #Prints "Total pay $".
            mov.s $f12,$f7 #Moves value of totalPay to $f12.
            li $v0,2 #Loads print float service.
            syscall #Prints total pay.
            jal endl #Prints a new line.
     exit: li $v0,10 #Requests service to end program.
           syscall #Ends program.
     getBasePay: c.lt.s $f12,$f2 #Checks to see if BASE_HOURS < hoursWorked.
                 bc1t basepay #If previous condition is true, then jump to basepay.
                 mul.s $f0,$f2,$f1 #If BASE_HOURS>=hoursWorked, then basePay=hoursWorked*PAY_RATE.
                 jr $ra #Returns basePay.
     basepay: mul.s $f0,$f12,$f1 #basePay=BASE_HOURS*PAY_RATE
              jr $ra #Returns basePay.
     getOverTimePay: c.lt.s $f2,$f12 #Checks to see if BASE_HOURS<hoursWorked.
                     bc1t overtime #If hoursWorked is greater than BASE_HOURS, then jump to overtime function.
                     l.s $f0,noovertime #If hoursWorked<=BASE_HOURS, then overtimePay=0.0.
                     jr $ra #Returns overTimePay.
     overtime: sub.s $f12,$f12,$f2 #Stores result of (hoursWorked-BASE_HOURS) to $f12.
               mul.s $f6, $f1, $f3 #Stores result of  PAY_RATE*OT_MULTIPLIER to $f6.
               mul.s $f0,$f12,$f6 #Stores result of (hoursWorked-BASE_HOURS)*PAY_RATE*OT_MULTIPLIER to $f12.
               jr $ra #Returns overTimePay.
     endl: la $a0,newline #Loads address for newLine.
           li $v0,4 #Loads print string service.
           syscall #Prints "\n".
           jr $ra #Returns "\n".        