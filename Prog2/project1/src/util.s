	.data
	.globl memcpy
	.globl int_to_buf
	.globl println
	.globl print
	.globl readbuf
	.globl end
	.globl error
	.globl println_range

newlinestr:
	.asciiz "\n"
	.text
	
# -- memcpy --
# Eingaberegister:
# a0: Zieladresse
# a1: Startadresse
# a2: Anzahl an bytes
# Ausgaberegister: keine
# Funktion:
# Kopiert den Speicherbereich [$a1 bis $a1 + $a2 - 1] nach  [$a0 bis $a0 + $a2 - 1]
memcpy:
	move	$t0 $a0 # $t0 = aktuelle Zieladresse
	move	$t1 $a1 # $t1 = aktuelle Quelladresse
	addu	$t2 $a1 $a2 # $t2 = letzte Quelladresse

mc_loop:
	lbu	$t4 ($t1)
	sb	$t4 ($t0)
	addu	$t0 $t0 1
	addu	$t1 $t1 1
	bltu	$t1 $t2 mc_loop

mv_return:
	jr	$ra

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

ib_return:
	jr	$ra

# a0 : String
# a1 : Anzahl der Zeichen
println_range:
	addu	$t1 $a0 $a1
	move	$t0 $a0
	li	$v0 11
pr_loop:
	bgeu	$t0 $t1 pr_exit
	lbu	$a0 0($t0)
	syscall
	addiu	$t0 $t0 1
	b	pr_loop
	
pr_exit:
	li	$a0 10 # '\n'
	syscall
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
	
# -- readbuf --
# Eingaberegister:
# a0: Startadresse des Zielbuffers
# a1: Laenge der Zeichenkette
# Ausgaberegister: keine
# Funktion:
# List eine Zeichenkette von der Konsole der maximalen Laenge $a1 in den Buffer bei $a0 ein
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

# -- end --
# Eingaberegister: keine
# Ausgaberegister: keine
# Funktion: Beendet das Programm
end:
	li	$v0 10
	syscall

# -- error --
# Eingaberegister:
# a0: Null-terminierte Zeichenkette mit einer Fehlermeldung
# Ausgaberegister: keine
# Funktion:
# Schreibt die Nachricht in $a0 und beendet das Programm mit einem Fehlercode
error:
# Schreibe die Fehlermeldung
	li	$v0 4
	syscall
# Breche mit einem Fehlercode ab
	li	$a0 1
	li	$v0 17
	syscall
