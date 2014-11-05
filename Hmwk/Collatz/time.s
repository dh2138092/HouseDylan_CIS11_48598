.data

@msg: .asciz "Start: %d\nStop: %d\nDelta: %d\n\n"
msg: .asciz "The time: %d\n\n"

.text

.global main
main:
	push {lr}

@	mov r0, #0
	bl clock
@	mov r1, r0

@	mov r0, #0
@	bl time
@	mov r2, r0

@	sub r3, r2, r1

@	ldr r0, addr_of_msg
@	bl printf

	pop {pc}
	mov pc, lr

addr_of_msg: .word msg
