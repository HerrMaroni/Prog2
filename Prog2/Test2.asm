.data
a0text:
	.asciiz "123456"
buffer:
	.space 8
.text

li $a0 15678
la $a1 buffer
li $a2 2


# -- int_to_buf --
# Eingaberegister:
# a0: eine positive Zahl
# a1: Startadresse des Buffers
# a2: Anzahl der Stellen (von rechts)
# Ausgaberegister: keine
# Funktion:
# Schreibt die ersten $a2 Ziffern der positiven Zahl in $a0 als dezimale Zeichenkette in den Speicherbereich [$a1 bis $a1 + $a2 - 1]
int_to_buf:
	move	$t2 $a1       # $t2 Startadresse des Buffers
	add	$t3 $a1 $a2
	subu	$t1 $t3 1   # $t1 Adresse des hoechsten Zeichens
	move	$t0 $a0       # $t0 restliche Zahl

ib_loop:
# $t0 enthaelt die verbleibende Zahl
# entferne die erste Dezimalstelle der Zahl in $t0
# $t3 enthaelt die extrahierte Ziffer als Zahl
	move	$t3 $t0
	divu	$t0 $t0 10
	mulu	$t4 $t0 10
	subu	$t3 $t3 $t4 # $t3 = $t3 - (($t3 / 10) * 10)

# Kodiere die Ziffer in $t3 als ein ASCII Zeichen und schreibe es nach $t1
	addu	$t3 $t3 48
	sb	$t3 ($t1)

# Gehe zum naechsten Zeichen
	subu	$t1 $t1 1
	bgeu	$t1 $t2 ib_loop
	
	
	move $a0 $a1
	
	print:
	li	$v0 4
	syscall
	jr	$ra