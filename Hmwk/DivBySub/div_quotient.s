        .global _start

_start:
        MOV R1, #23      @ dividend
        MOV R2, #5       @ divisor
        MOV R3, #0       @ flag to determine whether R0 is a/b or a%b
        MOV R0, #0       @ counter, a.k.a. quotient
_subtract:
        SUBS R1, R1, R2  @ subtract dividend - divisor (R1 - R2)
        ADD R0, R0, #1   @ add 1 to counter (R0++)
        BHI _subtract    @ if R1 > R1 - R2, subtract again
        BLT _adjust      @ else if R1 < R1 - R2, then minus 1 from counter
        BEQ _flag        @ else division is finished, now check our flag
_adjust:
        ADD R1, R1, R2   @ add R1 + R2 to get back our remainder
        SUB R0, R0, #1   @ decrement our counter
        B _flag          @ division is finished, now check our flag
_flag:
        CMP R3, #0       @ if R3 = 0, a/b. if R3 = 1, a%b
        BEQ _end         @ division finished, end program
        BNE _remainder   @ swap R0 with the value of the remainder
_remainder:
        MOV R0, R1       @ put the remainder into R0
        B _end           @ end the program
_end:
        MOV R7, #1       @ exit through syscall
        SWI 0
        BX LR
