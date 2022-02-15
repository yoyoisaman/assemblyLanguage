/* DATA section */
	.data
/* The array put the answer */  
ans:
	.space 404, 0

/* TEXT section */
	.section .text
	.global NumSort
	.type NumSort,%function

/* Sorting */
/* 1. Copy the array to the ansArray */ 
/* 2. Sorting all array, if there is swap happened, do sorting again */
/* 3. Until there is no swap happened in this loop , means that the array is sorted */
/* 4. Copy the address to r10, end the function */
NumSort:
	/* function start */
	stmfd sp!,{r0-r9, fp, ip, lr} /* save the register */ 
	
	/* copy the first array to ansArray */
	mov r0, r9	/* r0 is the count of array */
	ldr r1,= ans 
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
	ldr r0,= ans
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
	ldr r10,= ans		/* put result address into r10 */
	/* sort end */
	ldmfd sp!, {r0-r9, fp, ip, pc}
	.end	
