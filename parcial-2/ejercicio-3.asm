#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF       
RES_VECT  CODE    0x0000            
    GOTO    START                   
MAIN_PROG CODE                      
 i equ 0x30
 j equ 0x31
 k equ 0x32
 x equ 0x33
 y equ 0x34
 z equ 0x36
START
MOVLW 0x07 
MOVWF CMCON
BCF STATUS, RP1 
BSF STATUS, RP0 
MOVLW b'00000010' 
MOVWF TRISB 
BCF STATUS, RP0  
#define led PORTB, 0
#define btn PORTB, 1

inicio
 
BSF led
BTFSS btn
call tiempo1
BTFSC btn
call tiempo1
nop
nop
nop
BCF led
BTFSS btn
call tiempo
BTFSC btn
call tiempo1
nop
GOTO inicio
 
tiempo:MOVLW d'252'
       MOVWF i
iloop: MOVLW d'104'
       MOVWF j
jloop: MOVLW d'4'
       MOVWF k
       nop
       nop
       nop
kloop: DECFSZ k, f
       GOTO kloop
       DECFSZ j, f
       GOTO jloop
       nop
       nop
       nop
       nop
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
       RETURN
tiempo1:MOVLW d'252'
       MOVWF x
xloop: MOVLW d'104';
       MOVWF y
yloop: MOVLW d'10';
       MOVWF z
       nop
       nop
       nop
       nop
zloop: DECFSZ z, f
       GOTO zloop
       DECFSZ y, f
       GOTO yloop
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
       DECFSZ x,f
       GOTO xloop
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
       RETURN
    END