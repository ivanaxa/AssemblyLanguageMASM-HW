TITLE Project 02 Fibonacci Numbers     (Project02.asm)

; Author: Ivan A. Xa
; CS271-400/ Project 02                Date:January 29, 2017
; Description: A program that prints out Fibonacci number sequences

INCLUDE Irvine32.inc

; (insert constant definitions here)
UPPER_LIMIT = 46
LOWER_LIMIT = 1
MAXCHARACTERS = 80
.data

project_name	BYTE	"Fibonacci Numbers", 0
author			BYTE	"by Ivan A. Xa", 0
askName			BYTE	"What is your name? ", 0
username		BYTE	MAXCHARACTERS DUP(?)
counter			DWORD	0

askNumber		BYTE	"Please enter an integer in range [1..46] inclusive.", 0
askline2		BYTE	"Fibonacci Terms: ", 0
error			BYTE	"Out of range. Enter a number in [1..46].", 0
numTerms		DWORD	?	;number of fibonacci terms to calculate
tempNum			DWORD	?	;temp number
separation		BYTE	"         ", 0

ending			BYTE	"Results by the one and only, Ivan A. Xa.", 0
goodbye			BYTE	"Goodbye ", 0



.code
main PROC

;display program title and author name
	mov		edx, OFFSET project_name
	call	WriteString
	call	CrLf
	mov		edx, OFFSET author
	call	WriteString
	call	CrLf

;ask the user for his/her name and greet him/her
	mov		edx, OFFSET askName
	call	WriteString
	mov		edx, OFFSET username
	mov		ecx, MAXCHARACTERS-1						;accept 79 character plus the ending 0
	call	ReadString

;ask user for an integer 1..46 inclusive
readNumber:
	mov		edx, OFFSET askNumber
	call	WriteString
	call	CrLf
	mov		edx, OFFSET	askline2
	call	WriteString
	call	ReadInt
	mov		numTerms, eax

;validate user input smaller ot greater 1..46
validation:
	cmp		numTerms, UPPER_LIMIT				;compare to 46, the highest limit
	jg		errorDisplay
	cmp		numTerms, LOWER_LIMIT					;compare to 1, the lowest limit
	jl		errorDisplay
	jmp		displayFibSequence			;if all good, then go to displaying the fib numbers!

errorDisplay:
	mov		edx, OFFSET error
	call	WriteString
	call	CrLf
	jmp		readNumber


;calculate and diaply all Fib numbers up to and including the nth term
;displayed 5 numbers per line with at least 5 spaces between terms
displayFibSequence:
	mov		eax, 1				
	mov		ebx, 0
	mov		tempNum, 0
	mov		ecx, numTerms			;counter

loop1:
	add		eax, tempNum
	mov		ebx, eax
	call	WriteDec
	mov		eax, tempNum
	mov		tempNum, ebx
	mov		edx, OFFSET separation	;print out space
	call	WriteString

	inc		counter					;incrementing the counter
	cmp		counter, 5				;if counter =5, print out a CrLf
	je		returnLine

	cmp		ecx, 0					;if ecx is 0 or less, end by jumping to GoodByeDisplay
	jle		goodByeDisplay
									;else loop again
continueLoop:	
	loop	loop1
	call	CrLf
	jmp		goodByeDisplay

returnLine:
	call	CrLf
	mov		counter, 0
	jmp		continueLoop

;display goodbye with user name
goodByeDisplay:
	mov		edx, OFFSET	ending
	call	WriteString
	call	CrLf
	mov		edx, OFFSET goodbye
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
