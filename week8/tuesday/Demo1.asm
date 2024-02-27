; ignored by the compiler/assembler
; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

; things that start with a dot
; are what we call directives
; these are NOT instructions
; but these are special keywords
; for the compiler/assembler
.386
.model flat,stdcall
.stack 4096


.data			; this is the area where we define data
num dword 12    ; this is a data definition
				; bc it's in the data section

ExitProcess proto,dwExitCode:dword

.code			; this is the area where we write code
main proc
	mov	eax, num	; operation = mov or MOVE data
					; mov has 2 operands
					; first operand is the destination
					; second operand is the source
					; operand sizes are REALLY important
					; operand sizes == data type
					; operand sizes MUST match when using
					; mov operation
					; in this instruction - eax "operand size" - double word
					; num is a "variable" in RAM 
					; defined as a DWORD up in the .code section
					; this is a memory to register move
	
	
	mov ebx,10		; is a "literal" assigned to register

	add	eax,ebx		; another instruction
					; operation is ADD
					; same rules as mov
					; operand sizes must match
					; first operand is dest + operand #1
					; second operand is operand #2
					; eax = eax + ebx
					; in this case, add 10 + 12
					; put the result in eax

	invoke ExitProcess,0
main endp
end main
