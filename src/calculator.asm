; calculator.asm
extern printf
extern selectionPrinting
extern inputNum
extern addition
extern subtraction
extern multiplication
extern division
extern avrageFuel
extern speedNeed

;macro pentru a lua input de la user --- cu syscall, similar cu "int" din emu8086
%macro takeInput 1
	mov rax, 0 				; sysread - indicam apelul de sistem
	mov rdi, 0 				; stdin - indicam citirea inputului de la stdin
	mov rsi, %1 			; rsi setat la valoarea argumentului macro-ului, adica adresa de mem. unde va fi stocap inputul citit
	mov rdx, numLength		;nr de octeti cititi
	syscall					
%endmacro

;constantele din programul nostru
section .data
	inputNumFormat:			db		"Enter a number: ", 0
	iNLength:				equ		$-inputNumFormat

	err1:					db		"You entered invalid number... Exiting from program!", 10, 0
	err1Length:				equ		$-err1

	invalidSelect:			db		"Invalid select! Exiting from program...", 10, 0
	iSLength:				equ		$-invalidSelect

	formatExit:				db		"Exiting from program...", 10, 0
	fELength:				equ		$-formatExit

	numLength:				equ		15

;spatiu pentru date care nu sunt initializate
section .bss
	num1:					resq	1  ;resq este reserve quadword (8 octeti)
	selection:				resq	1

;multumita lor putem apela functia si din alte module, fiind globale
section .text
	global main
	global invalidNumber

main:
	; stack alignment
	push rbp ;registru base pointer
	mov rbp, rsp ; registru stack pointer -> rbp

	; the number coming in xmm1
	call inputNum 
	movsd xmm0, xmm1 ; movsd muta un scalar double-precision floating-point value (64 de biti) intre registrele cu virgula mobila


loopForSelect:
	movsd [num1], xmm0 ;num1 e alocat ca adresa in bss

	; meniul printat in consola
	call selectionPrinting

	; takeInput in variabila selection (bss)
	takeInput selection ;macro-ul take salveaza in selection, din bss

	; selectarea operatiunii din meniu
	mov rsi, selection
	xor rcx, rcx ;resetam rcx la zero 
	xor rax, rax	;reset la zero
	xor rbx, rbx	; -//-//-
	movsd xmm0, [num1]		
	call selOperation
	jmp loopForSelect

	leave
	ret

selOperation:
	mov al, byte[rsi + rcx]
	cmp al, 0x31				;ESTE 1
	je addition

	cmp al, 0x32 				;ESTE 2
	je subtraction

	cmp al, 0x33 				;ESTE 3
	je multiplication

	cmp al, 0x34				;ESTE 4
	je division

	cmp al, 0x35				;ESTE 6
	je  avrageFuel

	cmp al, 0x36				;ESTE 7
	je speedNeed

	cmp al, 0x37				;Iesim daca dam 7
	je exiting

	

; daca nu avem de la 1-6
invalidSelection:
	mov rax, 1 ;apelare syswrite
	mov rdi, 1	;output stdout
	mov rsi, invalidSelect ;rsi primeste adresa
	mov rdx, iSLength ;valoarea lungimii mesajului de  eroare
	syscall
	leave ;echivalent cu mov rsp, rbp urmat de pop rbp, deci restaureaza stiva  anterioara
	ret
invalidNumber:
	mov rax, 1
	mov rdi, 1
	mov rsi, err1	;err1 e la linia 24 din acest fisier
	mov rdx, err1Length
	syscall
	leave
	ret
exiting:
	mov rax, 1
	mov rdi, 1
	mov rsi, formatExit
	mov rdx, fELength
	syscall
	leave
	ret
