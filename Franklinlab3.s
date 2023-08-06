#############################
#FRANKLIN SAFARI 	    #
#NOVEMBER 9TH 2022	    #
#PROGRAM THAT COMPUTES 	    #
#THE CUBE ROOOT OF A NUMBER #
#############################


.data
	#Input buffers that contain the appropriate message to print for the user 
	str1: .asciiz "please enter the value whose cube root you wish to compute (non- negative integer): "
	str2: .asciiz "Enter your first estimate for the root value (non negative integer):"
	str3: .asciiz "The cube root is "
	newline: .asciiz "\n"
	
	

.text

cuberoot:
	#code block computes to cube for the guess 
	mul.s $f3, $f2, $f2 
	mul.s $f4, $f3, $f2 

	
	
	#code block that computes the square of the user input 
	mul.s $f5, $f2, $f2 
	
	
	
	#code block that computes the upper difference of the fraction  
	sub.s $f6, $f4, $f1 
	
	
	
	#code that loads the immediate value 3 in the f register 
	li.s $f7, 3.0 
	
	
	
	
	
	#code block that computes the product of the lower fraction 
	mul.s $f8, $f7, $f5
	
	
	#code block that computes the value for the approximation 
	div.s $f9, $f6, $f8 
	
	
	#code block that computes the value of the cube root 
	sub.s $f10, $f2, $f9

	#jumps back to the return address 
	jr $ra

main:
	#code block that prints the content of the str1 buffer 
	la $a0, str1 
	li $v0, 4 
	syscall 
	
	
	
	#code block that prompts the user for input 
	li $v0, 5 
	syscall 
	mtc1, $v0, $f1 #moves the value form which the root is to be obtained to the co processor 
	
	#code to convert from word to single presition 
	cvt.s.w $f1, $f1
	
	
	
	
	#code block that prints the newline 
	la $a0, newline 
	li $v0, 4 
	syscall 
	
	
	#code block the prints the content of the str2 register 
	la $a0, str2
	li $v0, 4 
	syscall 
	
	
	#code block that prompts the user for input 
	li $v0, 5 
	syscall 
	mtc1, $v0, $f2 #moves the estimate value from the user to the f2 processor 
	
	
	#converts from word to single presition 
	cvt.s.w $f2, $f2 
	
	
	#jumps to the function, storing the return address as the line below  
	jal cuberoot 
	
	
	
	
	#code block that moves the values from the co precessor to the main proceessor and 
	#shifts 3 bits of each number to the right to test if they are equal 
	mfc1 $t0, $f10
	srl $t1, $t0, 3 
	mfc1 $t2, $f2
	srl $t3, $t2, 3
	
	#code block to branch if the values of shifted bits in t3 and t1 are equal
	beq $t1, $t3, finalval 
	
	#adds 0 to the t4 register to aid with the addition of the next cube root algonrithm, 
	li $t4, 0
	
	
	
	
	#adds the value zero to the register t6, though not fully necessary but convinient 
	#then the mtc1 instruction effectively overwrites the previous value in f0 with the new value in 
	#t6
	add $t6, $t0, $t4
	mtc1 $t6, $f2 
	
	
	
	
	
	#jomps back to the cube root function 
	j cuberoot 
	
	
	
finalval:

	#code block that prints the str3 buffer 
	la $a0, str3
	li $v0, 4
	syscall 
	
	
	
	
	
	#moves the cube root value obtained from the algorithm from f10, to f12 
	#whicj is the register responsible for printing floating point numbers 
	mov.s $f12, $f10
	li $v0, 2
	syscall 
	
	#code block that prints the newline 
	la $a0, newline 
	li $v0, 4 
	syscall 
	
	
	
	
	#code block to graciously exit the programm 
	li $v0, 10
	syscall
