.data
.align 4
test: .skip 16
print: .asciz "%d\n"
format: .asciz "%d"

.text
.global main

main:
	push {lr}
	sub sp, sp, #4

	mov r4, #0
	ldr r2, =test
	doWhile:
		ldr r0, =format
		ldr r1, [r2, r4, lsl #2]
		bl scanf
		str 

		ldr r0, =print
		ldr r1, [r2, r4, lsl #2]
		ldr r1, [r1]
		bl printf

		add r4, r4, #1
		cmp r4, #3
		blt doWhile

	add sp, sp, #4

	pop {pc}
	mov pc, lr
