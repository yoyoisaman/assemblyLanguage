/* DATA section */
/*              */
/*				*/
	.data

/* 2 x 4 matrix A contain two variable */
/*aR1 aR2 means row1 and row2 of matrix A */

/* variable aR1 */
	.type aR1, %object
	.size aR1, 16
aR1:
	.word 6
	.word 8
	.word 3
	.word 1

/* variable aR2 */
	.type aR2, %object
	.size aR2, 16
aR2:
	.word 3
	.word 5
	.word 1
	.word 5

/* 4 x 2 matrix B contain two variable */
/* bC1,bC2 means column1 and column2 of matrix B */

/* variable bC1 */
	.type bC1, %object
	.size bC1, 16
bC1:
	.word 7
	.word 2
	.word 3
	.word 4

/* variable bC2 */
	.type bC2, %object
	.size bC2, 16
bC2:
	.word 5
	.word 4
	.word 3
	.word 8

/* 2 x 2 matrix C */ 
/* variable c */
c:
	.space 16, 0

/* TEXT section */
/*  			*/

/* Program Target: compute a 4x2 matrix A multiple with a 2x4 matirx B */
/* define that aR1 means the row 1 in the matrix a, and aR1-1 means the first element of aR1 (equal A(1,1)) */
/* define that bC1 means the column 1 in matrix b, and bC1-1 means the first element of bC1 (equal B(1,1)) */

	.section .text
	.global main
	.type main,%function

main:
	/* getting aR1 */
	ldr r0, = aR1 /* r0 = aR1 */
	ldr r1, [r0], #4 /* r1 = aR1-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR1-2, r0 = r0 + 4 */
	ldr r3, [r0], #4 /* r3 = aR1-3, r0 = r0 + 4 */
	ldr r4, [r0]  /* r4 = aR1-4 */
	/* finish getting aR1 */
	
	/* compute aR1 x bC1 */
	ldr r0, = bC1  /* r0 = bC1 */
	ldr r5, [r0], #4 /* r5 = bC1-1, r0 = r0 + 4 */
	mul r6, r1, r5 /* r6 = aR1-1 x bC1-1 */
	ldr r5, [r0], #4 /* r5 = bC1-2, r0 = r0 + 4 */
	mul r7, r2, r5 /* r7 = aR1-2 x bC1-2 */
	add r8, r6, r7

	ldr r5, [r0], #4 /* r5 = bC1-3, r0 = r0 + 4 */
	mul r6, r3, r5 /* r6 = aR1-3 x bC1-3 */
	ldr r5, [r0] /* r5 = bC1-4 */
	mul r7, r4, r5 /* r7 = aR1-4 x bC1-4 */
	add r12, r6, r7
	
	add r8, r8, r12 /* r8 = aR1 x bC1 */
	/* finish compute c(1,1) in r8 */

	/* compute aR1 x bC2 */
	ldr r0, = bC2 /* r0 = bC2 */
	ldr r5, [r0], #4 /* r5 = bC2-1, r0 = r0 + 4 */
	mul r6, r1, r5 /* r6 = aR1-1 x bC2-1 */
	ldr r5, [r0], #4 /* r5 = bC2-2, r0 = r0 + 4 */
	mul r7, r2, r5 /* r7 = aR1-2 x bC2-2 */
	add r9, r6, r7 /* r9 = r6 + r7 */

	ldr r5, [r0], #4 /* r5 = bC2-3, r0 = r0 + 4 */
	mul r6, r3, r5 /* r6 = aR1-3 x bC2-3 */
	ldr r5, [r0] /* r5 = bC2-4 */
	mul r7, r4, r5 /* r7 = aR1-4 x bC2-4 */
	add r12, r6, r7
	
	add r9, r9, r12 /* r9 = aR1 x bC2 */
	/* finish compute c(1,2) in r9 */

	/* getting aR2 */
	ldr r0, = aR2 /* r0 = aR1 */
	ldr r1, [r0], #4 /* r1 = aR2-1, r0 = r0 + 4 */	
	ldr r2, [r0], #4 /* r2 = aR2-2, r0 = r0 + 4 */
	ldr r3, [r0], #4 /* r3 = aR2-3, r0 = r0 + 4 */
	ldr r4, [r0]  /* r4 = aR2-4 */
	/* finish getting aR2 */
	
	/* compute aR2 x bC1 */
	ldr r0, = bC1 /* r0 = bC1 */
	ldr r5, [r0], #4 /* r5 = bC1-1, r0 = r0 + 4 */
	mul r6, r1, r5 /* r6 = aR2-1 x bC1-1 */
	ldr r5, [r0], #4 /* r5 = bC1-2, r0 = r0 + 4 */
	mul r7, r2, r5 /* r7 = aR2-2 x bC1-2 */
	add r10, r6, r7

	ldr r5, [r0], #4 /* r5 = bC1-3, r0 = r0 + 4 */
	mul r6, r3, r5 /* r6 = aR2-3 x bC1-3 */
	ldr r5, [r0] /* r5 = bC1-4 */
	mul r7, r4, r5 /* r7 = aR2-4 x bC1-4 */
	add r12, r6, r7
	
	add r10, r10, r12 /* r10 = aR2 x bC1 */ 
	/* finish compute c(2,1) in r10 */

	/* compute aR2 x bC2 */
	ldr r0, = bC2 /* r0 = bC2 */
	ldr r5, [r0], #4 /* r5 = bC2-1, r0 = r0 + 4 */
	mul r6, r1, r5 /* r6 = aR2-1 x bC2-1 */
	ldr r5, [r0], #4 /* r5 = bC2-2, r0 = r0 + 4 */
	mul r7, r2, r5 /* r7 = aR2-2 x bC2-2 */
	add r11, r6, r7 /* r11 = r6 + r7 */

	ldr r5, [r0], #4 /* r5 = bC2-3, r0 = r0 + 4 */
	mul r6, r3, r5 /* r6 = aR2-3 x bC2-3 */
	ldr r5, [r0] /* r5 = bC2-4 */
	mul r7, r4, r5 /* r7 = aR2-4 x bC2-4 */
	add r12, r6, r7
	
	add r11, r11, r12 /* r11 = value of aR2 x bC2 */
	/* finish compute c(2,2) in r11 */

	/* put all value into c */
	ldr r0, = c /* r0 = c */
	str r8, [r0], #4 /* mem[r0] = r8, r0 = r0 + 4 */	
	str r9, [r0], #4 /* mem[r0] = r9, r0 = r0 + 4 */
	str r10, [r0], #4 /* mem[r0] = r10, r0 = r0 + 4 */
	str r11, [r0]  /* mem[r0] = r11 */
	ldr r1, = c /* r1 point to address of C's first element  */ 
	/* finish putting */

	nop

