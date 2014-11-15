.text

.global predication_collatz
predication_collatz:
    /* r0 contains the first argument */
    push {r4}

    sub sp, sp, #4  /* Make sure the stack is 8 byte aligned */
    mov r4, r0
    mov r3, #4194304
	predication_repeat:
    mov r1, r4                 /* r1 ← r0 */
    mov r0, #0                 /* r0 ← 0 */
	predication_loop:
    cmp r1, #1                 /* compare r1 and 1 */
	beq predication_end           /* if r1 == 1 branch to collatz2_end */
    and r2, r1, #1             /* r2 ← r1 & 1 */
    cmp r2, #0                 /* compare r2 and 0 */
    moveq r1, r1, ASR #1       /* if r2 == 0, r1 ← r1 >> 1. This is r1 ← r1/2 */
    addne r1, r1, r1, LSL #1   /* if r2 != 0, r1 ← r1 + (r1 << 1). This is r1 ← 3*r1 */
    addne r1, r1, #1           /* if r2 != 0, r1 ← r1 + 1. */
	predication_end_loop:
    add r0, r0, #1             /* r0 ← r0 + 1 */
	b predication_loop            /* branch back to collatz2_loop */
	predication_end:
    sub r3, r3, #1
    cmp r3, #0
	bne predication_repeat
    add sp, sp, #4             /* Restore the stack */

    pop {r4}
    bx lr
