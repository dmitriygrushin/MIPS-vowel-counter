.data
	counter:	.word	0,0,0,0,0,0
	string:		.space	16
	vowels: 	.asciiz "aeiou"
	userWord:	.asciiz "Enter a word(s): "	
	vowelAmount:.asciiz "Vowel(s): "
	nl: 		.asciiz "\n"
	dash:		.asciiz " - "
	vowel:		.asciiz "y"
.text

main:
	li $v0, 4 			# print: userWord
	la $a0, userWord
	syscall

    li	$v0, 8 			# store: user's word
    la	$a0, string
    li	$a1, 16
    syscall
    
    la $s1, string	
    
stringLoop:
	lb   $t3, 0($s1)	# $t3 store: [nth] string | $s1 string[index]
	addi $s1, $s1, 1	# stringIndex++
	beqz $t3, exit		# if string == 0 goto exit
	
	la $s0, vowels
	la $s2, counter
	
vowelLoop:
	lb   $t2, 0($s0)		   # $t2 store: [nth] vowel | $s0 vowel[index]
	beqz $t2, stringLoop   # if vowel == 0 goto exit
	addi $s0, $s0, 1	   # vowel[index]++
	addi $s2, $s2, 4
	bne  $t3, $t2, vowelLoop# if $t3 != $t2 goto vowelLoop  [ $t3: char | $t2: vowel ]
	beq  $t3, $t2, counterr 
rev:
	addi $s5, $s5, 1 		# vowelCouter++
	j stringLoop

counterr:
	lw   $t4, 0($s2)			# counter array
	move $t6, $t4
	addi $t6, $t6, 1
	sw   $t6, 0($s2)
	
	j rev
exit:	
	beqz $s5, loopy
	
	jal sayVowelAmount
	
	li   $v0, 1
	move $a0, $s5
	syscall

	li $s2, 4
	
	while2:
		beq  $s2, 24, exit2
		lw   $t5, counter($s2)
		addi $s2, $s2, 4
		
		li   $v0, 4 			
		la   $a0, nl
		syscall
		
		beq  $s3, 5, exit2
		lb   $t7 vowels($s3)
    	move $a0, $t7

	 	li   $v0, 11			# print vowel char
    	syscall
   		addi $s3, $s3, 1	# vowel[index]++
   		
   		li   $v0, 4 			
		la   $a0, dash
		syscall
		
		li   $v0, 1			# prints vowel amount
		move $a0, $t5
		syscall

		j while2
	
	exit2:

	li $v0, 10
	syscall
	
loopy:
la $s1, string	
stringLoop1:
	lb   $t3, 0($s1)			# $t3 store: [nth] string | $s1 string[index]
	addi $s1, $s1, 1		# stringIndex++
	beqz $t3, exit1			# if string == 0 goto exit
	
	la $s0, vowel

vowelLoop1:
	lb   $t2, 0($s0)			# $t2 store: [nth] vowel | $s0 vowel[index]
	beqz $t2, stringLoop1	# if vowel == 0 goto exit
	addi $s0, $s0, 1		# vowel[index]++
	addi $s2, $s2, 4
	bne  $t3, $t2, vowelLoop1# if $t3 != $t2 goto vowelLoop  [ $t3: char | $t2: vowel ]

rev1:
	addi $s5, $s5, 1 		# vowelCouter++
	j stringLoop1
	
	li   $v0, 1
	move $a0, $s5
	syscall
exit1:

	jal sayVowelAmount

	li   $v0, 1
	move $a0, $s5
	syscall
	
	li $v0, 4 
	la $a0, nl
	syscall
	
	li $v0, 4 
	la $a0, vowel
	syscall
	
	li $v0, 4 
	la $a0, dash
	syscall
	
	li $v0, 1
	move $a0, $s5
	syscall
	
	li $v0, 10
	syscall
	
sayVowelAmount:
	li $v0, 4 
	la $a0, vowelAmount
	syscall
	
	jr $ra


