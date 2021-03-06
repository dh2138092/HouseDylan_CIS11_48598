.data

message: .asciz "Type a number: "
scan_format : .asciz "%d"
message2: .asciz "Length of the Hailstone sequence for %d is %d\n\n"

.text

collatz:
    /* r0 contains the first argument */
    push {r4}
    sub sp, sp, #4  /* Make sure the stack is 8 byte aligned */
    mov r4, r0
    mov r3, #4194304
  collatz_repeat:
    mov r1, r4                 /* r1 ← r0 */
    mov r0, #0                 /* r0 ← 0 */
  collatz_loop:
    cmp r1, #1                 /* compare r1 and 1 */
    beq collatz_end           /* if r1 == 1 branch to collatz2_end */
    and r2, r1, #1             /* r2 ← r1 & 1 */
    cmp r2, #0                 /* compare r2 and 0 */
    moveq r1, r1, ASR #1       /* if r2 == 0, r1 ← r1 >> 1. This is r1 ← r1/2 */
    addne r1, r1, r1, LSL #1   /* if r2 != 0, r1 ← r1 + (r1 << 1). This is r1 ← 3*r1 */
    addne r1, r1, #1           /* if r2 != 0, r1 ← r1 + 1. */
  collatz_end_loop:
    add r0, r0, #1             /* r0 ← r0 + 1 */
    b collatz_loop            /* branch back to collatz2_loop */
  collatz_end:
    sub r3, r3, #1
    cmp r3, #0
    bne collatz_repeat
    add sp, sp, #4             /* Restore the stack */
    pop {r4}
    bx lr

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
@	bl start_time
    bl collatz                      /* call collatz */
@	bl end_time

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
