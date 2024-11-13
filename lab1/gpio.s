
; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 19/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instruções do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declarações EQU - Defines
; ========================
; Definições dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Definições dos Ports
; PORT J
GPIO_PORTJ_AHB_LOCK_R    	EQU    0x40060520
GPIO_PORTJ_AHB_CR_R      	EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R   	EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R    	EQU    0x4006052C
GPIO_PORTJ_AHB_DIR_R     	EQU    0x40060400
GPIO_PORTJ_AHB_AFSEL_R   	EQU    0x40060420
GPIO_PORTJ_AHB_DEN_R     	EQU    0x4006051C
GPIO_PORTJ_AHB_PUR_R     	EQU    0x40060510	
GPIO_PORTJ_AHB_DATA_R    	EQU    0x400603FC
GPIO_PORTJ     EQU    2_000000100000000
	

; PORT F
GPIO_PORTF_AHB_LOCK_R    	EQU    0x4005D520
GPIO_PORTF_AHB_CR_R      	EQU    0x4005D524
GPIO_PORTF_AHB_AMSEL_R   	EQU    0x4005D528
GPIO_PORTF_AHB_PCTL_R    	EQU    0x4005D52C
GPIO_PORTF_AHB_DIR_R     	EQU    0x4005D400
GPIO_PORTF_AHB_AFSEL_R   	EQU    0x4005D420
GPIO_PORTF_AHB_DEN_R     	EQU    0x4005D51C
GPIO_PORTF_AHB_PUR_R     	EQU    0x4005D510	
GPIO_PORTF_AHB_DATA_R    	EQU    0x4005D3FC
GPIO_PORTF               	EQU    2_000000000100000	
; PORT A
GPIO_PORTA_AHB_DATA_BITS_R EQU 0x40058000
GPIO_PORTA_AHB_DATA_R EQU 0x400583FC
GPIO_PORTA_AHB_DIR_R EQU 0x40058400
GPIO_PORTA_AHB_IS_R EQU 0x40058404
GPIO_PORTA_AHB_IBE_R EQU 0x40058408
GPIO_PORTA_AHB_IEV_R EQU 0x4005840C
GPIO_PORTA_AHB_IM_R EQU 0x40058410
GPIO_PORTA_AHB_RIS_R EQU 0x40058414
GPIO_PORTA_AHB_MIS_R EQU 0x40058418
GPIO_PORTA_AHB_ICR_R EQU 0x4005841C
GPIO_PORTA_AHB_AFSEL_R EQU 0x40058420
GPIO_PORTA_AHB_DR2R_R EQU 0x40058500
GPIO_PORTA_AHB_DR4R_R EQU 0x40058504
GPIO_PORTA_AHB_DR8R_R EQU 0x40058508
GPIO_PORTA_AHB_ODR_R EQU 0x4005850C
GPIO_PORTA_AHB_PUR_R EQU 0x40058510
GPIO_PORTA_AHB_PDR_R EQU 0x40058514
GPIO_PORTA_AHB_SLR_R EQU 0x40058518
GPIO_PORTA_AHB_DEN_R EQU 0x4005851C
GPIO_PORTA_AHB_LOCK_R EQU 0x40058520
GPIO_PORTA_AHB_CR_R EQU 0x40058524
GPIO_PORTA_AHB_AMSEL_R EQU 0x40058528
GPIO_PORTA_AHB_PCTL_R EQU 0x4005852C
GPIO_PORTA_AHB_ADCCTL_R EQU 0x40058530
GPIO_PORTA_AHB_DMACTL_R EQU 0x40058534
GPIO_PORTA_AHB_SI_R EQU 0x40058538
GPIO_PORTA_AHB_DR12R_R EQU 0x4005853C
GPIO_PORTA_AHB_WAKEPEN_R EQU 0x40058540
GPIO_PORTA_AHB_WAKELVL_R EQU 0x40058544
GPIO_PORTA_AHB_WAKESTAT_R EQU 0x40058548
GPIO_PORTA_AHB_PP_R EQU 0x40058FC0
GPIO_PORTA_AHB_PC_R EQU 0x40058FC4
GPIO_PORTA               	EQU    2_1
; PORT B
GPIO_PORTB_AHB_DATA_BITS_R EQU 0x40059000
GPIO_PORTB_AHB_DATA_R EQU 0x400593FC
GPIO_PORTB_AHB_DIR_R EQU 0x40059400
GPIO_PORTB_AHB_IS_R EQU 0x40059404
GPIO_PORTB_AHB_IBE_R EQU 0x40059408
GPIO_PORTB_AHB_IEV_R EQU 0x4005940C
GPIO_PORTB_AHB_IM_R EQU 0x40059410
GPIO_PORTB_AHB_RIS_R EQU 0x40059414
GPIO_PORTB_AHB_MIS_R EQU 0x40059418
GPIO_PORTB_AHB_ICR_R EQU 0x4005941C
GPIO_PORTB_AHB_AFSEL_R EQU 0x40059420
GPIO_PORTB_AHB_DR2R_R EQU 0x40059500
GPIO_PORTB_AHB_DR4R_R EQU 0x40059504
GPIO_PORTB_AHB_DR8R_R EQU 0x40059508
GPIO_PORTB_AHB_ODR_R EQU 0x4005950C
GPIO_PORTB_AHB_PUR_R EQU 0x40059510
GPIO_PORTB_AHB_PDR_R EQU 0x40059514
GPIO_PORTB_AHB_SLR_R EQU 0x40059518
GPIO_PORTB_AHB_DEN_R EQU 0x4005951C
GPIO_PORTB_AHB_LOCK_R EQU 0x40059520
GPIO_PORTB_AHB_CR_R EQU 0x40059524
GPIO_PORTB_AHB_AMSEL_R EQU 0x40059528
GPIO_PORTB_AHB_PCTL_R EQU 0x4005952C
GPIO_PORTB_AHB_ADCCTL_R EQU 0x40059530
GPIO_PORTB_AHB_DMACTL_R EQU 0x40059534
GPIO_PORTB_AHB_SI_R EQU 0x40059538
GPIO_PORTB_AHB_DR12R_R EQU 0x4005953C
GPIO_PORTB_AHB_WAKEPEN_R EQU 0x40059540
GPIO_PORTB_AHB_WAKELVL_R EQU 0x40059544
GPIO_PORTB_AHB_WAKESTAT_R EQU 0x40059548
GPIO_PORTB_AHB_PP_R EQU 0x40059FC0
GPIO_PORTB_AHB_PC_R EQU 0x40059FC4
GPIO_PORTB EQU 2_10
; PORT P
GPIO_PORTP_AHB_DATA_BITS_R EQU 0x40065000
GPIO_PORTP_AHB_DATA_R EQU 0x400653FC
GPIO_PORTP_AHB_DIR_R EQU 0x40065400
GPIO_PORTP_AHB_IS_R EQU 0x40065404
GPIO_PORTP_AHB_IBE_R EQU 0x40065408
GPIO_PORTP_AHB_IEV_R EQU 0x4006540C
GPIO_PORTP_AHB_IM_R EQU 0x40065410
GPIO_PORTP_AHB_RIS_R EQU 0x40065414
GPIO_PORTP_AHB_MIS_R EQU 0x40065418
GPIO_PORTP_AHB_ICR_R EQU 0x4006541C
GPIO_PORTP_AHB_AFSEL_R EQU 0x40065420
GPIO_PORTP_AHB_DR2R_R EQU 0x40065500
GPIO_PORTP_AHB_DR4R_R EQU 0x40065504
GPIO_PORTP_AHB_DR8R_R EQU 0x40065508
GPIO_PORTP_AHB_ODR_R EQU 0x4006550C
GPIO_PORTP_AHB_PUR_R EQU 0x40065510
GPIO_PORTP_AHB_PDR_R EQU 0x40065514
GPIO_PORTP_AHB_SLR_R EQU 0x40065518
GPIO_PORTP_AHB_DEN_R EQU 0x4006551C
GPIO_PORTP_AHB_LOCK_R EQU 0x40065520
GPIO_PORTP_AHB_CR_R EQU 0x40065524
GPIO_PORTP_AHB_AMSEL_R EQU 0x40065528
GPIO_PORTP_AHB_PCTL_R EQU 0x4006552C
GPIO_PORTP_AHB_ADCCTL_R EQU 0x40065530
GPIO_PORTP_AHB_DMACTL_R EQU 0x40065534
GPIO_PORTP_AHB_SI_R EQU 0x40065538
GPIO_PORTP_AHB_DR12R_R EQU 0x4006553C
GPIO_PORTP_AHB_WAKEPEN_R EQU 0x40065540
GPIO_PORTP_AHB_WAKELVL_R EQU 0x40065544
GPIO_PORTP_AHB_WAKESTAT_R EQU 0x40065548
GPIO_PORTP_AHB_PP_R EQU 0x40065FC0
GPIO_PORTP_AHB_PC_R EQU 0x40065FC4
GPIO_PORTP EQU 8192

