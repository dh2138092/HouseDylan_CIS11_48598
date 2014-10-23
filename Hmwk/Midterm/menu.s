.data
message1 : .asciz "\nWelcome to Dylan House's CIS-11 Midterm!\n\n
                    Enter 1, 2, or 3 to run the correspoing application,
		    or enter 0 to exit the midterm...\n
                    1 - Hourly Wage Calculator\n
                    2 - ISP Bill Calculator\n
                    3 - Fibonacci Sequence\n"

.text

	.global main

main:
	push {lr}
	sub sp, sp, #4

	ldr r0, address_of_message1
	bl printf

	add sp, sp, #4
	pop {lr}
	bx lr
address_of_message1 : .word message1

	.global scanf
	.global printf
