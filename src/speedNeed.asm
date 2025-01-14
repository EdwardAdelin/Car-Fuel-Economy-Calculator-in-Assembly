; speedNeed.ASM
extern printf
extern inputNum
extern instrPrintSpeed

section .data
section .bss
section .text
	global speedNeed

speedNeed:	
	section .data
		format:		db		"-> Viteza necesara in Km/H: %f Km/H", 10, 0
		hour: dq 60.00
	section .bss
		result:		resq	1
	section .text
		push rbp
		mov rbp, rsp

		call instrPrintSpeed ;instructiunile  pt introducerea datelor

		call inputNum ; luam distanta in km

		; stocare xmm2 pt printing
		movsd xmm2, xmm1
		;mulsd xmm2, [hunder]	;inmultiti cu 100

		call inputNum	; luam  timpul in minute
        divsd xmm1, [hour] ;transformam minutele in nr de ore
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