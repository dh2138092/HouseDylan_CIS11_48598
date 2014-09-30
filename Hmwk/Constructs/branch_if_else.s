	.global _start

_start:
	mov r0, #0 @ var x
	mov r1, #1 @ var y
	blt _true
	bge _false
_true:
	@ x < y
	b _end
_false:
	@ x >= y
	b _end
_end:
	mov r7, #1 
	swi 0
	bx lr
