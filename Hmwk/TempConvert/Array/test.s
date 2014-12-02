/* 
	How to pass large amounts of data into a function, 
	i.e. an Array.  Of course, Pass by Reference!!!
	
	Think In Geek Article 17!!!
*/
.data
 
.align 4
big_array :
.skip 1028
 
.align 4
message: .asciz "Item at position %d has value %d\n"
 
.text

init_array:
    /* Parameters: 
           r0  Number of items
           r1  Address of the array
    */
    push {r5, lr}
 
    /* We have passed all the data by reference */
 
    /* r5 will be incremented from 0 to the end */
    mov r5, #0      /* r5 ? 0 */
 
    b .Lcheck_loop_array_sum
    .Lloop_array_sum:
	  str r5, [r1, r5, LSL #2]   /*Inititialize the array 0..255 */
      add r5, r5, #1             /* r5 ? r5 + 1 */
    .Lcheck_loop_array_sum:
      cmp r5, r0                 /* r5 - r0 and update cpsr */
      bne .Lloop_array_sum       /* if r5 != r0 go to .Lloop_array_sum */
 
    pop {r5, lr}
 
    bx lr
 
double_array : 
    /* Parameters: 
           r0  Number of items
           r1  Address of the array
    */
    push {r4, r5, r6, lr}
 
    mov r4, #0      /* r4 ? 0 */
 
    b .Lcheck_loop_array_double
    .Lloop_array_double:
      ldr r5, [r1, r4, LSL #2]   /* r5 ? *(r1 + r4 * 4) */
      mov r5, r5, LSL #1         /* r5 ? r5 * 2 */
      str r5, [r1, r4, LSL #2]   /* *(r1 + r4 * 4) ? r5 */
      add r4, r4, #1             /* r4 ? r4 + 1 */
    .Lcheck_loop_array_double:
      cmp r4, r0                 /* r4 - r0 and update cpsr */
      bne .Lloop_array_double    /* if r4 != r0 go to .Lloop_array_double */
 
    pop {r4, r5, r6, lr}
 
    bx lr
 
print_each_item:
    push {r4, r5, r6, r7, r8, lr} /* r8 is unused */
 
    mov r4, #0      /* r4 ? 0 */
    mov r6, r0      /* r6 ? r0. Keep r0 because we will overwrite it */
    mov r7, r1      /* r7 ? r1. Keep r1 because we will overwrite it */
 
 
    b .Lcheck_loop_print_items
    .Lloop_print_items:
      ldr r5, [r7, r4, LSL #2]   /* r5 ? *(r7 + r4 * 4) */
 
      /* Prepare the call to printf */
      ldr r0, address_of_message /* first parameter of the call to printf below */
      mov r1, r4      /* second parameter: item position */
      mov r2, r5      /* third parameter: item value */
      bl printf       /* call printf */
 
      str r5, [r7, r4, LSL #2]   /* *(r7 + r4 * 4) ? r5 */
      add r4, r4, #1             /* r4 ? r4 + 1 */
    .Lcheck_loop_print_items:
      cmp r4, r6                 /* r4 - r6 and update cpsr */
      bne .Lloop_print_items       /* if r4 != r6 goto .Lloop_print_items */
 
    pop {r4, r5, r6, r7, r8, lr}
    bx lr
 
 .global main
main:
    push {r4, lr}
    /* we will not use r4 but we need to keep the function 8-byte aligned */
	
	/* first call print_each_item */
    mov r0, #256                   /* first_parameter: number of items */
    ldr r1, address_of_big_array   /* second parameter: address of the array */
    bl init_array                  /* call to print_each_item */
 
    /* first call print_each_item */
    mov r0, #256                   /* first_parameter: number of items */
    ldr r1, address_of_big_array   /* second parameter: address of the array */
    bl print_each_item             /* call to print_each_item */
 
    /* call to double_array */
    mov r0, #256                   /* first_parameter: number of items */
    ldr r1, address_of_big_array   /* second parameter: address of the array */
    bl double_array               /* call to double_array */
 
    /* second call print_each_item */
    mov r0, #256                   /* first_parameter: number of items */
    ldr r1, address_of_big_array   /* second parameter: address of the array */
    bl print_each_item             /* call to print_each_item */
 
    pop {r4, lr}
    bx lr
 
address_of_big_array : .word big_array
address_of_message : .word message