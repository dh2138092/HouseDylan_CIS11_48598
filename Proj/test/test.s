.data
.align 4
test: .skip 16
print: .asciz "%d\n"
format: .asciz "%d"

.text
.global main

main:
	push {lr}

	@ r0 <- format
	mov r4, #0
	ldr r5, =test
	doWhile:
		sub sp, sp, #4

		ldr r0, =format
		mov r1, sp
		bl scanf

		ldr r0, [sp]
		str r0, [r5, r4, lsl #2]

		ldr r1, [r5, r4, lsl #2]
		ldr r0, =print
		bl printf

		add sp, sp, #4

		add r4, r4, #1
		cmp r4, #3
		blt doWhile

	pop {pc}
	mov pc, lr
