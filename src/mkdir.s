global _start

_start:
	mov rdi,[rsp+8+8] 	; get argv[1]
	; mkdir sys-call
	mov rax, 83	
	mov rsi, 511 		; set mode for directory (511 corresponds to 0777 in octal)
	syscall

exit:
	mov rdi, 0
	mov rax, 60 
	syscall
