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
	jr	$ra
