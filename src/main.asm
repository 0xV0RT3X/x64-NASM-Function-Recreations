%include "include/exit_functions.asm"

;*+---------------------------------------------------------------------------+
;*| The .data section is used to store initialized data in a program.         |
;*| This data is usually defined by the programmer and does not change        |
;*| during program execution. Examples of data stored in the .data section    |
;*| include strings, arrays, and variables with constant values.              |
;*| These values are assigned by the programmer before program                |
;*| execution and are used by the program as required.                        |
;*| The .data section is loaded into memory along with the program            |
;*|and remains there until the program terminates.                            |
;*+---------------------------------------------------------------------------+
section .data
    msg db 'Hello World!', 0xA, 0x0

;*+--------------------------------------------------+
;*| The .bss segment is used for uninitialized       |
;*| data in a program. This means that the data      |
;*| stored in this section will not have a specific  |
;*| value assigned at the start of the program, but  |
;*| rather it is up to the program to assign values  |
;*| to this data at runtime.                         |
;*+--------------------------------------------------+
section .bss

;*+-------------------------------------------------+
;*| The .text segment is used to store the actual   |
;*| instructions of the program. It is the          |
;*| read-only and executable section of the program |
;*| and contains the code that the CPU executes.    |
;*+-------------------------------------------------+
section .text
    global _start

;*+---------------------------------------------------+
;*| The entry point of the executable code in NASM.   |
;*| It's the first label that the kernel will execute |
;*| when the program starts.                          |
;*|---------------------------------------------------+
_start:
    mov rax, 1          ; set sys_write system call
    mov rdi, 1          ; set stdout file descriptor
    mov rsi, msg        ; set buffer to msg
    mov rdx, 12         ; set msg length to 12
    syscall             ; write msg to stdout

    call exit_success   ; terminate the program
