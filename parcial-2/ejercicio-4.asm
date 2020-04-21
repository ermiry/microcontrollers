#include "p16F628a.inc"

 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF 

RES_VECT    CODE    0x0000
    GOTO START

MAIN_PROG CODE

x equ   0x30
z equ   0x31

; inicio del programa
START
    MOVLW 0x07
    MOVWF CMCON

    BCF STATUS, RP1
    BSF STATUS, RP2
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0


    MOVLW d'7'
    MOVWF z
    MOVLW d'1'
    MOVWF x

    LOOP
        ADDWF x, 1
        MOVFW x

        DECF z
        BTFSC z, 0
        GOTO LOOP
        DECF z
        BTFSC z, 1
        GOTO LOOP
        DECF z
        BTFSC z, 2
        GOTO LOOP
        DECF z
        BTFSC z, 3
        GOTO LOOP


END