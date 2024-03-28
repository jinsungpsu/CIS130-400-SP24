; Jin An

COMMENT /
	array sum code in c++
	int array[] = {1,2,3};
	int sum = 0;

	for (int i = 0; i < 3; i++) {
		sum+= array[i];
	}
/

.386
.model flat,stdcall
.stack 4096

.data

array DWORD 0,1,2,3,4,5

ExitProcess proto,dwExitCode:dword

.code			
main proc

	; for practice... a different versin of the same thing
	; sum of an array

	mov eax, 0						; reset accumulator
	mov ecx, LENGTHOF array			; set counter... for countdown to ecx == 0 for the loop
	mov ebx, 0						; another counter starting at 0
									; similar to i=0

LOOPANOTHERSUM:
	add eax, array[ebx * TYPE array] ; need to multiply by # of bytes
									; because "i" is index of item
									; and in assembly
									; offset needs to be address offset
	
	INC ebx							; similar to "i++"
	LOOP LOOPANOTHERSUM				; loop back

	; sum of an array

	mov edx, offset array			; save address of 1st element
									; in array

	mov eax, 0						; clear out value in eax
									; we'll use this as a sum
									; accumulator

	mov ecx, 6						; could do this... but don't
									; better to write FLEXIBLE code

	mov ecx, LENGTHOF array			; do this instead

LOOP_START_SUM:
	add eax, [edx]					; add the "current" element
									; of array into accumulator
	add edx, TYPE array				; increment address of element in array

	loop LOOP_START_SUM				; loop back to beginning
									; if counter hasn't reached 0
									; counter (ECX) is decremented
									; "automatically" by loop instruction
									; before it checks whether ECX != 0





	; before entering a "loop"
	; set ECX
	; to how many times you want to loop

	mov ecx, 3

LOOPSTART:

	; mov ecx, 5 ; don't do this.. infinite loop
	mov eax, array[0]
	add eax, array[1 * TYPE array]	; this is the 2nd item
									; TYPE array will give us back
									; the size of each element in that array
									; so this is an offset of 1 * 4
									; or the 2nd item...

LABEL2:
	mov ebx, eax




	LOOP LOOPSTART						; 1. decrement ECX
									; if ECX != 0
									; then go to LOOPSTART

	

	invoke ExitProcess,0
main endp
end main
