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

array1 DWORD 1,2,3
array2 DWORD 4,5,6
array3 DWORD 7,8,9
twoDarray DWORD array1,array2,array3

comment /
	int twoDarray[][] = {
		{1,2,3},
		{4,5,6},
		{7,8,9}
	};

	int sum = 0;
	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			sum += twoDarray[i][j];
		}
	}
/


array DWORD 0,1,2,3,4,5



ExitProcess proto,dwExitCode:dword

.code			
main proc

comment /
	int twoDarray[][] = {
		{1,2,3},
		{4,5,6},
		{7,8,9}
	};

	int sum = 0;
	for (int i = 0; i < 3; i++) {
		for (int j = 0; j < 3; j++) {
			sum += twoDarray[i][j];
		}
	}
/
	; big idea is... i need to loop 3 times (counter is i)
	; inside that loop, i need to loop 3 times (counter is j)

	mov eax, 0						; accumulator for sum
	mov ecx, LENGTHOF twoDarray		; initializes outer loop ecx to 3
									; more specifically, number of items
									; or length of the array
	mov edx, OFFSET twoDarray		; save address of first item of 2d array

outerloop:
	
	push ecx
	mov ecx, 3						; assume this works for now...
	
innerloop:
	add eax, [edx]					; add up the contents of array
	add edx, 4						; increment address
	LOOP innerloop					; inner loop goes back

	pop ecx							; take whatever is at the top of the stack
									; and save it to ecx
									; restore the value of counter
									; of the outer loop

	LOOP outerloop					; outer loop goes back
	

	mov eax, 5		; eax = 5
	push eax		; add eax (or 5) into runtime stack
					; so... right now
					; the only item in the stack
					; is 5, and it is both the top and the bottom

	push 10			; this means, the stack now has 2 items
					; bottom is 5, top is 10

	push 20
	push 30
	push 40
					; now stack has 5 items
					; 
					; 40   <--- top
					; 30
					; 20
					; 10
					; 5    <---- bottom

	pop ebx			; 40
	pop ebx			; 30
	pop ebx			; 20
	pop ebx			; 10
					

	
	comment /
		simple example for 4-2-24

		int sum=0;
		ecx = 10;
		do {
			sum += i + 4;

			ecx--;
		} while(ecx!=0);

		for (int i = 0; i < ecx; i++) {
		
		}
	/

	mov eax, 0					; use eax for sum, initialize to 0
	mov ecx, 10					; initialize counter for loop

sumMultOfFourLoopStart:
	mov ebx, ecx					; move ecx into ebx
	add ebx, 4						; ebx = ebx (copied from ecx) + 4
	add eax, ebx					; eax = ebx + eax 

	loop sumMultOfFourLoopStart	; decrement ecx, check ecx!=0, then loop back to start












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
