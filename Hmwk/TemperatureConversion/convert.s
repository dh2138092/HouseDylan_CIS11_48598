.text
	.global convert_F_to_C

convert_F_to_C:
	push {lr}

	/* Calculate ((F - 32) * 5), where F is the user's input 32 <= F <= 212 */
	sub r0, r0, #32      @ r0 = F - 32
	mov r1, #5
	mul r0, r0, r1       @ r0 = r0 * 5

	/* Then (r0 / 9) to get final value of Fahrenheit -> Celsius conversion */
	/* So, pass r1 and r2 into divMod to get r1 / r2 = Celsius */
	mov r1, r0
	mov r2, #9

	bl divMod

	pop {pc}
	mov pc, lr
