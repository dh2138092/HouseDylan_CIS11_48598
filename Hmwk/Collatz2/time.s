.data

msg: .asciz "Start: %d\nStop: %d\nDelta: %d\n\n"
@msg: .asciz "The time: %d\n\n"
start: .word 0
@stop:  .word 0
@delta: .word 0

.text

.global start_time
start_time:
	push {lr}

	mov r0, #0
	bl time
	ldr r2, addr_of_start
	str r0, [r2]

	pop {pc}
	mov pc, lr

.global end_time
end_time:
	push {lr}

	mov r0, #0
	bl time
	mov r3, r0
	ldr r2, addr_of_start
	ldr r2, [r2]

	sub r4, r3, r2

	pop {pc}
	mov pc, lr

.global print_time
print_time:
	push {lr}

	ldr r0, addr_of_msg
	mov r1, r2
	mov r2, r3
	mov r3, r4
	bl printf

	pop {pc}
	mov pc, lr

addr_of_msg: .word msg
addr_of_start: .word start
