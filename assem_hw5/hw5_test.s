/* DATA section */
	.data
/* the array put the number, max size is 100 */
array:
	.space 404,0
/* head string of input array */
inputHead:
	.ascii "Input array:\000"
/* number format */
number:
	.ascii " %d,\000"
lastNumber:
	.ascii " %d\n\000"
/* head string of result */
resultHead:
	.ascii "Result array:\000"

/* TEXT section */
	.section .text
	.global main
	.type main,%function

main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4

	/* prepare input arrray */
	/*in example is {5, 4, 3, 200, 114514} */
	ldr r1,= array
	ldr r0,= #5 	/* {5} */
	str r0,[r1], #4
	ldr r0,= #4 	/* {5, 4} */
	str r0, [r1], #4
	ldr r0,= #3 	/* {5, 4, 3} */
	str r0, [r1], #4
	ldr r0,= #200 	/* {5, 4, 3, 200} */
	str r0, [r1], #4
	ldr r0,= #114514 /* {5, 4, 3, 200, 114514} */
	str r0, [r1]
	
	/* following APCS compliance */
	/* r0 = array size, use r7 to backup */
	ldr r0 ,= #5
	mov r7 , r0
	/* r1 = array address */
	ldr r1,= array
	/* function start */
	bl NumSort
	/* function end r0 is the result address */
	
	/* use r10 to backup address */
    mov r10, r0
	/* print input array start */
	ldr r0,= inputHead
	bl printf
	/* loop for all number */
	/* use r8 to store array size  */
	mov r8, r7
	/* use r9 to store array address */
	ldr r9,= array
loop1:
	ldr r0,= number
	ldr r1, [r9], #4
	bl printf
	sub r8, #1
	cmp r8, #1
	bgt loop1
	/* if r8 = 1, means it is last element in array */
	ldr r0,= lastNumber
	ldr r1, [r9]
	bl printf
	/* end ouput the input array */
	
	/* print result array */
	ldr r0,= resultHead
	bl printf
	/* loop for all number */
loop2:	
	ldr r0,= number
	ldr r1, [r10], #4
	bl printf
	sub r7, #1
	cmp r7, #1
	bgt loop2
	ldr r0,= lastNumber
	ldr r1, [r10]
	bl printf
	/* end the print */

	nop
	ldmea fp, {fp, sp, pc}
	.end
