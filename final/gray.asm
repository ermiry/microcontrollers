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
GRAY equ 0x40 

START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    MOVLW d'255'
    MOVWF TRISA 
    CLRF TRISB
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
    MOVF PORTA,W
    MOVWF GRAY
    BCF STATUS,C
    RRF GRAY
    XORWF GRAY,F
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    ; BINARIO
    MOVLW 'b'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'i'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'n'
    MOVWF PORTD
    CALL exec
    
     BCF PORTC,0		;command mode
    CALL time
    
    ; DAR UN ESPACIO ENTRE PALABRA Y NUMERO
    ; MOVER A ESTA POSICION EN EL DISPLAY
    MOVLW 0x88		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    ; IMRPIMIR ENTRADA EN EL PUERTO A - BINARIO - DIP SWITCH
    BTFSS PORTA,7
    CALL print0
    BTFSC PORTA,7
    CALL print1
    
    BTFSS PORTA,6
    CALL print0
    BTFSC PORTA,6
    CALL print1
    
    BTFSS PORTA,5
    CALL print0
    BTFSC PORTA,5
    CALL print1
    
    BTFSS PORTA,4
    CALL print0
    BTFSC PORTA,4
    CALL print1
    
    BTFSS PORTA,3
    CALL print0
    BTFSC PORTA,3
    CALL print1
    
    BTFSS PORTA,2
    CALL print0
    BTFSC PORTA,2
    CALL print1
    
    BTFSS PORTA,1
    CALL print0
    BTFSC PORTA,1
    CALL print1
    
    BTFSS PORTA,0
    CALL print0
    BTFSC PORTA,0
    CALL print1
    
   
   ; RESETEAR EL DISPLAY 
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC0		;LCD position
    MOVWF PORTD
    CALL exec

    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW 'g'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'r'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    
    MOVLW 'y'
    MOVWF PORTD
    CALL exec
      
    BCF PORTC,0		;command mode
    CALL time
    
    ; DAR UN ESPACIO ENTRE PALABRA Y NUMERO
    ; MOVER A ESTA POSICION EN EL DISPLAY
    MOVLW 0xC8		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    ; IMPRIMIR EL VALOR DE GRAY EN EL DISPLAY
    BTFSS GRAY,7
    CALL print0
    BTFSC GRAY,7
    CALL print1
    
    BTFSS GRAY,6
    CALL print0
    BTFSC GRAY,6
    CALL print1
    
    BTFSS GRAY,5
    CALL print0
    BTFSC GRAY,5
    CALL print1
    
    BTFSS GRAY,4
    CALL print0
    BTFSC GRAY,4
    CALL print1    
    
    BTFSS GRAY,3
    CALL print0
    BTFSC GRAY,3
    CALL print1
    
    BTFSS GRAY,2
    CALL print0
    BTFSC GRAY,2
    CALL print1
    
    BTFSS GRAY,1
    CALL print0
    BTFSC GRAY,1
    CALL print1
    
    BTFSS GRAY,0
    CALL print0
    BTFSC GRAY,0
    CALL print1    
      
     ; RESETEAR DISPLAY
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
        
    GOTO INICIO

; imprimir un 0
print0
    MOVLW 0x30
    MOVWF PORTD
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    nop
    RETURN
  
; imprimir un 1  
print1
    MOVLW 0x31
    MOVWF PORTD
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    nop
    RETURN
    
; ACTUALIZAR DISPLAY
; si no llamo a tiemp, hay errores en la impresion del display
exec
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    RETURN

; funcion de loop de tiempo
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
			
    END