; PORT Q
GPIO_PORTQ_AHB_DATA_BITS_R EQU 0x40066000
GPIO_PORTQ_AHB_DATA_R EQU 0x400663FC
GPIO_PORTQ_AHB_DIR_R EQU 0x40066400
GPIO_PORTQ_AHB_IS_R EQU 0x40066404
GPIO_PORTQ_AHB_IBE_R EQU 0x40066408
GPIO_PORTQ_AHB_IEV_R EQU 0x4006640C
GPIO_PORTQ_AHB_IM_R EQU 0x40066410
GPIO_PORTQ_AHB_RIS_R EQU 0x40066414
GPIO_PORTQ_AHB_MIS_R EQU 0x40066418
GPIO_PORTQ_AHB_ICR_R EQU 0x4006641C
GPIO_PORTQ_AHB_AFSEL_R EQU 0x40066420
GPIO_PORTQ_AHB_DR2R_R EQU 0x40066500
GPIO_PORTQ_AHB_DR4R_R EQU 0x40066504
GPIO_PORTQ_AHB_DR8R_R EQU 0x40066508
GPIO_PORTQ_AHB_ODR_R EQU 0x4006650C
GPIO_PORTQ_AHB_PUR_R EQU 0x40066510
GPIO_PORTQ_AHB_PDR_R EQU 0x40066514
GPIO_PORTQ_AHB_SLR_R EQU 0x40066518
GPIO_PORTQ_AHB_DEN_R EQU 0x4006651C
GPIO_PORTQ_AHB_LOCK_R EQU 0x40066520
GPIO_PORTQ_AHB_CR_R EQU 0x40066524
GPIO_PORTQ_AHB_AMSEL_R EQU 0x40066528
GPIO_PORTQ_AHB_PCTL_R EQU 0x4006652C
GPIO_PORTQ_AHB_ADCCTL_R EQU 0x40066530
GPIO_PORTQ_AHB_DMACTL_R EQU 0x40066534
GPIO_PORTQ_AHB_SI_R EQU 0x40066538
GPIO_PORTQ_AHB_DR12R_R EQU 0x4006653C
GPIO_PORTQ_AHB_WAKEPEN_R EQU 0x40066540
GPIO_PORTQ_AHB_WAKELVL_R EQU 0x40066544
GPIO_PORTQ_AHB_WAKESTAT_R EQU 0x40066548
GPIO_PORTQ_AHB_PP_R EQU 0x40066FC0
GPIO_PORTQ_AHB_PC_R EQU 0x40066FC4
GPIO_PORTQ EQU 16384
	



