#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
  
    GOTO    START

MAIN_PROG CODE                      ; let linker place main program

START

i equ 0x30
j equ 0x31
K equ 0x34

X equ 0x32
Y equ 0x33

START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    MOVLW d'255'
    MOVWF TRISA 
    MOVLW b'00000011'
    MOVWF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    BCF PORTC,1
    BCF PORTC,0
    
INITLCD
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    

INICIO	  
    BTFSC PORTB, 0
    CALL BTN1
    BTFSC PORTB, 1
     CALL BTN2
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    
    ; ME MUEVO A LA DERECHA PARA IMPRIMIR A - X
    BCF PORTC,0
    CALL time
    MOVLW 0x84
    MOVWF PORTD
    CALL exec
    BSF PORTC,0
    CALL time
    
    BTFSS X,7
    CALL print0
    BTFSC X,7
    CALL print1
    
    BTFSS X,6
    CALL print0
    BTFSC X,6
    CALL print1
    
    BTFSS X,5
    CALL print0
    BTFSC X,5
    CALL print1
    
    BTFSS X,4
    CALL print0
    BTFSC X,4
    CALL print1
    
    BTFSS X,3
    CALL print0
    BTFSC X,3
    CALL print1
    
    BTFSS X,2
    CALL print0
    BTFSC X,2
    CALL print1
    
    BTFSS X,1
    CALL print0
    BTFSC X,1
    CALL print1
    
    BTFSS X,0
    CALL print0
    BTFSC X,0
    CALL print1
    
    ; TERMINA A
    
    BCF PORTC,0
    CALL time
    MOVLW 0xC0
    MOVWF PORTD
    CALL exec
    BSF PORTC,0
    CALL time
   
    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'W'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
   
     ; ME MUEVO A LA DERECHA PARA IMPRIMIR B
    BCF PORTC,0
    CALL time
    MOVLW 0xC4
    MOVWF PORTD
    CALL exec
    BSF PORTC,0
    CALL time
    
    BTFSS Y,7
    CALL print0
    BTFSC Y,7
    CALL print1
    
    BTFSS Y,6
    CALL print0
    BTFSC Y,6
    CALL print1
    
    BTFSS Y,5
    CALL print0
    BTFSC Y,5
    CALL print1
    
    BTFSS Y,4
    CALL print0
    BTFSC Y,4
    CALL print1    
    
    BTFSS Y,3
    CALL print0
    BTFSC Y,3
    CALL print1
    
    BTFSS Y,2
    CALL print0
    BTFSC Y,2
    CALL print1
    
    BTFSS Y,1
    CALL print0
    BTFSC Y,1
    CALL print1
    
    BTFSS Y,0
    CALL print0
    BTFSC Y,0
    CALL print1    
      
    MOVF X,0
    MOVWF K
   MOVF Y,0
   SUBWF K,1 ;i-W --- Se guarda en i
	
   BTFSS STATUS,Z
   GOTO continua
   GOTO prendeled1
   GOTO INICIO
 


print0
    MOVLW 0x30
    MOVWF PORTD
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    nop
    RETURN
    
MAYOR
   BCF PORTC,0		;command mode
   CALL time
    
   MOVLW 0xCE		;LCD position
   MOVWF PORTD
   CALL exec

   BSF PORTC,0		;data mode
   CALL time
   MOVLW  b'111110'
   MOVWF PORTD
   CALL exec
   RETURN
   
 MENOR
   BCF PORTC,0		
   CALL time
    
   MOVLW 0xCE		
   MOVWF PORTD
   CALL exec

   BSF PORTC,0		
   CALL time
   MOVLW b'111100'
   MOVWF PORTD
   CALL exec
   RETURN
   
  IGUAL
  BCF PORTC,0		
  CALL time
    
   MOVLW 0xCE		
   MOVWF PORTD
   CALL exec

   BSF PORTC,0
   CALL time
   MOVLW b'111101'
   MOVWF PORTD
   CALL exec
   RETURN
    
print1
    MOVLW 0x31
    MOVWF PORTD
    BSF PORTC,1		
    CALL time
    BCF PORTC,1
    CALL time
    nop
    RETURN
    
    
    
exec
    BSF PORTC,1		
    CALL time
    BCF PORTC,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN

 
prendeled1
CALL IGUAL 
 BCF STATUS,Z
 BCF STATUS,C
 BCF STATUS,1
 GOTO INICIO
 
continua
 BTFSC STATUS,C	    
 GOTO continua2
 GOTO prendeled2

prendeled2
CALL MENOR	   
 ;MOVLW d'0'
 ;MOVWF K
 GOTO INICIO
 
continua2
CALL MAYOR 
 BCF STATUS,Z
 BCF STATUS,C
 BCF STATUS,1
 ;MOVLW d'0'
; MOVWF K
 GOTO INICIO
 
    
BTN1
 MOVF PORTA, 0
    MOVWF X
    MOVWF K
    MOVLW b'00000000' 
    MOVWF PORTA
RETURN

BTN2
    MOVF PORTA, 0
    MOVWF Y
    BSF STATUS,C
   
   RETURN
    
			
    END