%ifndef STRING_INCLUDED
%define STRING_INCLUDED

;+-----------------------------------------------------------------------------------------------------------+
;| Description:          This function calculates the size (Byte) of a null-terminated string passed in RDI. |
;| Input:                The address of a null-terminated string in RDI.                                     |
;| Output:               The size of the string in RAX.                                                      |
;+-----------------------------------------------------------------------------------------------------------+
string_size:
    push rbx            ; save the value of rbx on the stack
    push rsi            ; save the value of rsi on the stack

    mov rsi, rdi        ; save the address of the string to a register

.next_char:
    mov al, [rsi]       ; load the next character from the string
    inc rsi             ; increment the string pointer
    cmp al, 0           ; check if the character is the null terminator
    jne .next_char      ; repeat the loop if the character is not the null terminator

    sub rsi, rdi        ; calculate the length of the string
    mov rax, rsi        ; return the length of the string in rax

    pop rsi             ; restore the value of rsi
    pop rbx             ; restore the value of rbx

    ret                 ; return to the caller

;+-----------------------------------------------------------------------------------------------------------+
;| Description:          This function calculates the length of a null-terminated string passed in RDI.      |
;| Input:                The address of a null-terminated string in RDI.                                     |
;| Output:               The length of the string in RAX.                                                    |
;+-----------------------------------------------------------------------------------------------------------+
string_length:
    call string_size    ; calculate the size of the string
    dec rax             ; decrement rax by 1

    ret                 ; return to the caller

;+--------------------------------------------------------------------------------+
;| Description: This function prints a null-terminated string passed in RDI.      |
;| Input:       The address of a null-terminated string in RDI.                   |
;| Output:      None                                                              |
;+--------------------------------------------------------------------------------+
string_print:
    push rdi            ; save the value of rdi on the stack
    push rsi            ; save the value of rsi on the stack
    push rdx            ; save the value of rdx on the stack

    call string_length  ; get the length of the string

    mov rdx, rax        ; store the length of the string in rdx

    mov rax, 1          ; set sys_write system call
    mov rsi, rdi        ; set the address of the string to rsif
    mov rdi, 1          ; set the file descriptor to stdout
    syscall             ; make the syscall

    pop rdx             ; restore the value of rdx
    pop rsi             ; restore the value of rsi
    pop rdi             ; restore the value of rdi

    ret                 ; return to the caller

;+--------------------------------------------------------------------------------+
;| Description: This function prints a linefeed character to stdout.              |
;| Input:       None                                                              |
;| Output:      None                                                              |
;+--------------------------------------------------------------------------------+
printlf:
    push rax           ; push rax onto the stack to preserve it while we use the rax register in this function

    mov rax, 0xA       ; move 0xA into rax - 0xA is the ascii character for a linefeed

    push rax           ; push the linefeed onto the stack so we can get the address

    mov rdi, rsp       ; move the address of the current stack pointer into rax for string_print
    call string_print  ; print linefeed

    pop rax            ; remove linefeed character from the stack
    pop rax            ; restore the original value of rax before the function was called

    ret                ; return to the caller

;+--------------------------------------------------------------------------------+
;| Description: This function prints a linefeed character to stdout.              |
;| Input:       The string in the RDI register.                                   |
;| Output:      None                                                              |
;+--------------------------------------------------------------------------------+
string_printlf:
    call string_print  ; print the string to stdout
    call printlf       ; print a linefeed character to stdout

    ret                ; return to the caller

%endif
