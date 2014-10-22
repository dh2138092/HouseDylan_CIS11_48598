.data
message1 : .asciz "Please enter <# of hours worked> and <hourly pay>:\n"
format   : .asciz "%d %d"
test_message : .asciz "You entered %d and %d\n"
message2 : .asciz "The gross pay for %d hours worked at $%d per hour is $%d\n"

.text
calculate:
	push {lr}
			               /* r1 is numOfHours */
	                               /* r2 is hourlyRate */
	mov r3, #0                     /* r3 is grossPay */
	mov r4, #2                     /* r4 is scaleFactor for double-time */
	mov r5, #3                     /* r5 is scaleFactor for triple-time */
	mov r6, #0                     /* r6 is (hourlyRate * scacleFactor) */

	cmp r1, #40                    /* Compare numOfHours to 40 */
	ble if_le_40                   /* if (numOfHours <= 40) */
	bgt if_gt_40                   /* else (numOfHours > 40) */
		if_le_40:
			cmp r1, #20   /* Compare numOfHours to 20 */
			ble if_le_20  /* if (numOfHours <= 20) */
			bgt if_gt_20  /* else (numOfHours > 20) */
				if_le_20:
					mul r3, r1, r2   /* grossPay = numOfHours * hourlyRate */
				if_gt_20:
					mul r6, r4, r2  /* hourlyRate = hourlyRate * 2 */
					mul r3, r1, r6  /* grossPay = numOfHours * hourlyRate */
		if_gt_40:
			mul r6, r5, r2                  /* hourlyRate = hourlyRate * 3 */
			mul r3, r1, r6                  /* grossPa = numfHours * hourlyRate */
	pop {lr}
	bx lr

	.global main

main:
	push {lr}                       /* Push lr onto the top of the stack */
        sub sp, sp, #8                  /* Make room for two 4 byte integers in the stack */

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_format       /* Set format as the first parameter of scanf */
	mov r2, sp                      /* Set variable of the stack as b */
	add r1, r2, #4                  /* and second value as a of scanf */
	bl scanf
@@@@@@@@@@@@@@@@@@@
	add r1, sp, #4                  /* Place sp+4 -> r1 */
	ldr r1, [r1]                    /* Load the integer a read by scanf into r1 */
	ldr r2, [sp]                    /* Load the integer b read by scanf into r2 */

	ldr r0, address_of_test_message
	bl printf
@@@@@@@@@@@@@@@@@@@
	add r1, sp, #4
	ldr r1, [r1]
	ldr r2, [sp]
	bl calculate

	ldr r0, address_of_message2
	bl printf

	add sp, sp, #8                  /* Discard the integer read by scanf */
	pop {lr}                        /* Pop the top of the stack and put it into lr */
	bx lr                           /* Exit main */
address_of_message1 : .word message1
address_of_format   : .word format
address_of_test_message : .word test_message
address_of_message2 : .word message2

	.global printf
	.global scanf
