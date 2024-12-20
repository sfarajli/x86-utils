section .data
	usagemsg: db "usage: rmdir [file]", 10
	failuremsg: db "rmdir: failed to remove directory", 10
	usagemsg_len: equ 20
	failuremsg_len: equ 34

section .text
global _start
_start:
	cmp r10, 0		; r10 stores the program return value
	pop rsi			; store argc in rsi
	cmp rsi, 2		; check if argc == 2 if not print usage and exit
	jne .usagemsg_exit
	mov rdi,[rsp+8] 	; get argv[1]
	mov rax, 84 		; rmdir sys-call
	syscall
	mov r10, rax		; store the return value of mkdir to r10
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
