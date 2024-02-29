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
				; long num = 12;
				; type is DWORD, which is 32 bits
				; can assign a value
				; OR can leave it uninitialized
				; by assigning it a value of '?'

taco dword 100
bell dword 15
mcdonalds dword "HI"
burgerking dword 'C'
wendys dword 1001010101b
dairyqueen dword 0FF10Bh
popeyes dword 12345o

; how do we define arrays?
fastFoodJoints DWORD 1,2,3,4,5
; equivalent of declaring an array
; int fastFoodJoints[] = {1,2,3,4,5};



ExitProcess proto,dwExitCode:dword

.code			; this is the area where we write code
main proc
	; immediate addressing
	; actual/literal value in the instruction itself

	; numerical types

	; we can just use decimal values
	mov eax, 1010

	; binary, suffix of 'b'
	mov eax, 1010b

	; we can do hex, suffix of 'h'
	; need a leading 0
	; otherwise, it's a syntax error
	mov eax, 0ffh

	; can also do octal
	mov eax, 777o

	; chars and strings also
	; which are saved as ascii values
	; can use single or double quotes
	mov eax, 'hi'
	mov ebx, "bye"
	mov ecx, 'c'
	mov edx, "d"

	; direct addressing
	; memory (RAM)
	; need to define the variable
	; up in the .data section

	mov eax, dairyqueen ; move value of dairyqueen (RAM) into eax register
	mov burgerking, 10  ; move immediate value 10 into RAM
	;mov taco, bell		; this is NOT allowed
						; memory to memory mov (and many other operations)
						; NOT allowed

	; register addressing
	; just use the name of the register
	; those are pre-determined...

	; register indirect addressing
	; is where the register doesn't actually hold a value
	; just holds the address in RAM to a value

	; offset directive gives you the address in memory
	mov eax, offset taco	; store the RAM address of taco into eax
							; taco is variable in .code section
							; holds value of 100

	mov ebx, eax			; move the value in eax into ebx

	mov ebx, [eax]			; indirect addressing
							; go get the value in the address
							; stored in eax

	; indexed addressing
	; use with arrays like
	; fastFoodJoints

	mov eax, fastFoodJoints ; this is allowed
							; it's just an address (RAM)
							; just assigns the FIRST item in array
							; value contained in the address

	mov ebx, fastFoodJoints[1]	; indexed addressing
								; second item (0 based counting)
								; will fix AFTER spring break
								; seems like a small error (2/29/2024)

	mov eax, 0		; clear value of eax
	mov ebx, 4294967295 ; write all 1s
	mov ax, 8		; ax is only 16 bits
	mov ah, 8		; ah is only 8 bits
					; smallest size data
					; we deal with in x86 asm






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
