/* ============ */
/* TEXT section */
/* ============ */
	.section .text
	.global main
	.type main,%function
/* Program Target */
/* use add, lsl and ldr to calculate r0 = 2 * r1 + 4 * r2 + 8 * r2 */
main:
	ldr r1,=#1	/* r1 = 1 */
	ldr r2,=#2	/* r2 = 2 */
	ldr r3,=#3	/* r3 = 3 */
	add r4, r1, r2, lsl#2 /* r4 = r1 + 4 * r2 */
	add r5, r1, r3, lsl#3 /* r5 = r1 + 8 * r3 */
	add r0, r4, r5	/* r0 = r4 + r5 = 2*r1 + 4 * r2 + 8 * r3 */ 
	nop		/* no operation */
	.end	/* program end */
