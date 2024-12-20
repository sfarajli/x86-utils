section .data
	usagemsg: db "usage: unlink [file]", 10
	failuremsg: db "unlink: failed to unlink file", 10
	usagemsg_len: equ 21
	failuremsg_len: equ 30

section .text
global _start
_start:
	cmp r10, 0		; r10 stores the program return value
	pop rsi			; store argc in rsi
	cmp rsi, 2		; check if argc == 2 if not print usage and exit
	jne .usagemsg_exit
	mov rdi,[rsp+8] 	; get argv[1]
	mov rax, 87		; unlink sys-call
	syscall
	mov r10, rax		; store the return value of unlink call to r10
	cmp r10, 0
	jne .failuremsg_exit
	jmp .exit

.usagemsg_exit:
	mov rsi, usagemsg
	mov rdx, usagemsg_len
	mov rdi, 2  		; 2 is stderr
	mov rax, 1
	syscall			; write sys-call
	mov r10, 1
	jmp .exit

.failuremsg_exit:
	mov rsi, failuremsg
	mov rdx, failuremsg_len
	mov rdi, 2  		; 2 is stderr
	mov rax, 1
	syscall			; write sys-call
	jmp .exit

.exit:
	mov rdi, r10
	mov rax, 60
	syscall
