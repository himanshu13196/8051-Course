	ORG	0000h
	SJMP	START
	ORG	0003h
	LCALL	INT0_ISR
	RETI
	ORG	000Bh
	LCALL	T0_ISR
	RETI
	ORG	0013h
	LCALL	INT1_ISR
	RETI
	ORG	001Bh
	LCALL	T1_ISR
	RETI
	ORG	0023h
	LCALL	UART_ISR
	RETI
	ORG	0030h
START:
	MOV	A,#11111110b
	SETB	IT0	; Set External Interrupt 0 to be falling edge triggered
	SETB	EX0	; Enable External Interrut 0
	SETB	EA	; Enable Interrupt
LEFT:			
	CJNE	A,#01111111b,LOOP1
	JMP	RIGHT
LOOP1:
	MOV	P1,A
	RL	A	
	LCALL	DELAY
	SJMP	LEFT	
RIGHT:
	CJNE	A,#11111110b,LOOP2
	JMP	LEFT
LOOP2:
	MOV	P1,A
	RR	A	
	LCALL	DELAY
	SJMP	RIGHT
	
INT0_ISR:
	MOV	R1,#3
FLASH:
	MOV	P1,#00h
	LCALL	DELAY
	MOV	P1,#0FFh
	LCALL	DELAY
	DJNZ	R1,FLASH
	RET
T0_ISR:
	RET
INT1_ISR:
	RET
T1_ISR:
	RET
UART_ISR:
	RET

DELAY:	MOV	R5,#20	;R5*20 mS
D1:     MOV	R6,#40
D2:     MOV	R7,#249
	DJNZ	R7,$
 	DJNZ	R6,D2
  	DJNZ	R5,D1
   	RET
	END