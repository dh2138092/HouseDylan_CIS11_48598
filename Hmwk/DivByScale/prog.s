	.global _start

_start:
	mov r2, #20  @ a
	mov r3, #5   @ b
	mov r4, #0   @ flag for a/b or a%b
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #10
	mov r9, #0
	mov r0, #0   @ a/b
	mov r1, r2   @ a%b
_divMod:                @ divMod()
	cmp r1, r3      @ is division even necessary?
	bge _scale      @ yes
	blt _checkFlag  @ no
_checkScale:
	cmp r6, #1
	bgt _scale
	ble _checkFlag
_scale:                 @ scale()
	mov r6, #1      @ r6 is our scale
	mul r7, r3, r6  @ r7 is our subtraction factor
	mul r9, r7, r8  @ r9 is our next subtraction factor to test
	cmp r1, r9
	bgt _shift      @ if r1 > r9, expand our scale & subtraction factors
	ble _adjust     @ else adjust 10 counter and dividend
_adjust:
	add r0, r0, r6
	subs r1, r1, r7
	bge _adjust
	blt _checkScale
_shift:
	mul r6, r6, r8
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r1, r9
	bgt _shift
	ble _adjust
_checkFlag:
	cmp r4, #0
	beq _exit
	bne _swap
_swap:
	mov r5, r0
	mov r0, r1
	mov r1, r5
_exit:
	mov r7, #1
	swi 0
	bx lr
