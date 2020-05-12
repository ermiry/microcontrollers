#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuraci?n del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

; declarar variable temporal
A equ 0x30
E equ 0X31
 
;inicio del programa:
START
BSF STATUS, RP0 ;Ingreso al banco 1
CLRF TRISB  ;puerto B salida
BSF TRISA,1 ; pin 1 puerto A entrada
BCF STATUS, RP0 ;Regresar al banco 0
 

inicio:
    MOVLW b'00000000'
    MOVWF A
    
    MOVLW b'00000000'
    MOVWF E
    
    MOVLW b'00000000'
    MOVWF PORTB
    
    BSF A, 0
    BSF A, 1
;    BSF A, 2
;    BSF A, 3
;    BSF A, 4
;    BSF A, 5
;    BSF A, 6
;    BSF A, 7
    
    BSF E, 0
    BSF E, 1
    BSF E, 2
;    BSF E, 3
;    BSF E, 4
;    BSF E, 5
;    BSF E, 6
;    BSF E, 7
    
    ; restart A - E
    MOVF E, 0
    SUBWF A, 0
    
    BTFSS STATUS, Z
    goto checa	    ; son diferentes
    goto zero	    ; si son iguales - Z es 1
    
; checar si el resultado fue positivo o negativo
checa:
    BTFSS STATUS, C
    goto neg
    goto pos
    NOP
   
; el resultado es positivo, A es mas grande
pos:
    MOVWF PORTB	    ; resultado de la resta
    MOVLW b'00000001'
    MOVWF PORTB	    ; prender led
    NOP
    goto inicio
    
neg:
    MOVWF PORTB	    ; resultado de la resta
    MOVLW b'00000010'
    MOVWF PORTB	    ; prender led
    NOP
    goto inicio

zero:
    MOVWF PORTB	    ; resultado de la resta
    MOVLW b'00000100'
    MOVWF PORTB	    ; prender led
    NOP
    goto inicio
    
END