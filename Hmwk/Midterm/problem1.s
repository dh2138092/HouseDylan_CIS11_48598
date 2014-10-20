.data

message1 : .asciz "Enter 2 numbers <# of hours worked> and <hourly wage rate> for gross pay calculation: \n"
format : .asciz "%d %d"
message2 : .asciz "The gross pay for %d hours worked at $%d per hour is $%d\n"

.text
calculate:
	push {lr}
	/* r1 is numOfHours */
	/* r2 is hourlyRate */
	mov r3, #0                     /* r3 is  gross pay */
	cmp r1, #40
	ble if_le_40
		if_le_40
			cmp r1, #40
			ble if_le_20
				mul r3, r1, r2
			bgt if_gt_20    /**************** BOOKMARK **********************/

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

	add r1, sp, #4                  /* Place sp+4 -> r1 */
	ldr r1, [r1]                    /* Load the integer a read by scanf into r1 */
	ldr r2, [sp]                    /* Load the integer b read by scanf into r2 */
		bl calculate

	mov r3, #0                      /* TEST */
	add r3, r1, r2                  /* TEST */

	ldr r0, address_of_message2
	bl printf

	add sp, sp, #8                  /* Discard the integer read by scanf */
	pop {lr}                        /* Pop the top of the stack and put it into lr */
	bx lr                           /* Exit main */



address_of_message1 : .word message1
address_of_format : .word format
address_of_message2 : .word message2

	.global printf
	.global scanf
