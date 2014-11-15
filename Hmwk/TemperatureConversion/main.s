.data

message: .asciz "\n%d F is %d C.\n\n"

.text

	.global main

main:
	push {lr}

	mov r0, #0
	mov r1, #0
	mov r2, #9
	mov r3, #0
	mov r4, #0

	bl convertFtoC

	mov r1, r4
	mov r2, r0
	ldr r0, addr_msg
	bl printf

	pop {pc}
	mov pc, lr

addr_msg: .word message
