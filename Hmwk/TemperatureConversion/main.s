.data

message: .asciz "\n%d F is ~%d C.\n\n"

.text

	.global main

main:
	push {lr}

	bl convertFtoC

	mov r1, r4            @ r1 is the user's input in fahrenheit
	mov r2, r0            @ r0 is the user's input converted to celsius
	ldr r0, addr_msg
	bl printf

	pop {pc}
	mov pc, lr

addr_msg: .word message
