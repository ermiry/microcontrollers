#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuraci�n del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
 i equ 0x30
 j equ 0x31
 k equ 0x32
 
 ; declarar variable temporal
 A equ 0x30
 TEMP equ 0X31
 
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
    MOVWF PORTB

    ; input en el puerto A
    ; copiar valor de puerto A a memoria 0x30 (temp)
    ; right shift 1 vez al puerto A
    ; XOR nuevo valor de puerto A con valor en memoria 0x30
    ; mover el relsultado para ser desplegador a puerto B
    
    ;BSF PORTB, 0
    BSF A, 0
    BSF A, 1
    BSF A, 2
    BSF A, 3
    BSF A, 4
    BSF A, 5
    BSF A, 6
    BSF A, 7
     
    MOVLW b'00000000'
    MOVWF TEMP

    ; input en el puerto A
    ; MOVLW b'00000010'
    ; MOVWF PORTA

    ; copio valor de puerto A a temporal
    ; MOVLW PORTA
    ; MOVWF temp
    MOVF A, 0
    MOVWF TEMP

    ; right shift al valor del puerto A
    RRF A, 0

    ; XOR de PORTA con temp
    ; MOVLW PORTA
    ; MOVF PORTA, W
    XORWF TEMP, 0

    ; mover el resultado del XOR al puerto B para desplegar
    MOVWF PORTB
    CALL tiempo
    goto inicio

tiempo:MOVLW d'164'
       MOVWF i
iloop: MOVLW d'80';
       MOVWF j
jloop: MOVLW d'5';
       MOVWF k
kloop: DECFSZ k, f
       GOTO kloop
       DECFSZ j, f
       GOTO jloop
       DECFSZ i,f
       GOTO iloop
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
       NOP
       NOP
       NOP
       NOP
       RETURN

   
    END