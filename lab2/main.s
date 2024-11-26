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
INVALID_PW_CHAR			EQU -1	; Representa um caractere imposs�vel de estar na senha

INICIO  				EQU 0
CONFIG_SENHA 			EQU 1
COFRE_FECHANDO 			EQU 2
COFRE_FECHADO 			EQU 3
COFRE_ABRINDO           EQU 4
COFRE_TRAVADO           EQU 5
DESTRAVA_COFRE          EQU 6
CONFIG_SENHA_MESTRA     EQU 7



; -------------------------------------------------------------------------------
; ?rea de Dados - Declara??es de vari?veis
		AREA  DATA, ALIGN=2
		; Se alguma vari?vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari?vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari?vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi??o da RAM		
PASSWORDS SPACE 8			; 4 bytes para a senha do usu�rio e 4 bytes para a senha mestra
; -------------------------------------------------------------------------------
; ?rea de C?digo - Tudo abaixo da diretiva a seguir ser? armazenado na mem?ria de 
;                  c?digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun??o do arquivo for chamada em outro arquivo	
        EXPORT Start                ; Permite chamar a fun??o Start a partir de 
			                        ; outro arquivo. No caso startup.s
		EXPORT ModificaSenhaMestra
		EXPORT DestravaCofre
		EXPORT Pisca_Transistor_PP5
									
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

;?Cofre aberto, digite nova senha para fechar o cofre?.
cofre_aberto DCB "8======D    ", 0
cofre_abrindo DCB "Cofre abrindo   ", 0
digite_senha DCB "Digite a senha  ", 0
string_vazia DCB "                ", 0
cofre_fechando DCB "Cofre fechando  ", 0
cofre_fechado DCB "Cofre fechado   ", 0
reset_senha_mestra DCB "Nova mestra     ", 0
senha_mestra_alterada DCB "Mestra alterada ", 0
cofre_travado DCB "Cofre travado   ", 0
digite_senha_mestra DCB "Digite mestra   ", 0 

