#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivo todo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
 i equ 0x30
 j equ 0x31
 k equ 0x32
;inicio del programa: 
START
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0 
MOVLW b'00000000' ;Establecer puerto B como salida (los 8 bits del puerto)
MOVWF TRISB 
BCF STATUS, RP0 ;Regresar al banco 0
 ;BCF PORTB, 3
 ;BCF PORTB, 1
 ;BCF PORTB, 2
 ;BCF PORTB, 4
 ;BCF PORTB, 5
 ;BCF PORTB, 6
 ;BCF PORTB, 7
 
inicio
BSF PORTB, 0
CALL tiempo
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 

BCF PORTB, 0
CALL tiempo
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
GOTO inicio
 
tiempo:MOVLW d'252'
       MOVWF i
iloop: MOVLW d'104';
       MOVWF j
jloop: MOVLW d'4';
       MOVWF k
       nop
       nop
       nop
kloop: DECFSZ k, f
       GOTO kloop
       DECFSZ j,f
       GOTO jloop
       nop
       nop
       nop
       nop
       DECFSZ i,f
       GOTO iloop
       RETURN
 
 

;salir de la rutina de tiempo y regresar al 
			;valor de contador de programa
			
    END