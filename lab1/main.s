; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020
; Este programa espera o usuário apertar a chave USR_SW1.
; Caso o usuário pressione a chave, o LED1 piscará a cada 0,5 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
; ========================

; -------------------------------------------------------------------------------
; Área de Dados - Declarações de variáveis
		AREA  DATA, ALIGN=2
		; Se alguma variável for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a variável <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma variável de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posição da RAM		

; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a função Start a partir de 
			                        ; outro arquivo. No caso startup.s
									
		; Se chamar alguma função externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; função <func>
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
; Função main()
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