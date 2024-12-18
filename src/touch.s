global _start

_start:
	mov rdi,[rsp+8+8] 	; get argv[1]
	; touch sys-call
	mov rax, 85
	mov rsi, 438 		; set mode for directory (438 corresponds to 0666 in octal)
	syscall

exit:
	mov rdi, 0
	mov rax, 60 
	syscall
