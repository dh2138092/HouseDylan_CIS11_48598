	.data

.balign 4
message1: .asciz "Type a dividend: "

.balign 4
message2: .asciz "Type a divisor: "

.balign 4
message3: .asciz "The quotient is  %d / %d = %d\n"

.balign 4
message4: .asiz "The remainder is %d % %d = %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
divisor_read: .word 0

.balign 4
return: .word 0

	.text

	.global main

main:
	MOV R1, #23      @ dividend
	MOV R2, #5       @ divisor
	MOV R3, #0	 @ flag to determine whether R0 is a/b or a%b
	MOV R0, #0       @ counter, a.k.a. quotient
_subtract:
	SUBS R1, R1, R2  @ subtract dividend - divisor (R1 - R2)
	ADD R0, R0, #1   @ add 1 to counter (R0++)
	BHI _subtract    @ if R1 > R1 - R2, subtract again
	BLT _adjust      @ else if R1 < R1 - R2, then minus 1 from counter
	BEQ _flag        @ else division is finished, now check our flag
_adjust:
	ADD R1, R1, R2	 @ add R1 + R2 to get back our remainder
	SUB R0, R0, #1   @ decrement our counter
	B _flag          @ division is finished, now check our flag
_flag:
	CMP R3, #0       @ if R3 = 0, a/b. if R3 = 1, a%b
	BEQ _end	 @ division finished, end program
	BNE _remainder	 @ swap R0 with the value of the remainder
_remainder:
	MOV R0, R1       @ put the remainder into R0
	B _end		 @ end the program
_end:
	MOV R7, #1       @ exit through syscall
	SWI 0
	BX LR
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_message4: .word message4
address_of_scan_pattern: .word scan_pattern
address_of_return: .word return

/* External */
.global printf
.global scanf
