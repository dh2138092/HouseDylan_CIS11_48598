	.global _start

_start:
	mov r0, #0
	mov r1, #1
_while:
	cmp r0, r1
	beq _foo @ while r0 = r1 do _foo
	bne _end @ if r0 != r1 then go to next block of code
_foo:
	@ do stuff
	b _while
_end:
	mov r7, #1
	swi 0
	bx lr
