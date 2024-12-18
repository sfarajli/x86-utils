global _start

_start:
	mov rdi,[rsp+8+8] 	; get argv[1]
	; unlink sys-call
	mov rax, 87	
	syscall

exit:
	mov rdi, 0
	mov rax, 60 
	syscall
