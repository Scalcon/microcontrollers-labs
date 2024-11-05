; Exemplo.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 12/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
;<NOME>         EQU <VALOR>
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

; -------------------------------------------------------------------------------
; Função main()
Start  
; Comece o código aqui <======================================================

;	MOV R0, #65 ; A ;
;	
;	MOV R1, #0X1B00
;	MOVT R1, #0X1B00 ; B ;
;	
;	MOV R2, #0X5678
;	MOVT R2, #0X1234 ; C ;
;	
;	MOV R4, #0X0040
;	MOVT R4, #0X2000 ; R4 BASE ;
;	STR R0, [R4] ; D ;
;	
;	STR R1, [R4, #4] ; E ;
;	
;	STR R2, [R4, #8] ; F ;
;	
;	MOV R5, #0X0001
;	MOVT R5, #0X000F
;	STR R5, [R4, #12] ; G ;
;	
;	MOV R5, #0X00CD
;	STRB R5, [R4, #6] ; H ;
;	
;	LDR R7, [R4] ; I ;
;	
;	LDR R8, [R4, #8] ; J ;
;	
;	MOV R9, R7 ; K ;

;	MOV R4, #0X55
;	ANDS R0, R4, #0XF0 ; A ;
;	
;	MOV R4, #0XCC
;	ANDS R1, R4, #0X33 ; B ;
;	
;	MOV R4, #0X80
;	ORRS R2, R4, #0X37 ; C ;
;	
;	MOV R4, #0XFFFF
;	MOV R5, #0XABCD
;	MOVT R5, #0XABCD
;	BICS R3, R5, R4 ; D ;

	MOV R0, #0X2BD
	LSRS R1, R0, #5 ; A ;
	
	MOV R0, #0X7D43
	NEG R0, R0
	ASRS R2, R0, #4
	
	
	NOP
    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo
