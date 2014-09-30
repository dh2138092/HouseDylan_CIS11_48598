	.global _start

_start:
	mov r0, #0
	mov r1, #1
_foo:
	@ do stuff
_while:
	cmp r0, r1
	beq _foo
	bne _end
_end:
	mov r7, #1
	swi 0
	bx lr
