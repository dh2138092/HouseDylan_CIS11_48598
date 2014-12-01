	.text
	.global main
	.func main
main:
	sub, sp, sp, #16

	ldr r1, =factor
	vldr s14, [r1]
	
