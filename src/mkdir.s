section .data
	usage: db "usage: [mkdir] file", 10
	usageLen: equ $-usage

section .text
global _start
	; TODO: check return value of mkdir sys-call

_start:
	pop rax			; store argc in rax
	cmp rax, 2		; compare argc with 2 if not exit with failure
	jne .exit_failure

.mkdir:
	mov rdi,[rsp+8] 	; get argv[1]
	mov rax, 83		; mkdir sys-call
	mov rsi, 511 		; set mode for directory (511 corresponds to 0777 in octal)
	syscall

.exit_success:
	mov rdi, 0
	mov rax, 60
	syscall

.exit_failure:
	mov rsi, usage
	mov rdx, usageLen
	mov rdi, 2  		; 2 is stderr
	mov rax, 1
	syscall			; write sys-call, printing usage to stderr

	mov rdi, 1
	mov rax, 60
	syscall
