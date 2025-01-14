; instPrintSpeed.asm
extern printf
section .data
section .bss
section .text
    global instrPrintSpeed
instrPrintSpeed:
    section .data
        format1:	db		"%s%s%s", 10, 0
        addsel:		db		10, "Pentru aflarea vitezei necesare introduceti:", 10, 0
        subsel:		db		10, "--> Distanta de parcurs (in Km)", 10, 0
        mulsel:		db		"--> Timpul in care se doreste parcurgerea (in minute)", 10, 0

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