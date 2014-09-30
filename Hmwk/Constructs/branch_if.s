	.global _start
_start:
	mov r0, #0 @ var x
	mov r1, #1 @ var y
	cmp r0, r1
	blt _true
_true:
	@ x < y
	b _end
_end:
	mov r7, #1
	swi 0
	bx lr
