.data

ibanstr:
	.asciiz "IBAN:"
knrstr:
	.asciiz "KNR:"
blzstr:
	.asciiz "BLZ:"
newlinestr:
	.asciiz "\n"
knrbuf:
	.space 11
blzbuf:
	.space 9
ibanbuf:
	.space 23
		
# a0: IBAN Puffer (22 Bytes)
# a1: BLZ Puffer (8 Bytes)
# a2: KNR Puffer (10 Bytes
    
.text

menu_iban_to_knr:
# IBAN einlesen
	la	$a0 ibanstr
	jal	print
	la	$a0 ibanbuf
	li	$a1 22
	jal	readbuf
# IBAN pruefen
	la	$a0 ibanbuf
	# jal verify_iban
	# la	$a0 deprefix_errmsg
	# beq	$v0 1 error
	# la	$a0 checksum_errmsg
	# beq	$v0 2 error
	# la	$a0 checksumok_msg
	# jal	println

# Aufruf von iban_to_knr
	la	$a0 ibanbuf
	la	$a1 blzbuf
	la	$a2 knrbuf
	jal	iban2knr
  
# Gebe die KNR aus 
	la	$a0 knrstr
	jal	print
	la	$a0 knrbuf
	jal	println
  
# Gebe die BLZ aus
	la	$a0 blzstr
	jal	print
	la	$a0 blzbuf
	jal	println
  
# fertig
	j	end
	
	
	
iban2knr:	
	# TODO
	
	addiu $a0 $a0 4
	li $t1 0
	li $t2 8
	li $t3 0
	
L_BLZ:
	
	lb $t3 ($a0)
	sb $t3 ($a1)
	addiu $a0 $a0 1
	addiu $a1 $a1 1
	addiu $t1 $t1 1
	bne $t1 $t2 L_BLZ
	
	li $t1 0
	li $t2 10
	
L_KNR:	
	
	lb $t3 ($a0)
	sb $t3 ($a2)
	addiu $a0 $a0 1
	addiu $a2 $a2 1
	addiu $t1 $t1 1
	bne $t1 $t2 L_KNR
	
	jr	$ra
	
	
	
	
	
# Schreibt den String bei $a0
print:
	li	$v0 4
	syscall
	jr	$ra
	
# -- println --
# Eingaberegister:
# a0: Startadresse der Zeichenkette
# Ausgaberegister: keine
# Funktion:
# Schreibt die Zeichenkette bei der Adresse a0 auf die Konsole, gefolgt von einem Zeilensprung
println:
	li	$v0 4
	syscall
	la	$a0 newlinestr
	syscall  
	jr	$ra
		
readbuf:
	# Lese die Eingabe
	addu	$a1 $a1 1
	li	$v0 8
	syscall
	# Springe in die naechste Zeile
	la	$a0 newlinestr
	li	$v0 4
	syscall
  	jr	$ra
  	
  end:
	li	$v0 10
	syscall
  	
