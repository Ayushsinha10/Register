	.file	"Factorial.c"
	.text
	.type	factorial, @function
factorial:
.LFB0:
	.cfi_startproc
	pushq	%rbp  # Pushes the value of the base register to stack thereby setting up a new stack frame
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp # Copies the value of rsp register to the rbp register (rsp represntes the top of the stack while rbp is a stable reference point)
	.cfi_def_cfa_register 6
	subq	$16, %rsp # subtracts 16 from the stack pointer rsp. This allocates new space on the stack effectively adding 16 bytes of space for storage of information.
	movq	%rdi, -8(%rbp) # The first argument register rdi is passed to and stored on the stack in relation to the rbp register at 8 bytes before. 
	movq	%rsi, -16(%rbp) # A second argument register rsi is passed and stored on the stack in relation to the rbp register at 16 bytes before.
	cmpq	$1, -8(%rbp) # A comparison between the value stored in memory 8 bytes before the rbp register and the constant one 
	ja	.L2 # If the above comaprison shows its greater than 1 then code jumps it L2 section otherwise the follwing is run
	movl	$7, %edi # Moves the value 7 to the 32 bit edi register
	call	printStackFrames # Invokes and runs code for the printStackFrames function.
	movq	-16(%rbp), %rax # Moves the value found 16 bytes before the rbp register to the rax register
	jmp	.L3 # Jumps to L3 section of code
.L2:
	movq	-8(%rbp), %rax # Moves the value found in memory 8 bytes before the rbp register to the rax register
	imulq	-16(%rbp), %rax # Multiplies the value found in memory 16 bytes before rbp register with the value found the rax register.
	movq	-8(%rbp), %rdx # Moves the value found in memory 8 bytes before the rbp register to the rdx register
	subq	$1, %rdx # Subtracts the constant 1 from the value stored in the rdx register
	movq	%rax, %rsi # Moves the value of the rax register to the rsi register in preperation for a function call
	movq	%rdx, %rdi # Moves the value of the rdx register to the rdi register in preperation for a function call
	call	factorial # Executes code fo the factorial function using the values in the rsi and rdi register as arguments.
.L3:
	leave # Stack is restored to its original state 
	.cfi_def_cfa 7, 8
	ret # Jumps to return address from stack and deallocates stack space.
	.cfi_endproc
.LFE0:
	.size	factorial, .-factorial
	.section	.rodata
	.align 8
.LC0:
	.string	"executeFactorial: basePointer = %lx\n"
	.align 8
.LC1:
	.string	"executeFactorial: returnAddress = %lx\n"
	.align 8
.LC2:
	.string	"executeFactorial: about to call factorial which should print the stack\n"
	.align 8
.LC3:
	.string	"executeFactorial: factorial(%lu) = %lu\n"
	.text
	.globl	executeFactorial
	.type	executeFactorial, @function
executeFactorial:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	$0, %eax
	call	getBasePointer
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	call	getReturnAddress
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC2, %edi
	call	puts
	movq	$0, -24(%rbp)
	movq	$6, -32(%rbp)
	movq	$1, -40(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factorial
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	executeFactorial, .-executeFactorial
	.ident	"GCC: (GNU) 11.4.1 20230605 (Red Hat 11.4.1-2)"
	.section	.note.GNU-stack,"",@progbits
