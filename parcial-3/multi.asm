  
#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
 
;inicio del programa:
START
BSF STATUS, RP0 ;Ingreso al banco 1
CLRF TRISB  ;puerto B salida
BSF TRISA,1 ; pin 1 puerto A entrada
BCF STATUS, RP0 ;Regresar al banco 0
 

; declarar variable temporal
A equ 0x30
E equ 0X31
R equ 0X32
 
inicio:
    MOVLW b'00000000'
    MOVWF A
    
    MOVLW b'00000000'
    MOVWF E
    
    MOVLW b'00000000'
    MOVWF R
    
    MOVLW b'00000000'
    MOVWF PORTB
    
    BSF A, 0
    BSF A, 1
    BSF A, 2
    BSF A, 3
;    BSF A, 4
;    BSF A, 5
;    BSF A, 6
;    BSF A, 7
    
    BSF E, 0
    BSF E, 1
    BSF E, 2
    BSF E, 3
;    BSF E, 4
;    BSF E, 5
;    BSF E, 6
;    BSF E, 7
    

goto mult

mult:
    MOVF A, 0
    BTFSC E, 0
    ADDWF PORTB
    BCF STATUS, C
    RRF E, 1
    BCF STATUS, C
    RLF A, 1
    MOVF E, 1
    BTFSS STATUS, Z
    GOTO mult
    GOTO resultado
    
;    mult:
;	MOVF A, 0
;;	ADDLW R
;;	ADDLW PORTB
;	ADDWF PORTB, 0
;	MOVWF PORTB
;	DECFSZ E, 1
;	goto mult
;	goto resultado
    
    resultado:
;	MOVF R, 0
;	MOVWF PORTB
	NOP
	NOP
			
END