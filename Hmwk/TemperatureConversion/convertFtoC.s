.data

message: .asciz "Enter a temperature 32 <= F <= 212: "
scan:    .asciz "%d"

.text
	.global convertFtoC

convertFtoC:
	push {lr}
	sub sp, sp, #4

	@ldr r0, addr_msg
	@bl printf

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

	mov r4, r0 @ store user input in r4 so that I can print the value at end of main.s

	mov r1, #5 @ multiplication factor
	sub r0, r0, #32
	mul r0, r0, r1

	mov r1, r0

	bl divMod

	add sp, sp, #4
	pop {pc}
	mov pc, lr

addr_msg:  .word message
addr_scan: .word scan
