.data

message: .asciz "\nEnter a temperature 32 <= F <= 212: "
scan:    .asciz "%d"

.text
	.global convertFtoC

convertFtoC:
	push {lr}
	sub sp, sp, #4

	do_while:
	ldr r0, addr_msg
	bl printf

	ldr r0, addr_scan
	mov r1, sp
	bl scanf

	ldr r0, [sp]
	cmp r0, #32
	blt do_while
	cmp r0, #212
	bgt do_while

	mov r4, r0           @ store user input in r4 so that I can print the value at end of main.s

	/* Now calculate ((F - 32) * 5) / 9, where F is the user's input 32 <= F <= 212 */
	sub r0, r0, #32      @ r0 = F - 32
	mov r1, #5
	mul r0, r0, r1       @ r0 = r0 * 5

	/* And then pass r1 and r2 into divMod to get r1 / r2 = final result */
	mov r1, r0
	mov r2, #9

	bl divMod

	add sp, sp, #4
	pop {pc}
	mov pc, lr

addr_msg:  .word message
addr_scan: .word scan
