#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuraci�n del dispositivotodo en OFF y la frecuencia de oscilador
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
M equ 0X31
R equ 0X32
E equ 0x33
V equ 0x34
H equ 0x35
 
inicio:
    ; input
    MOVLW b'00000000'
    MOVWF A
    
    ; mask
    MOVLW b'00000000'
    MOVWF M
    
    ; resultado
    MOVLW b'00000000'
    MOVWF R
    
    ; auxiliar de multiplicacion
    MOVLW b'00000000'
    MOVWF E
    
    ; resultado de la multiplicacion
    MOVLW b'00000000'
    MOVWF V
    
    ; salida
    MOVLW b'00000000'
    MOVWF PORTB
    
    ; INPUT
;    BSF A, 0
;    BSF A, 1
;    BSF A, 2
;    BSF A, 3
    BSF A, 4
;    BSF A, 5
;    BSF A, 6
;    BSF A, 7
    
    ; INIT
    ; init mask with top most bit
    MOVLW b'10000000'
    MOVWF M
    
    goto loop
    
 loop:
    ; r |= m
    MOVF M, 0
    IORWF R, 1
    ; r * r
    ; mover R a registro aux para multi
    MOVF R, 0
    MOVWF E
    
    MOVF R, 0
    MOVWF H
    
    MOVLW b'00000000'
    MOVWF V
    
    CALL multi	; rxr
    
    ; comparar resultado
    ; rxr == a -> fin
    MOVF V, 0
    SUBWF A, 0
    BTFSS STATUS, Z
    goto checa	    ; son diferentes
    goto fin	    ; son iguales
    
; rxr > a
checa:
    BTFSS STATUS, C
    goto neg
    goto pos
    NOP

; r &= ~m
pos:
    COMF M, 0
    ANDWF R, 0
    MOVLW R
    
    BCF STATUS, C
    RRF M, 1
    
    goto loop
   
; error!
neg:
    MOVWF PORTB	    ; resultado de la resta
    goto loop
    
multi:
    MOVF H, 0
    BTFSC E, 0
    ADDWF V
    BCF STATUS, C
    RRF E, 1
    BCF STATUS, C
    RLF H, 1
    MOVF E, 1
    BTFSS STATUS, Z
    GOTO multi
    
    RETURN
  
; resultado de raiz cuadrada
fin:
    MOVF R, 0
    MOVWF PORTB
    NOP
    
			
END