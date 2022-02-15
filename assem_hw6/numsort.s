/* DATA section */
	.data

/* TEXT section */
	.section .text
	.global NumSort
	.type NumSort,%function

/* Sorting */
/* 1. Copy the array to the ansArray */ 
/* 2. Sorting all array, if there is swap happened, do sorting again */
/* 3. Until there is no swap happened in this loop , means that the array is sorted */
/* 4. Copy the address to r0, end the function */
NumSort:
	/* function start */
	mov ip,sp
	stmfd sp!,{r4-r10, fp, ip, lr, pc} 
	sub fp,ip,#4

	/* malloc the space by array size */
	/* use r9 save the r0 value, the array size */
	mov r9, r0
	/* use r10 save the r1 value, the array address */
	mov r10, r1
	/* r0 = r0 * 4, 4 is the interger size */
	mov r0, r0, lsl #2
	/* start malloc function */
	bl malloc
	/* end the function, r0 is the address of ans */
	
	/* save the ans address in r1 and r8 to backup */
	mov r1, r0
	mov r8, r0
	/* copy the first array to ansArray */
	mov r0, r9	/* r0 is the count of array */
copying:
	cmp r0, #0 /* r0 = 0 means finish copy */
	beq loopEnd /* finish copy */
	ldr r2, [r10], #4 /* load number from array */
	str r2, [r1], #4 /* store into ans */
	subgt r0, r0, #1 /* r0= r0 - 1 */
	bgt copying 
	/* end copy */
loopEnd:
	/* Sort start */
	/* r0 is the address of array */
	mov r0, r8
	/* r1 is the size of array */
	mov r1, r9
nextLoop:
	mov r2, #0	/* r2 = current number index */
	mov r3, #0	/* r3 = is there any swap?  */
loopStart:
	add r4, r2,#1 /* r4= next number index */
	cmp r4, r1	  /* check is that the last element */
	bge check
	ldr r5, [r0, r2, lsl #2] /* r5 = current number value */
	ldr r6, [r0, r4, lsl #2] /* r6 = next number value */
	cmp r5, r6 /* compare */
	strgt r5, [r0, r4, lsl #2] /* if r5 > r6 they swap */
	strgt r6, [r0, r2, lsl #2] /* swap */
	addgt r3, r3, #1 /* there is swap, so r3 + 1 */
	mov r2, r4		 /* go to next number */
	B loopStart		 /* loop again */
check:				/* if there is no swap in this loop means we got the result */
	cmp r3, #0		/* r3 > 0 means there is swap in this loop */
	bgt nextLoop 	/* the array is still not sorted yet, so loop again */
finish:
	mov r0, r8		/* put result address back to r0 */
	/* sort end */
	nop
	ldmea fp, {r4-r10, fp, sp, pc}
	.end	
