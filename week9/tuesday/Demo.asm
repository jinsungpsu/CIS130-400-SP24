; ignored by the compiler/assembler
; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

; things that start with a dot
; are what we call directives
; these are NOT instructions
; but these are special keywords
; for the compiler/assembler

comment /
the purpose of this program is
to demonstrate a bunch of things
/

.386
.model flat,stdcall
.stack 4096


.data

num DWORD 5				; int num = 5
name BYTE "Johnny"		; string name = "johnny"
num2 DWORD ?			; int num2; (uninitialized)

ExitProcess proto,dwExitCode:dword

.code			
main proc
	mov eax, 1+2*(3*4)			; something something
Label1:							; label
	mov ebx, eax				; moving eax data into ebx

	add ebx, eax				; ebx = ebx + eax
								; first operand CANNOT be
								; immediate addressing
								; can't do
								; add 1, eax
								; add, sub
								; first operand can only be
								; register or memory
								; additionally
								; same rules as mov apply
								; same size operands
								; no memory to memory allowed

	; num2 = num + 6
	add num, 6					; num = num + 6

	; mov num2, num				;num2 = num, not allowed
								; memory to memory

	mov eax, num				; need to temporarily save it
								; to register
	mov num2, eax				; then back to memory

	; another way of doing it - a little more concise
	mov eax, 6
	add eax, num
	mov num2, eax

	; add num2, num+6

	invoke ExitProcess,0
main endp
end main
