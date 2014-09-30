	.global _start:

_start:
	mov r2, #22222
	mov r3, #5
	mov r4, #0
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #10
	mov r9, #0
	mov r0, #0
	mov r1, r2
_divMod:
	cmp r1, r3
	bge _scale
	blt _checkFlag
_checkScale:
	cmp r6, #1
	bgt _scale
	@ ble ...
_scale:
	mov r6, #1
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r1, r9
	bgt _shift
_shift:
	mul r6, r6, r8
	mul r7, r3, r6
	mul r9, r7, r8
	cmp r1, r9
	bgt _shift
	@ ble
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
