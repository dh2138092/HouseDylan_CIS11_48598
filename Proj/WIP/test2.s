.data
.align 4
test: .skip 16
print: .asciz "%d %d\n"
format: .asciz "%d"

.text
.global main

main:
	push {lr}

	mov r4, #0
	mov r5, #0
	mov r6, #0
	while:
		mov r0, #1
		mov r1, #1
		cmp r0, r1
		addeq r5, #5
		addne r6, #10

		ldr r0, =print
		mov r1, r5
		mov r2, r6
		bl printf

		add r4, r4, #1
		cmp r4, #3
		blt while

	pop {pc}
	mov pc, lr
