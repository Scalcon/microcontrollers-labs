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
; Função main()
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