section .data
	usage: db "usage: [mkdir] file", 10
	mkdir_fail: db "mkdir: failed to create directory", 10
	mkdir_fail_len: equ 34
	usage_len: equ 20

section .text
global _start
_start:
	pop rax			; store argc in rax
	cmp rax, 2		; compare argc with 2 if not exit with failure
	jne .usagemsg_exit

.mkdir:
	mov rdi,[rsp+8] 	; get argv[1]
	mov rax, 83		; mkdir sys-call
	mov rsi, 511 		; set mode for directory (511 corresponds to 0777 in octal)
	syscall
	mov r10, rax		; store return value of mkdir to r10
	cmp r10, 0		; check if mkdir return 0 if not exit with failure
	jne .failuremsg_exit
	jmp .exit

.usagemsg_exit:
	mov rsi, usage
	mov rdx, usage_len
	mov rdi, 2  		; 2 is stderr
	mov rax, 1
	syscall			; write sys-call
	mov r10, 1		; move 1 return value to r10
	jmp .exit

.failuremsg_exit:
	mov rsi, mkdir_fail
	mov rdx, mkdir_fail_len
	mov rdi, 2  		; 2 is stderr
	mov rax, 1
	syscall			; write sys-call
	jmp .exit

.exit:
	mov rdi, r10
	mov rax, 60
	syscall
