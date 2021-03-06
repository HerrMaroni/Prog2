	.data
Iban24:
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
knr2iban:
	# TODO
	
	move 	$t6 $a0
	move 	$t1 $a1
	move 	$t2 $a2
	
	la 	$a1 Iban24
	la	$a2 DE00
	move	$t7 $ra
	li	$t4 6
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
	subu 	$a0 $t0 $v0
	
	bgeu	$a0 10 gt10 
	b	lt10
	
Ende:	
	move	$a0 $t6 
	la	$a1 Iban24
	li	$a2 22
	
	addu	$sp $sp -4
	sw 	$ra 0($sp)
	
	jal	memcpy
	
	lw	$ra 0($sp)
	addu	$sp $sp 4
	
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
	
gt10:
	la	$a1 Iban24
	addiu	$a1 $a1 2
	li	$a2 2
	
	addu	$sp $sp -4
	sw 	$ra 0($sp)
	
	jal 	int_to_buf
	
	lw	$ra 0($sp)
	addu	$sp $sp 4
	
	b	Ende

lt10:
	la	$a1 Iban24
	addiu	$a1 $a1 2
	li 	$t1 48
	sb	$t1 ($a1)
	addiu	$a1 $a1 1
	sb	$a0 ($a1)
	b	Ende
