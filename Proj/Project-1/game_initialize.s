.text
.global game_initialize
game_initialize:
	push {lr}

	mov r0, #0                   /* r0 for time(r0) */
	mov r1, #0                   /* r1 = remainder */
	mov r2, #7                   /* r2 for randomNum % r2 */

	mov r4, #0 @ code 1
	mov r5, #0 @ code 2
	mov r6, #0 @ code 3
	mov r9, #0 @ correct counter
	mov r10, #0 @ incorrect counter
	mov r11, #1 @ turn counter
	mov r12, #'Y' @ play again?

	mov r0, #0
	bl time
	bl srand
	bl rand

	generate_1:
	mov r1, r0, ASR #1
	mov r2, #7
	bl divMod
	mov r4, r1

	generate_2:
        mov r1, r0, ASR #2
	mov r3, #3
 	mul r1, r1, r3
        mov r2, #7
	bl divMod
	mov r5, r1

	generate_3:
        mov r1, r0, ASR #3
        mov r3, #4
        mul r1, r1, r3
        mov r2, #7
	bl divMod
	mov r6, r1

	pop {pc}
	mov pc, lr
