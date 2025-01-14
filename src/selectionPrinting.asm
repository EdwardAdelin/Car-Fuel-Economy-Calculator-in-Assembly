; selectionPrinting.asm
extern printf
section .data
section .bss
section .text
    global selectionPrinting

selectionPrinting:
    section .data
        format1:	db		"%s%s%s%s%s%s", 10, 0
        addsel:		db		10, " 1 - Adunare valori", 10, 0
        subsel:		db		" 2 - Scadere valori", 10, 0
        mulsel:		db		" 3 - Inmultire valori", 10, 0
        divsel:		db		" 4 - Impartire valori", 10, 0
        avrage:		db		" 5 - Calculare consum mediu", 0
        facsel:	    db		" 6 - Viteza necesara parcurgere", 10, 0
        exsel:		db		" 7 - Iesire din program", 10, 0
        selection:	db		10, "Selecteaza una dintre variantele de mai sus: ", 10, 0

    section .text
        push rbp
        mov rbp, rsp

        mov rax, 0
        mov rdi, format1
        mov rsi, addsel
        mov rdx, subsel
        mov rcx, mulsel
        mov r8, divsel
        mov r9, avrage
        call printf

        mov rax, 0
        mov rdi, facsel
        call printf

        mov rax, 0
        mov rdi, exsel
        call printf

        mov rax, 0
        mov rdi, selection
        call printf

        mov rsp, rbp
        pop rbp
        ret