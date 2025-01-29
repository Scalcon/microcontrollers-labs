; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; Ver 1 19/03/2018
; Ver 2 26/08/2018
; Este programa deve esperar o usu?rio pressionar uma chave.
; Caso o usu?rio pressione uma chave, um LED deve piscar a cada 1 segundo.

; -------------------------------------------------------------------------------
        THUMB                        ; Instru??es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara??es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
; Defini??es de Valores
INVALID_DIGIT			EQU 256 ; Representa um d?gito inv?lido do teclado matricial
INVALID_PW_CHAR			EQU -1	; Representa um caractere impossível de estar na senha

INICIO  				EQU 0
CONFIG_SENHA 			EQU 1
COFRE_FECHANDO 			EQU 2
COFRE_FECHADO 			EQU 3
COFRE_ABRINDO           EQU 4
COFRE_TRAVADO           EQU 5
DESTRAVA_COFRE          EQU 6
CONFIG_SENHA_MESTRA     EQU 7

TABUADA_ADDR			EQU 0x20004000



; -------------------------------------------------------------------------------
; ?rea de Dados - Declara??es de vari?veis
		AREA  DATA, ALIGN=2
		; Se alguma vari?vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari?vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari?vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi??o da RAM		
PASSWORDS SPACE 8			; 4 bytes para a senha do usuário e 4 bytes para a senha mestra
; -------------------------------------------------------------------------------
; ?rea de C?digo - Tudo abaixo da diretiva a seguir ser? armazenado na mem?ria de 
;                  c?digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun??o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun??o Start a partir de 
			                        ; outro arquivo. No caso startup.s
		EXPORT Pisca_Transistor_PP5
		EXPORT Build_String
		
									
		; Se chamar alguma fun??o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma 
									; fun??o <func>
		IMPORT PLL_Init
		IMPORT SysTick_Init
		IMPORT SysTick_Wait1ms			
		
		IMPORT GPIO_Init
		IMPORT PortA_Output
		IMPORT PortP_Output
		IMPORT PortQ_Output
			
		IMPORT LCD_Init
		IMPORT LCD_Line2
		IMPORT LCD_Reset
		IMPORT LCD_PrintString
		
		IMPORT MapMatrixKeyboard
		IMPORT LED_Output

inicio_string 	DCB "Tabuada do ", 0
char_multi 		DCB " X ", 0
char_equal 		DCB " = ", 0
char_n			DCB "n", 0
char_m			DCB "m", 0
; -------------------------------------------------------------------------------
; Fun??o main()
Start  		
	BL PLL_Init				; Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init			; Chama a subrotina para inicializar o SysTick
	BL GPIO_Init			; Chama a subrotina que inicializa os GPIO
	
	LDR R0, =TABUADA_ADDR	; Guarda na RAM valores iniciais da tabuada, do 0 ao 9
	MOV R6, #9
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0], #1
	
	STRB R6, [R0]
	
	BL LCD_Init				; Chama a subrotina que inicializa o LCD
	BL EstadoInicial
	
MainLoop
	BL MapMatrixKeyboard
	B MainLoop

EstadoInicial
	PUSH {LR}
	BL LCD_Reset
	LDR R4, =inicio_string ;R4 guarda as mensagens pra mostrar no display
	BL LCD_PrintString ; imprime mensagem
	LDR R4, =char_n
	BL LCD_PrintString
	
	BL LCD_Line2
	
	LDR R4, =char_n
	BL LCD_PrintString
	LDR R4, =char_multi
	BL LCD_PrintString
	LDR R4, =char_m
	BL LCD_PrintString
	LDR R4, =char_equal
	BL LCD_PrintString
	
	MOV R0,	#500
	BL SysTick_Wait1ms
	
	POP {LR}
	BX LR

Pisca_Transistor_PP5
	MOV R0, #2_00100000
	PUSH {LR}
	BL PortP_Output				 ; chama a subrotina para ativar o transistor
	MOV R0, #500
	BL SysTick_Wait1ms
	MOV R0, #2_00000000
	BL PortP_Output				 ; chama a subrotina para desativar o transistor
	MOV R0, #500
	BL SysTick_Wait1ms
	POP {LR}
	BX LR

Build_String
	PUSH {LR}
	BL LCD_Reset
	LDR R4, =inicio_string  ;R4 guarda as mensagens pra mostrar no display
	BL LCD_PrintString 		; imprime mensagem

	MOV R4, #0
	MOV R3, R5
	ADD R3, #0x30 		;transforma a tecla pressionada em string
	BL LCD_PrintString
	
	BL LCD_Line2
	BL LCD_PrintString
	
	LDR R4, =char_multi
	BL LCD_PrintString
	
	MOV R4, #0
	MOV R3, R6
	ADD R3, #0x30 		;transforma a tecla pressionada em string
	BL LCD_PrintString
	
	LDR R4, =char_equal
	BL LCD_PrintString

	MOV R4, #0
	MOV R3, R7
	ADD R3, #0x30 		;transforma a tecla pressionada em string
	BL LCD_PrintString
	
	MOV R0,	#5000
	BL SysTick_Wait1ms
	
	POP {LR}
	BX LR

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se??o est? alinhada 
    END                          ;Fim do arquivo