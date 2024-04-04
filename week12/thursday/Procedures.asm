; Jin An

.386
.model flat,stdcall
.stack 4096

.data

num1 DWORD 5
num2 DWORD 10

array BYTE 1,2,3,4,5

ExitProcess proto,dwExitCode:dword

.code			
main proc					; start of the main procedure

	mov esi, OFFSET array
	mov ECX, LENGTHOF array
	call arraySum			; this proc receives ESI and ECX (array address and length, respectively)

	call menu

	call sumUseless

	mov ebx, 10
	mov ecx, 25

	call sumReusable		; this single line of code
							; does a lot more than you think
							; it actually changes the value of edx

	invoke ExitProcess,0
main endp					; end of the main procedure

; how do we make a sum of array procedure using assembly

; -----------------------------------------------
arraySum PROC
; adds up all the values inside of an INTEGER array
; receives: an array - ESI is address of array, ECX - length of the array
; returns: al = sum
; requires: nothing
; -----------------------------------------------
	mov eax, 0
	xor eax, eax			; this is faster, because it doesn't involve MOV

SUMLOOP:
	add al, [esi]
	add esi, 1
	loop SUMLOOP

	; when I'm done figuring out the solution
	; make sure I go back and see if I need add
	; any used registers that need to be restored
	ret
arraySum ENDP

comment \
	HIGH LEVEL EQUIVALENT
	int array[] = {1,2,3};
	int sum = arraySum(array, 3); // sum should be 1+2+3 = 6

	int arraySum (int[] arr, int size) {
		int sum = 0;
		for (int i = 0; i < size; i++) {
			sum+= arr[i];
		}
		return sum;
	}
\

; another procedure outside of main procedure

; ---------------------------
sumUseless proc
; this procedure adds up two numbers stored in
; memory in variables num1, num2
; receives: nothing
; returns: EAX, the sum of two numbers, will also affect
;          some flags (overflow, carry, sign, zero)
; requires: nothing
; ---------------------------
	mov eax, num1
	add eax, num2
	ret							; don't forget to return
sumUseless endp

; ---------------------------
sumReusable proc
; this procedure adds up two numbers stored in
; memory in variables num1, num2
; receives: EBX is first operand, ECX is second operand
;			both operands are DWORD (32-bit)
; returns: EAX, the sum of two numbers, will also affect
;          some flags (overflow, carry, sign, zero)
; requires: nothing
; ---------------------------
	push edx					; since I'll be using edx
								; during my calculation
								; I don't want the value
								; to change for the people
								; outside of this procedure
								; save edx into runtime stack
	mov edx, ebx
	add edx, ecx
	mov eax, edx
	pop edx						; restore edx
								; so that its value is unchanged
								; from the perspective of main
	ret							; don't forget return
sumReusable endp

; ---------------------------
sumReusableBetter proc uses edx
; using the USES operator
; will push/pop EDX at beginning/end of the procedure

; this procedure adds up two numbers stored in
; memory in variables num1, num2
; receives: EBX is first operand, ECX is second operand
;			both operands are DWORD (32-bit)
; returns: EAX, the sum of two numbers, will also affect
;          some flags (overflow, carry, sign, zero)
; requires: nothing
; ---------------------------
	mov edx, ebx
	add edx, ecx
	mov eax, edx
	ret
sumReusableBetter endp

menu proc
	mov eax, 0				; some code... irrelevant
	ret						; don't forget to put a return
							; otherwise, you'll end up with some
							; weird issues... the call stack
							; in debugger is gonna give you some
							; weird errors
							; and then it's also MIGHT show you
							; a "Source nost available" error
							; in visual studio
menu endp

end main
