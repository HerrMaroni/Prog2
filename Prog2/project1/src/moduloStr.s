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
	jr $ra
