; Jin An

.386
.model flat,stdcall
.stack 4096

.data

num1 WORD 5
num2 WORD 10
num3 WORD 15
num4 WORD ?
num5 WORD ?

arr DWORD 1,2,3,4,5,6,7,8,9,10
sum1 DWORD ?
sum2 DWORD ?

x BYTE 2

ExitProcess proto,dwExitCode:dword

.code			
main proc					; start of the main procedure

	; conditional jumps

	; MUST do a test or comparison FIRST to set flags

	mov eax, 5
	imul eax, 5

	; if (x < 5)
	;	mov eax, 0
	; maybe checking for array bounds

	CMP x, 5		; this does our comparison
					; non-destructive subtraction
					; sets flags accordingly
	JA L1
	mov eax, 0
	; any code that goes from here until L1
	; is skipped if x > 5
	; if it's NOT true, SKIP
L1:
	; rest of the program... keep going



	; procedures review

comment \
	int num1 = 5, num2 = 10, num3 = 15;
	int num4 = sum(num1, num2); // 5+10 = 15
	int num5 = sum(num2, num3); // 10+15 = 25

	int sum(int n1, int n2) {
		return n1+n2;
	}
\
	; move the proper values into expected registers
	mov bx, num1
	mov cx, num2
	call sum
	mov num4, ax

	mov bx, num2
	mov cx, num3
	call sum
	mov num5, ax

	; ebx = start
	; ecx = end
	; edx = arr

	mov edx, OFFSET arr
	mov ebx, 0
	mov ecx, 3
	call sumSubArray
	mov sum1, eax

	mov ebx, 5
	mov ecx, 8
	call sumSubArray
	mov sum2, eax


comment \
int arr[] = {1,2,3,4,5,6,7,8,9,10};
int sum1 = sum(arr, 0, 3); // sum index 0 through 3, so 1+2+3+4 = 10
int sum2 = sum(arr, 5, 8); // sum index 5 through 8, so 6+7+8+9=30
int sum(int[] array, int start, int end) {
int sum = 0;	
for (int i = start; i <= end; i++) {
	sum += array[i];
}
return sum;
}

\
	
main endp

; ------------------------------
sum proc
; adds up a couple of numbers
; receives: two numbers to add up, num1 = bx, num2 = cx
; returns: the sum of num1 and num2 stored in ax
; requires: nothing
; ------------------------------
	mov ax, bx
	add ax, cx
	ret
sum endp
; ------------------------------

; ------------------------------
sumSubArray proc USES ebx ecx
; adds up a subarray based on start/end index
; receives: arr of DWORD numbers - address will be stored
;			in edx
;			two integers for start, end indices
;			start index = ebx
;			end index = ecx
; returns:  sum will be stored in eax
; requires: end > start, arr length > end-start
; ------------------------------
	mov eax, 0

	; if array is 1,2,3,4,5
	; start is 2
	; end is 4
	; this means, add 3,4,5
	; means, loop should go through 3 times
	; ecx = 4-2+1
	sub ecx, ebx
	add ecx, 1

LOOP_SUM:
	add eax, [edx + ebx * 4]	; ebx is start index
								; 4 is size for DWORD or 4 bytes
	inc ebx						; increment start counter
	loop LOOP_SUM

	ret
sumSubArray endp
; ------------------------------

end main
