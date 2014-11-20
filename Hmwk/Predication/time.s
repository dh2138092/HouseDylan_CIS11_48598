.data

msg: .asciz "Start: %d\nStop: %d\nDelta: %d\n\n"
start: .word 0
end:  .word 0
delta: .word 0

.text

.global start_time
start_time:
	push {lr}

	mov r0, #0
	bl time
	ldr r1, addr_of_start
	str r0, [r1]

	pop {pc}
	mov pc, lr

.global end_time
end_time:
	push {lr}

	mov r0, #0
	bl time
	ldr r1, addr_of_end
	str r0, [r1]

	pop {pc}
	mov pc, lr

.global print_time
print_time:
	push {lr}

	ldr r1, addr_of_start
	ldr r1, [r1]
	ldr r2, addr_of_end
	ldr r2, [r2]
	sub r3, r2, r1

	ldr r0, addr_of_msg
	bl printf

	pop {pc}
	mov pc, lr

addr_of_msg: .word msg
addr_of_start: .word start
addr_of_end: .word end
addr_of_delta: .word delta
