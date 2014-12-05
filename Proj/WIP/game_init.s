	.data
.align 4
arrayOfCodes: .skip 16

.align 4
arrayOfGuesses: .skip 16

.align 4
numberGuessedCorrectly: .word 0

.align 4
numberGuessedIncorrectly: .word 0

.align 4
turnCounter: .word 0

restartGame: .asciz " %c"

	.text
	.global game_initialize
game_initialize:
	push {lr}

	mov r0, #0                   /* r0 for time(r0) */
	mov r1, #0                   /* r1 = remainder */
	mov r2, #7                   /* r2 for randomNum % r2 */

	bl time		@@ time(r0)
	bl srand	@@ Seed random num generator
	bl rand		@@ r0 <- Random num

	@@ Fill codes array with 3 random digits each 0 < x < 8
	init_codes:
		ldr r6, =codes		@@ Array of 3 codes
		mov r3, #2		@@ Random scalar
		mov r4, #0		@@ Memory address pointer

		b init_compare
		init_loop:
			mov r3, r3, asr #1
			mul r1, r1, r3
			mov r2, #7		@@ Don't want codes > 7
			bl divMod
			str r1, [r6, r4, lsl #2]

			add r4, r4, #1
			init_compare:
				cmp r4, #3
				ble init_loop

	ldr r5, r6	@@ r5 <- arrayOfCodes

	pop {pc}
	mov pc, lr
