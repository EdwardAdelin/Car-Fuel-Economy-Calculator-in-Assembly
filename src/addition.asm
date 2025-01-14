; addition.asm
extern printf
extern inputNum


section .data
section .bss
section .text
	global addition

addition:
	section .data
		format:		db		"-> %f + %f = %f", 10, 0 ;new line = 10
	section .bss
		result:		resq	1
	section .text

		push rbp ;base pointer
		mov rbp, rsp ; stack pointer

		; input decimal nr in registrul xmm2(result)
		call inputNum
		movsd xmm2, xmm1
		; add cu nr initial introdus (in calculator)
		addsd xmm2, xmm0
		
		; rezultatul salvat  in memorie
		movsd [result], xmm2

		; print rezultat
		mov rax, 3
		mov rdi, format
		call printf ;din rdi standard printeaza

		; rezultatul inapoi in xmm0
		movsd xmm0, [result]

		;curatrea stivei 
		mov rsp, rbp
		pop rbp
		ret