; -------------------------------------------------------------------------------
; Área de Código - Tudo abaixo da diretiva a seguir será armazenado na memória de 
;                  código
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma função do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortA_Output			; Permite chamar PortA_Output de outro arquivo
		EXPORT PortB_Output			; Permite chamar PortB_Output de outro arquivo
		EXPORT PortQ_Output			; Permite chamar PortQ_Output de outro arquivo
		EXPORT PortP_Output			; Permite chamar PortP_Output de outro arquivo	
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo

		EXPORT	SYSCTL_RCGCGPIO_R
		EXPORT	SYSCTL_PRGPIO_R
									

;--------------------------------------------------------------------------------
; Função GPIO_Init
; Parâmetro de entrada: Não tem
; Parâmetro de saída: Não tem
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; após isso verificar no PRGPIO se a porta está pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endereço do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTA                 ;Seta o bit da porta A
			ORR     R1, #GPIO_PORTB					;Seta o bit da porta B, fazendo com OR
			ORR     R1, #GPIO_PORTQ					;Seta o bit da porta Q, fazendo com OR
			ORR     R1, #GPIO_PORTP					;Seta o bit da porta P, fazendo com OR
			ORR     R1, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
            STR     R1, [R0]						;Move para a memória os bits das portas no endereço do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endereço do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;Lê da memória o conteúdo do endereço do registrador
			MOV		R2, #GPIO_PORTA                 ;Seta o bit da porta A
			ORR     R2, #GPIO_PORTB					;Seta o bit da porta B, fazendo com OR
			ORR     R2, #GPIO_PORTQ					;Seta o bit da porta Q, fazendo com OR
			ORR     R2, #GPIO_PORTP					;Seta o bit da porta P, fazendo com OR
			ORR     R2, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
            TST     R1, R2							;ANDS de R1 com R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o laço. Senão continua executando
 
; 2. Limpar o AMSEL para desabilitar a analógica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a função analógica
            LDR     R0, =GPIO_PORTA_AHB_AMSEL_R     ;Carrega o R0 com o endereço do AMSEL para a porta A
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta A da memória
            LDR     R0, =GPIO_PORTB_AHB_AMSEL_R		;Carrega o R0 com o endereço do AMSEL para a porta B
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta B da memória
			LDR     R0, =GPIO_PORTQ_AHB_AMSEL_R		;Carrega o R0 com o endereço do AMSEL para a porta Q
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta Q da memória

			LDR     R0, =GPIO_PORTP_AHB_AMSEL_R		;Carrega o R0 com o endereço do AMSEL para a porta P
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta P da memória
			LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R		;Carrega o R0 com o endereço do AMSEL para a porta J
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta J da memória
 
			
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R		;Carrega o R0 com o endereço do PCTL para a porta A
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta A da memória
            LDR     R0, =GPIO_PORTB_AHB_PCTL_R      ;Carrega o R0 com o endereço do PCTL para a porta B
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta B da memória
            LDR     R0, =GPIO_PORTQ_AHB_PCTL_R		;Carrega o R0 com o endereço do PCTL para a porta Q
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta Q da memória
            LDR     R0, =GPIO_PORTP_AHB_PCTL_R      ;Carrega o R0 com o endereço do PCTL para a porta P
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta P da memória
			LDR     R0, =GPIO_PORTJ_AHB_PCTL_R      ;Carrega o R0 com o endereço do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da memória
			
