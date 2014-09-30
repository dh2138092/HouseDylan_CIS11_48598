	.global _start
_start:
	mov r0, #1 @ i = 1
	mov r1, #5 @ n = 5
_loop:
	cmp r0, r1
	beq _end @ beq or some other required condition
_foo:
	@ do stuff
_increment:
	add r0, r0, #1
	b _loop
_end:
	mov r7, #1
	swi 0
	bx lr
