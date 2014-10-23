.data
message1 : .asciz "\nWelcome to Dylan House's CIS-11 Midterm!\n\nEnter 1, 2, or 3 to run the correspoing application, or enter 0 to exit the midterm...\n1 - Hourly Wage Calculator\n2 - ISP Bill Calculator\n3 - Fibonacci Sequence\n"
format :.asciz "%d"

.text

menu_select:
	push {lr}

	cmp r1, #1
	beq problem1
	cmp r1, #2
	beq problem2
	cmp r1, #3
	beq problem3

	pop {lr}
	bx lr

	.global main

main:
	push {lr}
	sub sp, sp, #4

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_format
	mov r1, sp
	bl scanf

	ldr r1, [r1]

	bl menu_select

	add sp, sp, #4
	pop {lr}
	bx lr
address_of_message1 : .word message1
address_of_format   : .word format
	.global scanf
	.global printf
