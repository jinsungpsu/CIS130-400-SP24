; Jin An
; DTCC CIS130 Kip Irvine Chapter 3 Demos

; ignored by the compiler/assembler
; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

; things that start with a dot
; are what we call directives
; these are NOT instructions
; but these are special keywords
; for the compiler/assembler

COMMENT /
the purpose of this program is
to demonstrate a bunch of things
/

.386
.model flat,stdcall
.stack 4096

comment /
.data
myDouble DWORD 12345678h
.code
mov ax,myDouble 			; error – why?

mov ax,WORD PTR myDouble			; loads 5678h

mov WORD PTR myDouble,4321h		; saves 4321h
/

.data

arr1 BYTE 1,2,3
arr2 BYTE 4,5,6
arr3 WORD 4,5,6

myDouble DWORD 12345678h

result BYTE 3 dup(?)		; result BYTE ?, ?, ?
result2 WORD 3 dup(?)		

ExitProcess proto,dwExitCode:dword

.code			
main proc

	; PTR examples
	;mov ax,myDouble 			; error – why?
								; ax = 16 bits
								; myDouble = 32 bits
								; soooo... error

								; value of myWord
								; 12345678h

	mov ax, WORD PTR myDouble	
								; loads 5678h
								; trying to put a 32 bit value (DWORD)
								; into 16 bit register (ax)
								; have to be explicit* because
								; there will be data loss
								; so this operator (PTR)
								; will tell the compiler
								; to make myDouble variable
								; act as a WORD instead of a DWORD


	mov eax, offset myDouble
	mov WORD PTR myDouble,4321h		
								; saves 4321h
								; trying to only affect
								; a part of the myDouble
								; memory address (DWORD)
								; by using the PTR operator
								; to make it act as a WORD
								; instead of DWORD
								; originally, it was 32 bits
								; 12346789h
								; then it becomes
								; 12341234h
								; because it only affected the 
								; first 2 addresses (16 bits)

	; using PTR to combine smaller data into bigger
	; arr1 has BYTE values 1,2,3
	; if I wanted to combine the first 2 elements into a WORD
	; going from 8 bits into 16 bits...

	mov ax, WORD PTR arr1

	; offset examples
	mov eax, offset arr1
	; get the "address" (or offset from enclosing segment)
	; of arr1 in RAM
	; save that value into eax
	; offset will be 32 bits (4 bytes)

	; add up arrays of different types
	; arr1 BYTE, arr3 WORD
	; result2 WORD

	movzx ax, arr1	; mov first element of arr1 into ax
					; arr1 first element is a BYTE
					; ax is a WORD
	add ax, arr3
	mov result2, ax	; all of these are just the first element

	movzx ax, arr1+1
	add ax, arr3+2
	mov result2+2, ax





	comment /
	Create an array of BYTE data with integers
	{1,2,3}
	Create an array of BYTE data with integers
	{4,5,6}
	Add up each pair with the same index and save back to memory
	Results should be:
	{5, 7, 9}
	/

	mov al, arr1[0]		; al = arr1[0]
	add al, arr2[0]		; al += arr2[0]
	mov result[0], al	; result[0] = al

	; the offset in this scenario
	; is +1 everyone...because each element
	; is 8 bits (or 1 BYTE) long...
	mov al, arr1[1]		; al = arr1[1]
	add al, arr2[1]		; al += arr2[1]
	mov result[1], al	; result[1] = al

	; alternative notations
	; all three do the same thing
	; each will offset the base address
	; of result by 1 BYTE
	; result[1]
	; result+1
	; [result+1]

	; what if I wanted to add ebx (DWORD)
	; to what's in AL (which is a BYTE)
	mov ebx, 25

	movzx ecx, al		; this is allowed
						; designed to
						; move smaller data
						; into bigger destinations

	; add ebx, al		; this is NOT allowe
						; add requires both
						; operands to be same size

	add ecx, ebx		; now I can add them
						; they're same size

	mov al, [result+10000]

	neg al

	mov eax, 25-2*3+(1+5)

	invoke ExitProcess,0
main endp
end main
