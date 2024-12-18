global _start

_start:
	mov rdi,[rsp+8+8] 	; get argv[1]
	; rmdir sys-call
	mov rax, 84	
	syscall

exit:
	mov rdi, 0
	mov rax, 60 
	syscall
