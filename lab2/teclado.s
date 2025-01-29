; matrix_keyboard.s
; Desenvolvido para a placa EK-TM4C1294XL
; Template by Prof. Guilherme Peron - 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instru??es do tipo Thumb-2
; -------------------------------------------------------------------------------
		
; Declara??es EQU - Defines
;<NOME>         EQU <VALOR>
; ========================
COFRE_FECHANDO 	EQU 2
TABUADA_ADDR	EQU 0x20004000

; -------------------------------------------------------------------------------
; ?rea de Dados - Declara??es de vari?veis
		AREA  DATA, ALIGN=2
		; Se alguma vari?vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari?vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari?vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi??o da RAM		

; -------------------------------------------------------------------------------
; ?rea de C?digo - Tudo abaixo da diretiva a seguir ser? armazenado na mem?ria de 
;                  c?digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun??o do arquivo for chamada em outro arquivo
		; EXPORT <func>				; Permite chamar a fun??o a partir de outro arquivo
		EXPORT MapMatrixKeyboard
		
		; Se chamar alguma fun??o externa	
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma fun??o de outro
		IMPORT Build_String
		IMPORT PortM_Output
		IMPORT PortM_Input
		IMPORT PortL_Input
		IMPORT LCD_PrintString
		IMPORT SysTick_Wait1ms
		IMPORT SysTick_Wait1us
		IMPORT PortM_Change_Dir
			
; -------------------------------------------------------------------------------

; Fun??o MapMatrixKeyboard
; Mapeia o teclado matricial
; Par?metro de entrada:
; Par?metro de sa?da:
MapMatrixKeyboard
	PUSH {LR}
	
	MOV R0, #2_00000111		; Todas as colunas como entrada
	BL PortM_Change_Dir
	
	; -----------------------------------------------------------
	MOV R0, #2_00010111		; Iterando sobre a primeira coluna
	BL PortM_Change_Dir		; Configura a coluna varrida como saída
	
	MOV R0, #2_00000111		; Passa 0 na coluna varrida
	BL PortM_Output
	
	MOV R0, #50
	BL SysTick_Wait1ms
	
	BL PortL_Input
	
	CMP R0, #2_1110			; Numero 1 foi pressionado
	BEQ DIGIT_1
	
	CMP R0, #2_1101			; Numero 4 foi pressionado
	BEQ.W DIGIT_4
	
	CMP R0, #2_1011			; Numero 7 foi pressionado
	BEQ.W DIGIT_7

	
	; -----------------------------------------------------------
	MOV R0, #2_00100111		; Iterando sobre a segunda coluna
	BL PortM_Change_Dir
	MOV R0, #2_00000111
	BL PortM_Output

	MOV R0, #50
	BL SysTick_Wait1ms

	BL PortL_Input
	
	CMP R0, #2_1110			; Numero 2 foi pressionado
	BEQ DIGIT_2
	
	CMP R0, #2_1101			; Numero 5 foi pressionado
	BEQ.W DIGIT_5
	
	CMP R0, #2_1011			; Numero 8 foi pressionado
	BEQ.W DIGIT_8
	
	CMP R0, #2_0111			; Numero 0 foi pressionado
	BEQ DIGIT_0
	; -----------------------------------------------------------
	
	; -----------------------------------------------------------
	MOV R0, #2_01000111		; Iterando sobre a terceira coluna
	BL PortM_Change_Dir
	MOV R0, #2_00000111
	BL PortM_Output
	
	MOV R0, #50
	BL SysTick_Wait1ms
	
	BL PortL_Input
	
	CMP R0, #2_1110			; Numero 3 foi pressionado
	BEQ DIGIT_3
	
	CMP R0, #2_1101			; Numero 6 foi pressionado
	BEQ DIGIT_6
	
	CMP R0, #2_1011			; Numero 9 foi pressionado
	BEQ.W DIGIT_9
	; -----------------------------------------------------------
	
	MOV R0, #50
	BL SysTick_Wait1ms
	; -----------------------------------------------------------
	
	POP {LR}
	BX LR

; Funções DIGIT_X
; Tratam a resposta do sistema para cada tecla pressionada
; Parametro de entrada: N?o tem
; Parametro de saída: R6 -> O dígito inserido
Multiplica
	STR R6, [R0]
	MUL R7, R5, R6
	BL Build_String
	BL Debouncing			; Trata o bouncing da tecla via software
	BX LR
	
DIGIT_0
	PUSH {R0}
	
	MOV R5, #0x0			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_1
	PUSH {R0}
	
	MOV R5, #0x1			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_2
	PUSH {R0}
	
	MOV R5, #0x2			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_3
	PUSH {R0}
	
	MOV R5, #0x3			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_4
	PUSH {R0}
	
	MOV R5, #0x04		; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_5
	PUSH {R0}
	
	MOV R5, #0x5			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_6
	PUSH {R0}
	
	MOV R5, #0x6			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_7
	PUSH {LR, R0}
	
	MOV R5, #0x7			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_8
	PUSH {R0}
	
	MOV R5, #0x8			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

DIGIT_9
	PUSH {R0}
	
	MOV R5, #0x9			; Guarda o d?gito inserido
	LDR R0, =TABUADA_ADDR
	ADD R0, R0, R5
	
	LDRB R6, [R0]
	ADD R6, R6, #1
	CMP R6, #0xA
	BLT Multiplica
	MOV R6, #0
	BL Multiplica
	
	POP {R0}				; Retorna ap?s d?gito inserido ter sido guardado e impresso
	BX LR

; Função Debouncing
; Trata o bouncing da tecla aguardando um tempo fixo (0,5s)
; Parametro de entrada: Não tem
; Parametro de saída: Não tem
Debouncing
	MOV R0, #20
	BL SysTick_Wait1ms
	
	BX LR

; Definição dos textos do LCD
DIGIT_0_STR	DCB "0", 0
DIGIT_1_STR	DCB "1", 0
DIGIT_2_STR	DCB "2", 0
DIGIT_3_STR	DCB "3", 0
DIGIT_4_STR	DCB "4", 0
DIGIT_5_STR	DCB "5", 0
DIGIT_6_STR	DCB "6", 0
DIGIT_7_STR	DCB "7", 0
DIGIT_8_STR	DCB "8", 0
DIGIT_9_STR	DCB "9", 0
DIGIT_A_STR	DCB "A", 0
DIGIT_B_STR	DCB "B", 0
DIGIT_C_STR	DCB "C", 0
DIGIT_D_STR	DCB "D", 0

DIGIT_AST_STR DCB "*", 0
; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN					; Garante que o fim da se??o est? alinhada 
    END						; Fim do arquivo