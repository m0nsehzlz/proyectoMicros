	processor 16F877      ;Tipo de Procesador utilizar
	include <p16F877.inc> ;Libreria

;Definición de variables en memoria
val4 equ h'24'
cont5 equ 06h
cont3 equ 04h
cont10 equ 0Fh

;Retardo
valor1 equ h'21'
valor2 equ h'22'
valor3 equ h'23'
cte1 equ 20h 
cte2 equ 50h
cte3 equ 60h

cte5 equ 50h 
cte6 equ 50h
cte7 equ 70h


   ORG 0               
   GOTO INICIO 
   ORG 5
   
INICIO: 
		BSF STATUS,RP0  
       	BCF STATUS,RP1   
		
		; Configura el Puerto B como salida.
       	MOVLW h'00'       
       	MOVWF TRISB
		CLRF PORTB  
	
		; Configura el Puerto D como salida.
       	MOVLW h'00'       
       	MOVWF TRISD
		CLRF PORTD  

		;regresamos al banco 0
		BCF STATUS, RP0   

MAIN:	
		MOVLW cont5
		MOVWF val4
		GOTO BLINK
		

BLINK:	
		DECFSZ val4
		GOTO ALLOFF
		CLRF PORTB
		CLRF PORTD
		MOVLW cont3
		MOVWF val4
		GOTO DER

;Todos los leds apagados
ALLOFF:
		MOVLW h'00'
		MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO

; Todos los leds encendidos           

ALLON:  
		MOVLW h'ff'
	   	MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO
		GOTO BLINK

DER:
		DECFSZ val4
		GOTO DER_INIT
		CLRF PORTB
		CLRF PORTD
		MOVLW cont3
		MOVWF val4
		GOTO LONG

DER_INIT:
		MOVLW H'02'
		MOVWF PORTD
		CALL RETARDO
		MOVLW H'01'
		MOVWF PORTD
		CALL RETARDO
		MOVLW H'00'
		MOVWF PORTD
		MOVLW H'80'
		MOVWF PORTB
		CALL RETARDO

DER_A:
		RRF PORTB,1
		CALL RETARDO
		BTFSS PORTB,1
		GOTO DER_A
		MOVLW H'1'
		MOVWF PORTB
		CALL RETARDO
		MOVLW H'00'
		MOVWF PORTB
		GOTO DER
LONG:
		DECFSZ val4
		GOTO LONG_OFF
		CLRF PORTB
		CLRF PORTD
		MOVLW cont10
		MOVWF val4
		GOTO PAIR_IMPAIR

LONG_OFF:
		MOVLW h'00'
		MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO_LONG

; Todos los leds encendidos           

LONG_ON:  
		MOVLW h'ff'
	   	MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO_LONG
		GOTO LONG

PAIR_IMPAIR:
		DECFSZ val4
		GOTO PAIR
		CLRF PORTB
		CLRF PORTD
		GOTO MAIN
PAIR:
		MOVLW h'AA'
		MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO
		CLRF PORTB
		CLRF PORTD
IMPAIR:
		MOVLW h'55'
		MOVWF PORTB
		MOVWF PORTD
		CALL RETARDO
		CLRF PORTB
		CLRF PORTD
		GOTO PAIR_IMPAIR

RETARDO_LONG: 
     MOVLW cte5        
     MOVWF valor1      
seis: 
	 MOVWF cte6         
     MOVWF valor2      
cinco:  
	 MOVLW cte7
     MOVWF valor3
cuatro:  
	 DECFSZ valor3 
     GOTO cuatro 
     DECFSZ valor2
     GOTO cinco
     DECFSZ valor1   
     GOTO seis
     RETURN 


RETARDO: 
     MOVLW cte1        
     MOVWF valor1      
tres MOVWF cte2         
     MOVWF valor2      
dos  MOVLW cte3
     MOVWF valor3
uno  DECFSZ valor3 
     GOTO uno 
     DECFSZ valor2
     GOTO dos
     DECFSZ valor1   
     GOTO tres
     RETURN
     END 
