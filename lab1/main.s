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
		IMPORT	SysTick_Wait
		IMPORT  GPIO_Init
		IMPORT	StoreDisplayAddress
		IMPORT  DisplayValue	
		IMPORT  CheckStepButton
		IMPORT  CheckDirectionButton
		IMPORT	SYSCTL_RCGCGPIO_R
		IMPORT	SYSCTL_PRGPIO_R
		IMPORT PortJ_Input

			
; -------------------------------------------------------------------------------
; Fun��o main()
Start

	BL PLL_Init                  
	BL SysTick_Init
	BL GPIO_Init                 

	BL StoreDisplayAddress

    MOV R2, #0                    
    MOV R3, #1                    
    MOV R6, #1
	MOV R7, #1
	MOV R8, #0

MainLoop
    
    BL DisplayValue
	
ButtonPress
	BL PortJ_Input
	CMP R0, #2_00000011
	BEQ NoButtonPress
	
    BL CheckStepButton     
    BL CheckDirectionButton     
	
NoButtonPress	
    ADD R8, R8, R6, LSL #0        
    CMP R8, #100
    BGE ResetIncreasing
	CMP R8, #0
	BLS ResetDecreasing
ContinueCounting
    B MainLoop

ResetIncreasing
	MOV R8, #0
	BL ContinueCounting
ResetDecreasing
	MOV R8, #99
	BL ContinueCounting

    END