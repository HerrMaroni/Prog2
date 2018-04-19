	.data
testblz:
	.asciiz "12345678"
testknr:
	.asciiz "1234567890"
ibanbuf:
	.space 23
Iban22:
	.space 23
DE00:
	.asciiz "DE00"
	.globl knr2iban
	.text
# -- knr2iban
# Argumente:
# a0: IBAN buffer (22 Zeichen)
# a1: BLZ buffer (8 Zeichen)
# a2: KNR buffer (10 Zeichen)

	la	$a0 ibanbuf
	la	$a1 testblz
	addu	$sp $sp -4
	sw 	$ra 0($sp)
	la	$a2 testknr
	jal	knr2iban
	lw	$ra 0($sp)
	addu	$sp $sp 4
	li	$v0 10
	la	$a0 ibanbuf
	li	$a1 22
	syscall
	li	$v0 10
	syscall

knr2iban:
	# TODO
	
	move 	$t6 $a0
	move 	$t1 $a1
	move 	$t2 $a2
	
	la 	$a1 Iban22
	la	$a2 DE00
	move	$t7 $ra
	li	$t4 4
	jal	DE002Iban
	li	$t4 8
	jal	Blz2Iban
	li	$t4 10
	jal	Knr2Iban
	move	$ra $t7
	
	addu	$sp $sp -4
	sw 	$ra 0($sp)
	
	jal 	validate_checksum
	
	lw	$ra 0($sp)
	addu	$sp $sp 4
	
	li 	$t0 98
	addiu	$v0 $v0 5
	subu 	$a0 $t0 $v0
	
	bgeu	$a0 10 gt10 
	b	lt10
	
Ende:	
	li	$t4 22
	la	$a1 Iban22
	move 	$a0 $t6
	
	
	move	$t7 $ra
	
	jal	Iban242Iban
	
	move	$ra $t7
	
	jr	$ra



Blz2Iban:
	lbu 	$t3 ($t1)
	sb	$t3 ($a1)	
	addiu	$t1 $t1 1
	addiu	$a1 $a1 1
	
	subiu 	$t4 $t4 1
	bnez 	$t4 Blz2Iban
	jr 	$ra
	
Knr2Iban:
	lbu 	$t3 ($t2)
	sb	$t3 ($a1)	
	addiu	$t2 $t2 1
	addiu	$a1 $a1 1
	
	subiu 	$t4 $t4 1
	bnez 	$t4 Knr2Iban
	jr 	$ra
	
DE002Iban:
	lbu 	$t3 ($a2)
	sb	$t3 ($a1)	
	addiu	$a2 $a2 1
	addiu	$a1 $a1 1
	
	subiu 	$t4 $t4 1
	bnez 	$t4 DE002Iban
	jr 	$ra
	
Iban242Iban:
	lbu 	$t3 ($a1)
	sb	$t3 ($a0)	
	addiu	$a0 $a0 1
	addiu	$a1 $a1 1
	
	subiu 	$t4 $t4 1
	bnez 	$t4 Iban242Iban
	jr 	$ra
	
gt10:
	la	$a1 Iban22
	addiu	$a1 $a1 2
	li	$t1 10
	divu 	$t2 $a0 $t1
	mfhi	$t3
	addiu	$t2 $t2 48
	addiu	$t3 $t3 48 
	sb	$t2 ($a1)  
	addiu	$a1 $a1 1
	sb	$t3 ($a1)
	
	#la	$a1 Iban22
	#addiu	$a1 $a1 2
	#li	$a2 2
	
	#addu	$sp $sp -4
	#sw 	$ra 0($sp)
	
	#jal 	int_to_buf
	
	#lw	$ra 0($sp)
	#addu	$sp $sp 4
	
	b	Ende

lt10:
	la	$a1 Iban22
	addiu	$a1 $a1 2
	li 	$t1 48
	sb	$t1 ($a1)
	addiu	$a1 $a1 1
	addiu	$a0 $a0 48
	sb	$a0 ($a1)
	b	Ende
