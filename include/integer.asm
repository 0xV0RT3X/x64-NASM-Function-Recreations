%ifndef INTEGER_INCLUDED
%define INTEGER_INCLUDED

%include "include/string.asm"


; int_print - function to print an integer value
;
; INPUT:
;   rdi - integer value to be printed
;
; OUTPUT:
;   printed integer value
;
; DESCRIPTION:
;   This function takes an integer value stored in the RDI register and converts it into a string representation
;   using division by 10. It then pushes each digit of the converted string onto the stack.
;   Finally, it calls the string_print function to print the digits stored on the stack.
;   The function restores all the preserved registers at the end.
int_print:
    push rdi            ; preserve rdi
    push rax            ; preserve rax
    push rbx            ; preserve rbx
    push rdx            ; preserve rdx
    push rsi            ; preserve rsi

    xor rsi, rsi        ; initialize the number of characters to 0

    mov rax, rdi        ; move the address of string into rax

.divide_loop:
    inc rsi             ; count each byte to print - number of characters
    xor rdx, rdx        ; empty rdx
    mov rbx, 10         ; move 10 into rbx
    idiv rbx            ; divide rax by rbx
    add rdx, '0'        ; convert rdx into its ascii representation
    push rdx            ; push rdx on the stack
    cmp rax, 0          ; can the integer be divided anymore?
    jnz .divide_loop    ; jump if not zero to the label .divide_loop

.print_loop:
    dec rsi             ; count down each byte that we put on the stack
    mov rdi, rsp        ; move the stack pointer into rdi for printing
    call string_print   ; print digit
    pop rdi             ; pop next digit into rdi
    cmp rsi, 0          ; have we printed all bytes we pushed on the stack?
    jnz .print_loop     ; repeat loop

    pop rsi             ; restore rsi
    pop rdx             ; restore rdx
    pop rbx             ; restore rbx
    pop rax             ; restore rax
    pop rdi             ; restore rdi

    ret                 ; return to the caller

%endif
