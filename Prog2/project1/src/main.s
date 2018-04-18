	.data
	.globl main
# Konstante Zeichenketten
greeterstr:
	.asciiz "IBAN <-> KNR+BLZ Konverter\n1.) IBAN nach KNR+BLZ\n2.) KNR+BLZ nach IBAN\nEingabe:"
destr:
	.asciiz "DE"
invalidstr:
	.asciiz "Ungueltige Einabe!\n"
ibanstr:
	.asciiz "IBAN:"
knrstr:
	.asciiz "KNR:"
blzstr:
	.asciiz "BLZ:"
newlinestr:
	.asciiz "\n"
zzstr:
	.asciiz "00"
emptystr:
	.asciiz ""
# Meldungen
checksumok_msg:
        .asciiz "Gueltige Pruefsumme!"
checksum_errmsg:
        .asciiz "Ungueltige IBAN Pruefsumme!"
deprefix_errmsg:
        .asciiz "Keine deutsche IBAN!"
  
# Lokale Zeichenkettenbuffer
# Wir allozieren ein zusaetzliches Byte um das Ende der Zeichenkette mit '\0' zu markieren
knrbuf:
	.space 11
blzbuf:
	.space 9
ibanbuf:
	.space 23
    
	.text
main:
	# Greeter anzeigen
	la	$a0 greeterstr
	jal	print

# Eingabe erwarten
menu:
	li	$v0 5
	syscall
	beq	$v0 1 menu_iban_to_knr
	beq	$v0 2 menu_knr_to_iban
  
	la	$a0 invalidstr
	jal	print
	j	end



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


menu_knr_to_iban:
# KNR einlesen
	la	$a0 knrstr
	jal	print
	la	$a0 knrbuf
	li	$a1 10
	jal	readbuf
  
# BLZ einlesen
	la	$a0 blzstr
	jal	print
	la	$a0 blzbuf
	li	$a1 8
	jal	readbuf

	la	$a0 ibanbuf
	la	$a1 blzbuf
	la	$a2 knrbuf
	jal	knr2iban
  
# IBAN ausgeben
	la	$a0 ibanstr
	jal	print
	la	$a0 ibanbuf
	jal	println
	j	end