; -------------------------------------------------------------------------------
; Fun??o main()
Start  		
	BL PLL_Init				; Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init			; Chama a subrotina para inicializar o SysTick
	BL GPIO_Init			; Chama a subrotina que inicializa os GPIO
	
	
	BL LCD_Init				; Chama a subrotina que inicializa o LCD
	MOV R6, #INVALID_DIGIT	; R6 usado para guardar o d?gito lido do teclado
	MOV R7, #0				; R7 usado para contar quantos d?gitos o usu?rio digitou
	MOV R5, #INICIO			; Seta o estado inicial para cofre aberto
	MOV R9, #0				; Contador para comparar a senha inserida com a senha na mem�ria
	MOV R10, #0				; Contador para contar a quantidade de acertos da senha
	LDR R8, =PASSWORDS		; R8 usado para apontar a posi��o da senha salva na mem�ria
	MOV R12, #0             ; Contador da quantidade de erros da senha

	MOV R11, #1
	STRB R11, [R8, #6]
	MOV R11, #2
	STRB R11, [R8, #7]
	MOV R11, #3
	STRB R11, [R8, #8]
	MOV R11, #4
	STRB R11, [R8, #9]
	
MainLoop
	CMP R5, #INICIO
	BEQ EstadoInicial
	CMP R5, #CONFIG_SENHA
	BEQ InserirSenha
	CMP R5, #COFRE_FECHANDO
	BEQ CofreFechando
	CMP R5, #COFRE_FECHADO
	BEQ CofreFechado
    CMP R5, #COFRE_ABRINDO
    BEQ CofreAbrindo
	CMP R5, #COFRE_TRAVADO
	BEQ CofreTravado
	CMP R5, #DESTRAVA_COFRE
	BEQ DestravaCofre
    CMP R5, #CONFIG_SENHA_MESTRA
    ;BEQ ModificaSenhaMestra
	
	B MainLoop

EstadoInicial
	BL LCD_Reset
	LDR R4, =cofre_aberto ;R4 guarda as mensagens pra mostrar no display
	BL LCD_PrintString ; imprime mensagem
	MOV R0, #5000	 ;seta o tempo que vai ficar a mensagem
	BL SysTick_Wait1ms ;wait
    B SolicitaSenha
	
SolicitaSenha
	MOV R7, #0
	BL LCD_Reset ;limpa o display
	LDR R4,=digite_senha ; muda a string que vai pro display
	BL LCD_PrintString ;imprime nova string
	MOV R0, #5000		 ; seta o tempo
	BL SysTick_Wait1ms
	BL LCD_Reset ;limpa o display
	MOV R5,#CONFIG_SENHA ; muda o estado do cofre
	
	B MainLoop

InserirSenha
	BL MapMatrixKeyboard
	CMP R6, #INVALID_DIGIT
	IT NE
		STRBNE R6, [R8, R7] 		; guarda a senha
	MOV R6, #INVALID_DIGIT		; Depois de contabilizado, invalida R6 para evitar erros

	CMP R7, #4					; Verifica se 4 d?gitos foram inseridos
	BLT InserirSenha			; Se n�o, volta para o inicio
	BHI SolicitaSenha
	
	CMP R5, #COFRE_FECHANDO			; Verifica se o estado do cofre ? fechando 
	BNE InserirSenha				; Se ainda n?o for, volta para configurar a senha
	B MainLoop
	
CofreFechando
	BL LCD_Reset ;limpa o display
	MOV R0, #1000		 ; seta o tempo  de 1s
	BL SysTick_Wait1ms
	LDR R4,=cofre_fechando ; muda a string que vai pro display
	BL LCD_PrintString 		;imprime nova string
	MOV R0, #5000		 ; seta o tempo de 5s
	BL SysTick_Wait1ms
	BL LCD_Reset
	MOV R5, #COFRE_FECHADO
	MOV R7, #0				; R7 usado para contar quantos d?gitos o usu?rio digitou
	
	B MainLoop

CofreFechado
	BL LCD_Reset
	LDR R4,=cofre_fechado ; muda a string que vai pro display
	BL LCD_PrintString ;imprime nova string
	MOV R0, #5000		 ; seta o tempo de 5s
	BL SysTick_Wait1ms
	
	B PedeSenhaFechado

CofreTravado
	BL LCD_Reset
	LDR R4,=cofre_travado ; muda a string que vai pro display
	BL LCD_PrintString ;imprime nova string
	BL LED_Output

	B MainLoop

CofreAbrindo
	BL LCD_Reset 			;limpa o display
	MOV R0, #1000		 	; seta o tempo  de 1s
	BL SysTick_Wait1ms
	LDR R4,=cofre_abrindo 	; muda a string que vai pro display
	BL LCD_PrintString 		;imprime nova string
	MOV R0, #5000		 	; seta o tempo de 5s
	BL SysTick_Wait1ms
	BL LCD_Reset
	MOV R5, #INICIO
	MOV R7, #0				; Zera R7
	MOV R10, #0				; Zera R10
	MOV R12, #0
	
	B MainLoop

DestravaCofre
	BL LCD_Line2				; Coloca o cursor no come�o da segunda linha
	
	LDR R4, =digite_senha_mestra		; Imprime a mensagem de digitar a senha
	BL LCD_PrintString
	
	MOV R0, #1000		 		; seta o tempo de 0,5s
	BL SysTick_Wait1ms
	
	BL LCD_Line2
	LDR R4, =string_vazia		; Imprime uma string vazia na segunda linha
	BL LCD_PrintString

	BL LCD_Line2			; Depois do cursor ser deslocado para o fim, posiciona de volta no come�o
	
	MOV R6, #INVALID_DIGIT	; Nenhum d�gito foi lido. Coloca R6 em estado inv�lido (reset)
	
	MOV R7, #5
	MOV R10, #0
	
	B ConferirSenhaMestra

ModificaSenhaMestra

	PUSH {LR}
	BL LCD_Reset
	POP {LR}
	LDR R4,=reset_senha_mestra ; muda a string que vai pro display
	PUSH {LR}
	BL LCD_PrintString ;imprime nova string
	POP {LR}
	MOV R0, #2000		 ; seta o tempo de 2s
	PUSH {LR}
	BL SysTick_Wait1ms
	POP {LR}
	
	PUSH {LR}
	BL LCD_Line2
	POP {LR}
	MOV R7, #5
	B DigitaSenhaMestra

PedeSenhaFechado
	BL LCD_Line2				; Coloca o cursor no come�o da segunda linha
	
	LDR R4, =digite_senha		; Imprime a mensagem de digitar a senha
	BL LCD_PrintString
	
	MOV R0, #1000		 		; seta o tempo de 0,5s
	BL SysTick_Wait1ms
	
	BL LCD_Line2
	
	LDR R4, =string_vazia		; Imprime uma string vazia na segunda linha
	BL LCD_PrintString

	BL LCD_Line2			; Depois do cursor ser deslocado para o fim, posiciona de volta no come�o
	
	MOV R7, #0				; Zera R7
	MOV R10, #0				; Zera R10
	
	MOV R6, #INVALID_DIGIT	; Nenhum d�gito foi lido. Coloca R6 em estado inv�lido (reset)
	
	B ConferirSenha

ConferirSenha
	BL MapMatrixKeyboard	; L� o d�gito pressionado no teclado e guarda em R6
	
	LDRB R9, [R8, R7] 			; coloca em R9 os digitos a senha
	CMP R6, R9
	ADDEQ R10, R10, #1			; incrementar contador de acertos se o digito inserido for igual o da mem�ria
	
	MOV R6, #INVALID_DIGIT		; Depois de contabilizado, invalida R6 para evitar erros
	MOV R9, #INVALID_PW_CHAR
	
	CMP R7, #4					; Verifica se 4 d?gitos foram inseridos
	BLT ConferirSenha			; Se n�o, volta para o inicio
    
	CMP R10, #4
	IT EQ
        MOVEQ R5, #COFRE_ABRINDO
	BEQ CofreAbrindo
		
	MOV R7, #0
	ADD R12, R12, #1
	CMP R12, #3
	BLT PedeSenhaFechado
    IT EQ
	    MOVEQ R5, #COFRE_TRAVADO	
    
    B MainLoop
	
ConferirSenhaMestra
	BL MapMatrixKeyboard	; L� o d�gito pressionado no teclado e guarda em R6
	
	LDRB R9, [R8, R7] 			; coloca em R9 os digitos a senha
	CMP R6, R9
	ADDEQ R10, R10, #1			; incrementar contador de acertos se o digito inserido for igual o da mem�ria
	
	MOV R6, #INVALID_DIGIT		; Depois de contabilizado, invalida R6 para evitar erros
	MOV R9, #INVALID_PW_CHAR
	
    CMP R7, #9					; Verifica se 4 d?gitos foram inseridos
	BLT ConferirSenhaMestra			; Se n�o, volta para o inicio

	CMP R10, #4
    ITE EQ
        MOVEQ R5, #COFRE_ABRINDO
        MOVNE R5, #DESTRAVA_COFRE
	B MainLoop
	
DigitaSenhaMestra
	PUSH {LR}
	BL MapMatrixKeyboard
	POP {LR}
	CMP R6, #INVALID_DIGIT
	IT NE
		STRBNE R6, [R8, R7] 		; guarda a senha
	MOV R6, #INVALID_DIGIT		; Depois de contabilizado, invalida R6 para evitar erros

	CMP R7, #9					; Verifica se 4 d?gitos foram inseridos
	BLT DigitaSenhaMestra			; Se n�o, volta para o inicio	
	BHI ModificaSenhaMestra
	BEQ SenhaMestraAlterada
	
SenhaMestraAlterada
	PUSH {LR}
	BL LCD_Reset
	POP {LR}
	LDR R4,=senha_mestra_alterada ; muda a string que vai pro display
	PUSH {LR}
	BL LCD_PrintString ;imprime nova string
	POP {LR}
	MOV R0, #2000		 ; seta o tempo de 2s
	PUSH {LR}
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

; -------------------------------------------------------------------------------------------------------------------------
; Fim do Arquivo
; -------------------------------------------------------------------------------------------------------------------------	
    ALIGN                        ;Garante que o fim da se??o est? alinhada 
    END                          ;Fim do arquivo