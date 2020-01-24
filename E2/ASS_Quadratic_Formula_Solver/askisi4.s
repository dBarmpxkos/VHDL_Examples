/* This program solves y = 3x^2 + 5*x - 19 */
.data
constx: .word 0x00000004
consty: .word 0x00000000

.text

.global _start
_start:	movia r4, constx	# get constx memory address
		ldw r5,(r4)			# load constx to r5
		ldw r6,(r4)			# 			 and r6
		mov r7, r0			# move contents of r0 to r7 (r7 = 0)
		addi r8,r0,0x1		# r8 = r0 + 1 -> r8 = 1
		
		/* constx^2 */
loop:   add r7,r7,r5		# r7 = r7 + r5. Increase r7(0) by constx value at each iteration
		sub r6,r6,r8		# r6 = r6 - r8. Decrease r6(constx) by one at each iteration
		bne r6,r0, loop		# if r6 is not equal to r0, go to label loop again
		/* constx^2 */
				
		mov r6,r7			# move contents of r7 to r6. At this point, r7 holds a value of constx^2
		roli r7,r7,0x1		# rotate left r7 by one bit and store the value to r7. r7 = constx^2 * 2
		add r7,r7,r6		# r7 = constx^2 * 2 + constx^2 = 3 * constx^2
		mov r6,r7			# r6 = r7 = 3 * constx^2 				(a)
		ldw r7,(r4)			# load r7 with constx 
		roli r7,r7,0x1		# rotate left r7 by one bit and store the value to r7. r7 = constx * 2
		roli r7,r7,0x1		# r7 = constx * 4
		ldw r10,(r4)		# load r10 with constx. r4 still points to constx
		add r7,r7,r10		# r7 = constx * 4 + constx = 5 * constx (b)
		addi r10,r0,0x13	# r10 = 0x13 							(c)
		sub r7,r7,r10		# r7 = 5 * constx - 0x13
		add r7,r7,r6		# r7 = 5 * constx - 0x13 + 3 * constx^2
		addi r4,r4,0x4		# move pointer four positions, pointing from constx initial memory address
		stw r7,0(r4)		# store the value 
		