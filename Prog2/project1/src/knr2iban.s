	.data
	.globl knr2iban
	.text
# -- knr2iban
# Argumente:
# a0: IBAN buffer (22 Zeichen)
# a1: BLZ buffer (8 Zeichen)
# a2: KNR buffer (10 Zeichen)
knr2iban:
	# TODO
	jr	$ra
