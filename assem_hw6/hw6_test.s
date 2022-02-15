/* some parameter for swi */
.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456
/* DATA section */
	.data
/* the array put the number, max size is 100 */
array:
	.space 404,0
/* the array put the string */
string:
	.space 400,0
/* number format */
number:
	.ascii "%d, \000"
/* last number */
lastNumber:
	.ascii "%d\000"
/* filename */
filename:
	.ascii "result.txt\000"

/* TEXT section */
	.section .text
	.global main
	.type main,%function
/* ues in openfile */
.open_param:
	.word filename
	.word 0x4
	.word 0x8
/* use in write file */
.write_param:
	.space 4 /* file descriptor */
	.space 4 /* address of the string */
	.space 4 /* length of the string */
/* use in close file */
.close_param:
	.space 4

main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4
	
	/* prepare input arrray */
	/*in example is {5, 4, 3, 2, 1} */
	ldr r1,= array
	ldr r0,= #5 	/* {5} */
	str r0,[r1], #4
	ldr r0,= #4 	/* {5, 4} */
	str r0, [r1], #4
	ldr r0,= #3 	/* {5, 4, 3} */
	str r0, [r1], #4
	ldr r0,= #2 	/* {5, 4, 3, 2} */
	str r0, [r1], #4
	ldr r0,= #1 /* {5, 4, 3, 2, 1} */
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
	
	/* transfer all number in result array to string by sprintf() */
	/* loop for all number */
	ldr r0,= string
	/* use r5 to count the address of string array */
	ldr r5,= string
loop:
	ldr r1 ,= number
	ldr r2, [r10], #4
	bl sprintf
	mov r0, r5
	bl strlen /* count the lens of the number including comma and space */
	mov r6,r0
	add r5, r6 /* a number lens */
	mov r0,r5
	sub r7, #1
	cmp r7, #1
	bgt loop
	/* last number no comma */
	mov r0,r5
	ldr r1,= lastNumber
	ldr r2, [r10]
	bl sprintf
	/* end the sprintf */

	/* file open */
	mov r0,#SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r2,r0

	/* write file */
	adr r1, .write_param
	str r2, [r1, #0] /* store file descriptor */
	ldr r3,=string
	str r3, [r1, #4] /* store the address of string */
	mov r3, #13
	str r3, [r1, #8] /* store the length of the string */
	
	mov r0, #SWI_Write
	swi AngelSWI

	/* close the file */
	adr r1, .close_param
	str r2, [r1,#0]
	mov r0, #SWI_Close
	swi AngelSWI

	nop
	ldmea fp, {fp, sp, pc}
	.end
