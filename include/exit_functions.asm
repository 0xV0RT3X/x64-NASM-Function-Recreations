%ifndef EXIT_FUNCTIONS_INCLUDED
%define EXIT_FUNCTIONS_INCLUDED

;+--------------------------------------------------------------------------------+
;| Description: This function terminates the program with exit status code 0.     |
;| Input:       None                                                              |
;| Output:      None                                                              |
;+--------------------------------------------------------------------------------+
exit_success:
    mov rax, 60     ; set sys_exit system call
    xor rdi, rdi    ; set exit status code to 0
    syscall         ; terminate the program

;+--------------------------------------------------------------------------------+
;| Description: This function terminates the program with an exit status of 1.    |
;| Input:       None                                                              |
;| Output:      None                                                              |
;+--------------------------------------------------------------------------------+
exit_failure:
    mov rax, 60     ; set sys_exit system call
    mov rdi, 1      ; set exit status code to 1
    syscall         ; terminate the program

%endif
