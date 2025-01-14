; division.asm
extern printf
extern inputNum

section .data
section .bss
section .text
	global division

division:
	section .data
		format:		db		"-> %f / %f = %f", 10, 0
	section .bss
		result:		resq	1
	section .text
		push rbp
		mov rbp, rsp

		call inputNum

		; stocare xmm2 pt printing
		movsd xmm2, xmm0
		divsd xmm2, xmm1

		; rezultatul impartirii il mutam pentru afisare
		movsd [result], xmm2

		mov rax, 3
		mov rdi, format
		call printf ;standard rdi print prin linker

		; store the result back in the xmm0
		movsd xmm0, [result]

		mov rsp, rbp
		pop rbp
		ret