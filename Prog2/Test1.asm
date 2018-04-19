.data

test:
	.space 6
newlinestr:
	.asciiz "\n"
	
.text 

	la $a0 test
	li $a1 5

readbuf:
	
	# Lese die Eingabe
	addu	$a1 $a1 1
	li	$v0 8
	syscall
	# Springe in die naechste Zeile
	#la	$a0 newlinestr
	#li	$v0 4
	#syscall
	
	
	
	
	
	li $s1 0
	li $s2 0
	

	la $a0 test
	
	lb $s1 ($a0)
	subiu $s1 $s1 55
	addiu $s1 $s1 1
	addiu $a0 $a0 1
	lb $s1 ($a0)
	subiu $s1 $s1 55
	addiu $s1 $s1 1
	addiu $a0 $a0 1
	lb $s1 ($a0)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $s1 ($a0)
	addiu $a0 $a0 1
	addiu $s1 $s1 1
	lb $s1 ($a0)
	subiu $s1 $s1 4
	
	la $a0 test
	
	sb $s1 ($a0)
	subiu $s1 $s1 1
	addiu $a0 $a0 1
	sb $s1 ($a0)
	subiu $s1 $s1 1
	addiu $a0 $a0 1
	sb $s1 ($a0)
	subiu $s1 $s1 1
	addiu $a0 $a0 1
	sb $s1 ($a0)
	subiu $s1 $s1 1
	addiu $a0 $a0 1
	sb $s1 ($a0)
	
	

Loop3:	
	li	$v0 4
	la	$a0 newlinestr
	syscall
	la $a0 test
	syscall
	la	$a0 newlinestr
	syscall
	

	
