	.data
	.globl validate_checksum
	.text

# -- validate_checksum --
# Argumente:
# a0 : Adresse einer Zeichenkette, die eine deutsche IBAN darstellt (22 Zeichen)
# Rueckgabewert:
# v0 : die berechnete Pruefsumme
validate_checksum:
	# TODO
	
	li $s1 0
	li $s2 0
	li $s3 18
	li $s4 0


	lb $s1 ($a0)
	subiu $s1 $s1 54
	addiu $a0 $a0 1
	lb $s1 ($a0)
	subiu $s1 $s1 54
	addiu $a0 $a0 1
	lb $s1 ($a0)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $s1 ($a0)
	addiu $a0 $a0 1
	subiu $s1 $s1 3
	
	
Loop1:
	lb $s2 ($a0)
	addiu $a0 $a0 1
	addiu $s2 $s2 1
	addiu $s4 $s4 1
	
	bne $s3 $s4 Loop1
	
	li $a0 0
	subiu $s2 $s2 18
	li $s3 18
	li $s4 0
	
Loop2:
	lb $a0 ($s2)
	addiu $a0 $a0 1
	addiu $s2 $s2 1
	addiu $s4 $s4 1
	
	bne $s3 $s4 Loop2
	
	lb $a0 ($s1)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $a0 ($s1)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $a0 ($s1)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $a0 ($s1)
	
	
	
	
	jr	$ra
