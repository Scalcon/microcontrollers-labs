; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020
; Este programa espera o usu�rio apertar a chave USR_SW1.
; Caso o usu�rio pressione a chave, o LED1 piscar� a cada 0,5 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun��o Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma fun��o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun��o <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms			
		IMPORT  GPIO_Init
        IMPORT  PortN_Output
        IMPORT  PortJ_Input	
		IMPORT  DisplayValue	
		IMPORT  CheckStepButton
		IMPORT  CheckDirectionButton
		IMPORT	SYSCTL_RCGCGPIO_R
		IMPORT	SYSCTL_PRGPIO_R
	
		IMPORT	GPIO_PORTA_AHB_DIR_R
		IMPORT	GPIO_PORTB_AHB_DIR_R

; -------------------------------------------------------------------------------
; Fun��o main()
Start

	BL PLL_Init                  
	BL SysTick_Init
	BL GPIO_Init                 

    LDR R0, =SYSCTL_RCGCGPIO_R    
    MOV R1, #0x23                 
    STR R1, [R0]

WaitForClock
    LDR R0, =SYSCTL_PRGPIO_R
    LDR R1, [R0]
    TST R1, #0x23
    BEQ WaitForClock

    LDR R0, =GPIO_PORTA_AHB_DIR_R
    MOV R1, #0xFF                 
    STR R1, [R0]

    LDR R0, =GPIO_PORTB_AHB_DIR_R
    MOV R1, #0x30                
    STR R1, [R0]

    MOV R2, #0                    
    MOV R3, #1                    
    MOV R4, #1                    

MainLoop
    
    BL DisplayValue 
    BL CheckStepButton     
    BL CheckDirectionButton     
	
    ADD R2, R2, R3, LSL #0        
    CMP R2, #100
    BLT ContinueCounting
    MOV R2, #0                     
ContinueCounting
    B MainLoop

    END