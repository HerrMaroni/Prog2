	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: Startadresse des Puffers
# a1: Anzahl der Zeichen im Puffer
# a2: Der Teiler
# Rueckgabewert:
# v0: Die im Puffer [$a0 bis $a0 + $a1 - 1] darstellte Dezimalzahl (kodiert in ASCII Ziffern '0' bis '9') modulo $a2
modulo_str:
	# TODO
	
	# a0 Start Adresse
	# a1 End   Adresse
	# a2 Teiler
	# t0 Zwischenspeicher für die Zahl 10
	# t1 Zwischenspeicher für die Division und Rest
	# t2 Zwischenspeicher für die Nächste Zahl
	# v0 Rest
	
	
	addu $a1 $a0 $a1
	li $t0 10
	
	beq $a0 $a1 Ende
	lbu $v0 ($a0)
	subiu $v0 $v0 48

# Letzte Zahl	
LZahl:	
	addiu $a0 $a0 1
	beq $a0 $a1 LMod

# Normales Mod	
Mod:
	divu $t1 $v0 $a2
	mfhi $t1
	move $v0 $t1
	
# Mindestens 2 Zahlen	
MZahl:
	lbu $t2 ($a0)
	subiu $t2 $t2 48
	addu $v0 $v0 $t2
	mulu $v0 $v0 $t0
	b LZahl
			
# Letztes Mod			
Lmod:
	divu $t1 $v0 $a2
	mfhi $t1
	move $v0 $t1
		
Ende:
	jr $ra
