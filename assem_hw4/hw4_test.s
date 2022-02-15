/* DATA section */
	.data
/* the array put the number, max size is 100 */
array:
	.space 404,0

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
	
	/* r9 = array size */
	ldr r9 ,= #5
	/* r10 = array address */
	ldr r10,= array
	/* function start */
	bl NumSort
	/* function end */
	nop
	ldmea fp, {fp, sp, pc}
	.end
