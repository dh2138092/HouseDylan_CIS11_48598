	.global _start

_start:
	mov r2, #21    @ a = 111
	mov r3, #5      @ b = 5
	mov r4, #1      @ flag for a/b or a%b
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #10
	mov r9, #0
	mov r0, #0      @ value of a/b
	mov r1, r2      @ value of a%b
_divMod:                @ divMod()
	cmp r1, r3      @ is division even necessary?
	bge _scale      @ yes   do...
	blt _checkFlag  @ no
_checkScale:
	cmp r6, #1
	bgt _scale
	ble _checkFlag
_scale:                 @ scale()
	mov r6, #1
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r1, r9	@ while r1>r9...
	bgt _shift      @ ...do this...
	ble _adjust     @ ...else
_adjust:
	add r0, r0, r6
	sub r1, r1, r7
	cmp r1, r7
	bge _adjust
	blt _checkScale
_shift:
	mul r6, r6, r8
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r1, r9	@ while r1>r9...
	bgt _shift	@ ...do this...
	ble _adjust	@ ...else
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