; 4. DIR para 0 se for entrada, 1 se for saída
            LDR     R0, =GPIO_PORTA_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta A
			MOV     R1, #2_11110000					;PA4, PA5, PA6 para LEDs
            STR     R1, [R0]						;Guarda no registrador
			; O certo era verificar os outros bits da PF para não transformar entradas em saídas desnecessárias
            LDR     R0, =GPIO_PORTB_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta B
            MOV     R1, #2_00110000               	;PB4, PB5 BJT de 7seg
            STR     R1, [R0]						;Guarda no registrador PCTL da porta B da memória
			LDR     R0, =GPIO_PORTQ_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta Q
            MOV     R1, #2_00001111               	;PQ0, PQ1, PQ2, PQ3 para LEDs
            STR     R1, [R0]						;Guarda no registrador PCTL da porta Q da memória
			LDR     R0, =GPIO_PORTP_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta P
            MOV     R1, #2_00100000               	;PP5 para BJT leds
            STR     R1, [R0]						;Guarda no registrador PCTL da porta P da memória
			LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endereço do DIR para a porta J
            MOV     R1, #0x00               	;PP0, PP1 USW BTN
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da memória
			
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem função alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para não setar função alternativa
            LDR     R0, =GPIO_PORTA_AHB_AFSEL_R		;Carrega o endereço do AFSEL da porta A
            STR     R1, [R0]						;Escreve na porta
            LDR     R0, =GPIO_PORTB_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta B
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTQ_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta Q
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTP_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta P
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endereço do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			
; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTA_AHB_DEN_R			;Carrega o endereço do DEN
            MOV     R1, #2_11110000                     ;Ativa os pinos como I/O Digital
            STR     R1, [R0]							;Escreve no registrador da memória funcionalidade digital 
 
            LDR     R0, =GPIO_PORTB_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00110000                     ;Ativa os pinos como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
			LDR     R0, =GPIO_PORTQ_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00001111                     ;Ativa os pinos como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
			LDR     R0, =GPIO_PORTP_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00100000                     ;Ativa os pinos como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
			LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endereço do DEN
			MOV     R1, #2_00000011                     ;Ativa os pinos como I/O Digital      
            STR     R1, [R0]                            ;Escreve no registrador da memória funcionalidade digital
			
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endereço do PUR para a porta J
			MOV     R1, #2_00000011						;Habilitar funcionalidade digital de resistor de pull-up 
                                                        ;nos bits 0 e 1
            STR     R1, [R0]							;Escreve no registrador da memória do resistor de pull-up
            
;retorno            
			BX      LR

; -------------------------------------------------------------------------------
; Função PortA_Output
; Parâmetro de entrada: R0 --> se os BIT5-6 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortA_Output
	LDR	R1, =GPIO_PORTA_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_11110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Função PortB_Output
; Parâmetro de entrada: R0 --> se os BIT5-4 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortB_Output
	LDR	R1, =GPIO_PORTB_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00110000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00110000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	

; -------------------------------------------------------------------------------
; Função PortQ_Output
; Parâmetro de entrada: R0 --> se os BIT3-0 estão ligado ou desligado
; Parâmetro de saída: Não tem
PortQ_Output
	LDR	R1, =GPIO_PORTQ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00001111                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00001111
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	
	
; -------------------------------------------------------------------------------
; Função PortP_Output
; Parâmetro de entrada: R0 --> se os BIT5 esta ligado ou desligado
; Parâmetro de saída: Não tem
PortP_Output
	LDR	R1, =GPIO_PORTP_AHB_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00100000                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 2_00100000
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o parâmetro de entrada
	STR R0, [R1]                            ;Escreve na porta F o barramento de dados dos pinos F4 e F0
	BX LR	


; -------------------------------------------------------------------------------
; Função PortJ_Input
; Parâmetro de entrada: Não tem
; Parâmetro de saída: R0 --> o valor da leitura
PortJ_Input
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;Lê no barramento de dados dos pinos [J1-J0]
	BX LR									;Retorno

    ALIGN                           ; garante que o fim da seção está alinhada 
    END                             ; fim do arquivo