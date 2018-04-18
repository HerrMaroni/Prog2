	.data
	.globl iban2knr
	.text
# -- iban2knr
# Argumente:
# a0: IBAN Puffer (22 Bytes)
# a1: BLZ Puffer (8 Bytes)
# a2: KNR Puffer (10 Bytes)
iban2knr:
	# TODO
	
	addiu $a0 $a0 4
	li $t1 0
	li $t2 8
	
L_1:
	
	lb $a1 ($a0)
	addiu $a0 $a0 1
	addiu $a1 $a1 1
	addiu $t1 $t1 1
	bne $t1 $t2 L_1
	
	li $t1 0
	li $t2 10
	
L_2:	
	
	lb $a2 ($a0)
	addiu $a0 $a0 1
	addiu $a2 $a2 1
	addiu $t1 $t1 1
	bne $t1 $t2 L_2
	
	
	jr	$ra
