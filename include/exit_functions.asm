%ifndef EXIT_FUNCTIONS_INCLUDED
%define EXIT_FUNCTIONS_INCLUDED

exit_success:
    mov eax, 60     ; set sys_exit system call
    xor edi, edi    ; set exit status code to 0
    syscall         ; terminate the program

exit_failure:
    mov eax, 60     ; set sys_exit system call
    mov edi, 1      ; set exit status code to 0
    syscall         ; terminate the program

%endif
