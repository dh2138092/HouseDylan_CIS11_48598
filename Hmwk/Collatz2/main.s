.data

message: .asciz "Type a number: "
scan_format : .asciz "%d"
message2: .asciz "Length of the Hailstone sequence for %d is %d\n"

.text
.global main
main:
    push {lr}                       /* keep lr */
    sub sp, sp, #4                  /* make room for 4 bytes in the stack */
                                    /* The stack is already 8 byte aligned */
	bl start_time

    ldr r0, address_of_message      /* first parameter of printf: &message */
    bl printf                       /* call printf */

    ldr r0, address_of_scan_format  /* first parameter of scanf: &scan_format */
    mov r1, sp                      /* second parameter of scanf: 
                                       address of the top of the stack */
    bl scanf                        /* call scanf */

    ldr r0, [sp]                    /* first parameter of collatz:
                                       the value stored (by scanf) in the top of the stack */
@    bl collatz                      /* call collatz */

@	bl collatz_branch
	bl predication_collatz

    mov r2, r0                      /* third parameter of printf: 
                                       the result of collatz */
    ldr r1, [sp]                    /* second parameter of printf:
                                       the value stored (by scanf) in the top of the stack */
    ldr r0, address_of_message2     /* first parameter of printf: &address_of_message2 */
    bl printf

	bl end_time
	bl print_time

    add sp, sp, #4
    pop {lr}
    bx lr

address_of_message: .word message
address_of_scan_format: .word scan_format
address_of_message2: .word message2
