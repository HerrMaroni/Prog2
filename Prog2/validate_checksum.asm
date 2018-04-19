	.data
Iban24:
	.space 25
DE2:
	.ascii "1314"
	.space 3
	
	.globl validate_checksum
	.text

# -- validate_checksum --
# Argumente:
# a0 : Adresse einer Zeichenkette, die eine deutsche IBAN darstellt (22 Zeichen)
# Rueckgabewert:
# v0 : die berechnete Pruefsumme
validate_checksum:
	# TODO
	
# a0 Puffer der IBAN
# a1 Iban24
# a2 DE2
# t0 Zähler
# t1 Zwischenspeicher für Adresse zu Adresse
# t7 Zwischenspeicher Sprungadresse

Start:
	la 	$a1 Iban24
	la 	$a2 DE2
	
	addiu 	$a0 $a0 2
	addiu 	$a2 $a2 4
	
	move 	$t7 $ra
	li 	$t0 2
	jal	LDE2
	li 	$t0 18
	jal 	L18
	li 	$t0 6
	jal 	L6
	move 	$ra $t7
	
ModStrAufruf:
	la	$a0 Iban24
	li 	$a1 24
	li 	$a2 97
	
	subiu	$sp $sp 4
	sw	$ra ($sp)
	jal	modulo_str
	lw	$ra ($sp)
	addiu	$sp $sp 4
	
	
	jr	$ra
	
	

# Loop für IBAN 3-4 nach DE2 5-6
LDE2:
	lbu 	$t1 ($a0)
	sb	$t1 ($a2)	
	addiu	$a0 $a0 1
	addiu	$a2 $a2 1
	
	subiu 	$t0 $t0 1
	bnez 	$t0 LDE2
	subiu	$a2 $a2 6
	jr 	$ra
	
# Loop für IBAN 5-22 nach Iban24 1-18
L18:
	lbu 	$t1 ($a0)
	sb	$t1 ($a1)	
	addiu	$a0 $a0 1
	addiu	$a1 $a1 1
	
	subiu 	$t0 $t0 1
	bnez 	$t0 L18
	jr 	$ra
	
# Loop für DE2 1-6 nach Iban24 19-24
L6:
	lbu 	$t1 ($a2)
	sb	$t1 ($a1)	
	addiu	$a2 $a2 1
	addiu	$a1 $a1 1
	
	subiu 	$t0 $t0 1
	bnez 	$t0 L6
	jr 	$ra
