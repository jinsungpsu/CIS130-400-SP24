; Jin An

.386
.model flat,stdcall
.stack 4096

.data
x DWORD 10

ExitProcess proto,dwExitCode:dword

.code			
main proc					; start of the main procedure
comment \
if (x%2 == 0) { // if x is even
	mov eax, x
}
\

	mov ebx, x		; ebx = x
	AND ebx, 1		; AND x value by 0000 0000 0000 0001
					; the result of this operation
					; can only be 1 or 0
					; if the result is 0
					; then the zero flag will be SET

	JNZ someLabel	; if zero flag is NOT set
					; then go to someLabel

					; not jumping
					; implies x is even
	mov eax, x

someLabel:
					; x is odd

comment \
	if (x%2 == 0) { // if x is even
		mov eax, x
	} else {		// if x is odd
		mov eax, 10
	}

	we don't have "blocks" of code in assembly
	so we have to use a bunch of jumps
\

	mov ebx, x			; ebx = x
	AND ebx, 1			; AND x value by 0000 0000 0000 0001

	JNZ oddOnly			; if zero flag is NOT set
						; this is the section for even
						; starts here
	mov eax, x
						
						; section for even ends
						; right before the unconditional jump
	jmp continueProgram	; make sure you skip the 
						; oddOnly section

oddOnly:
					; x is odd
	mov eax, 10

continueProgram:
	invoke ExitProcess,0
main endp

end main
