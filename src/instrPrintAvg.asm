; instrPrintAvg.asm
extern printf
section .data
section .bss
section .text
    global instrPrintAvg

instrPrintAvg:
    section .data
        format1:	db		"%s%s%s", 10, 0
        addsel:		db		10, "Pentru consumul mediu introduceti:", 10, 0
        subsel:		db		10, "--> Cantitatea de combustibil  consumata", 10, 0
        mulsel:		db		"--> Distanta parcursa pe traseu", 10, 0

    section .text
        push rbp
        mov rbp, rsp

        mov rax, 0
        mov rdi, format1
        mov rsi, addsel
        mov rdx, subsel
        mov rcx, mulsel
        call printf

        mov rsp, rbp
        pop rbp
        ret