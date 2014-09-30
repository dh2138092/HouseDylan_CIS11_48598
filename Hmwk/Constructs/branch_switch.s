	.global _start:
_start:
	mov r0, #0 @ var x
	mov r1, #1
	mov r2, #2
	mov r3, #3
	mov r4, #4
_switch:
	cmp r0, r1
	beq _case1
	cmp r0, r2
	beq _case2
	cmp r0, r3
	beq _case3
	cmp r0, r4
	beq _case4
	b _default
_case1:
	@ r0 = r1
	@ do stuff
	b _end
_case2:
	@ r0 = r2
	@ do stuff
	b _end
_case3:
	@ r0 = r3
	@ do stuff
	b _end
_case4:
	@ r0 = r4
	@ do stuff
	b _end
_default:
	@ r0 did not match any case
	@ do stuff
	b _end
_end:
	mov r7, #1
	swi 0
	bx lr
