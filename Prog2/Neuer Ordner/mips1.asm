.data
	abfrage1:
		.ascii "Bitte n eingeben: \n"
.align 2
	buchstaben:
		.word 21
.text
		la $t0 buchstaben
		move $t1 $0 # n = Verschiebung
		move $t2 $0 # Zähler
		move $t3 $0 # Platzhalter für = 0 oder != 0
		
		li $v0 4
		la $a0 abfrage1 # n einlesen
		syscall 
		li $v0 5
		syscall
		move $t1 $v0 # n ins t1 register laden
		
	loopAdd:
		li $v0 8
		li $a1 1
		syscall
		add $a0 $a0 $t1
		
		sw $a0 buchstaben($t2)
		add $t2 $t2 4 # Zähler +4
		
		#add $t0 $t0 1 # Setzt den Zähler in der Liste einen weiter
		
		sltiu $t3 $t2 80  # genau 20 = 0, weniger als 20 = 1
		bne $t3 $0 loopAdd # wenn 1 dann loop, wenn 0 dann weiter
		sub $t2 $t2 4 # Zähler -4
		
	loopAusgabe:
		lw $a0 buchstaben($t2)
		
		li $v0 4
		syscall
		
		sub $t2 $t2 4 # Zähler -4
		bgtz $t2 loopAusgabe # wenn t2 >= 0 springen
		
		li $v0 10
		syscall
