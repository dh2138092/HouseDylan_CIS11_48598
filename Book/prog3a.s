@ prog3a.s - a simple assembler file
<<<<<<< HEAD
	.global _start
_start:
	MOV R0, #99
	MOV R7, #1
	SWI 0
=======
@ .global _start - removed, as instructed, to demonstrate error

_start:
  MOV R0, #49
  MOV R7, #1
  SWI 0
>>>>>>> 2c834d5e60267c2150e7e2d00e58f29f2c2affc5
