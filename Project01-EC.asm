TITLE Elementary Arithmetic      (Project01-EC.asm)

; Author: Ivan A. Xa
; CS_271_400                 Date: January 22, 2017
; Description: Get user input, manipulate, and display data

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

project_name	BYTE	"Elementary Arithmetic	" , 0
author			BYTE	"by Ivan A. Xa" , 0
prompt_1		BYTE	"Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder." , 0
firstGet		BYTE	"First Number: " , 0
secondGet		BYTE	"Second Number: " , 0
first_num		DWORD	?	;first number entered
second_num		DWORD	?	;second number entered

adding			BYTE	" + " , 0
subtracting		BYTE	" - " , 0
multiplying		BYTE	" x " , 0;158, 0	;ASCII code 158 = × ( Multiplication sign )
dividing		BYTE	246, 0	;ASCII code 246 = ÷ ( The division sign ; Obelus )
remainder		BYTE	" remainder " , 0
equals			BYTE	" = ", 0
space			BYTE	" " , 0

addResult		DWORD	?
subtractResult	DWORD	?
multiResult		DWORD	?
divideResult	DWORD	?
remainResult	DWORD	?

goodbye			BYTE	"Impressed? Bye!" , 0

;extra credit below
ec1_prompt		BYTE	"**EC1: Repeat until the user chooses to quit." , 0
ec2_prompt		BYTE	"**EC2: Validate the second number to be less than the first." , 0
;ec3_prompt		BYTE	"**EC3: Calculate and display the quotient as a floating-point number, rounded to the nearest .001." , 0

validate2		BYTE	"The second number must be less than the first!" , 0
validate1		BYTE	"Enter 0 to repeat or any other number to quit: " , 0
repeatOrNot		DWORD	?




.code
main PROC

Start:
;Introduce program and print name
	mov		edx, OFFSET project_name
	call	WriteString
	mov		edx, OFFSET author
	call	WriteString
	call	CrLf 
	mov		edx, OFFSET ec1_prompt
	call	WriteString
	call	CrLf
	mov		edx, OFFSET ec2_prompt
	call	WriteString
	call	CrLf
	;mov		edx, OFFSET ec3_prompt
	;call	WriteString
	;call	CrLf

;produce prompt1
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	CrLf

;get user input
	mov		edx, OFFSET firstGet
	call	WriteString
	call	ReadInt
	mov		first_num, eax
;get user input 2
	mov		edx, OFFSET secondGet
	call	WriteString
	call	ReadInt
	mov		second_num, eax

;if second_num > first_num print error statement
	mov		eax, first_num
	cmp		eax, second_num
	jl		SmallBig			;if first_num is less than second_num

;calculate sum
	mov		eax, first_num		;moving 1st and 2nd number to registers for adding
	mov		ebx, second_num
	add		eax, ebx			;add ebx to eax, results in eax
	mov		addResult, eax
	mov		eax,  first_num		;print out results
	call	WriteDec
	mov		edx, OFFSET adding
	call	WriteString
	mov		eax, second_num
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, addResult
	call	WriteDec
	call	CrLf
	
;calculate minus
	mov		eax, first_num		;moving 1st and 2nd number to registers for adding
	mov		ebx, second_num
	sub		eax, ebx			;subtract ebx to eax, results in eax
	mov		subtractResult, eax
	mov		eax, first_num		;print out results
	call	WriteDec
	mov		edx, OFFSET subtracting
	call	WriteString
	mov		eax, second_num
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, subtractResult
	call	WriteDec
	call	CrLf

;calculate multiply
	mov		eax, first_num
	mov		ebx, second_num
	mul		ebx					;multiply eax by ebx, results in eax
	mov		multiResult, eax
	mov		eax, first_num		;print out results
	call	WriteDec
	mov		edx, OFFSET multiplying
	call	WriteString
	mov		eax, second_num
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, multiResult
	call	WriteDec
	call	CrLf

;calculate dividing and remainder
	mov		eax, first_num
	;cdq		; make eax from double to quad word
	mov		edx, 0				;make edx zero to avoif divison problems
	mov		ebx, second_num
	div		ebx					;eax divided by ebx
	mov		divideResult, eax
	mov		remainResult, edx
	mov		eax, first_num		;print results
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString
	mov		edx, OFFSET dividing
	call	WriteString
	mov		edx, OFFSET space
	call	WriteString
	mov		eax, second_num
	call	WriteDec
	mov		edx, OFFSET equals
	call	WriteString
	mov		eax, divideResult	;print quotient
	call	WriteDec
	mov		edx, OFFSET remainder
	call	WriteString
	mov		eax, remainResult
	call	WriteDec
	call	CrLf
	jmp		Repeating

;calculate dividing as floating point to .001
	

SmallBig:								;if second_number > first_number, skip to here and display error prompt
	mov		edx, OFFSET validate2
	call	WriteString
	call	CrLf
	jmp		Repeating

Repeating:							;checks if the user want to repeat or not
	mov		edx, OFFSET validate1
	call	WriteString
	call	ReadInt					;reads in the next integer
	mov		repeatOrNot, eax
	cmp		repeatOrNot, 0
	je		Start					;if repeatOrNot is 0, then repeat


Ending:
;say goodbye
	mov		edx, OFFSET goodbye			;offset of variable in memory
	call	WriteString
	call	CrLf						

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
