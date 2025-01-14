; avrageFuel.asm
extern printf
extern inputNum
extern instrPrintAvg

section .data
section .bss
section .text
	global avrageFuel

avrageFuel:
	section .data
		format:		db		"-> Consum mediu: %f", 10, 0
		hunder: dq 100.00
	section .bss
		result:		resq	1
	section .text
		push rbp
		mov rbp, rsp

		call instrPrintAvg ;instructiunile  pt introducerea datelor

		call inputNum ; luam L consumati

		; stocare xmm2 pt printing
		movsd xmm2, xmm1
		mulsd xmm2, [hunder]	;inmultiti cu 100

		call inputNum	; luam  km condusi
		divsd xmm2, xmm1

		; rezultatul impartirii il mutam pentru afisare
		movsd xmm0, xmm2

		mov rax, 1
		mov rdi, format
		call printf ;standard rdi print prin linker

		; store the result back in the xmm0
		movsd xmm0, [result]

		mov rsp, rbp
		pop rbp
		ret