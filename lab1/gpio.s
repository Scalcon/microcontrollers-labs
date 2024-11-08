; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; Defini��es de Valores
BIT0	EQU 2_0001
BIT1	EQU 2_0010
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; Defini��es dos Ports
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
GPIO_PORTJ_AHB_DATA_BITS_R  EQU    0x40060000
GPIO_PORTJ               	EQU    2_000000100000000
; PORT N
GPIO_PORTN_LOCK_R    	EQU    0x40064520
GPIO_PORTN_CR_R      	EQU    0x40064524
GPIO_PORTN_AMSEL_R   	EQU    0x40064528
GPIO_PORTN_PCTL_R    	EQU    0x4006452C
GPIO_PORTN_DIR_R     	EQU    0x40064400
GPIO_PORTN_AFSEL_R   	EQU    0x40064420
GPIO_PORTN_DEN_R     	EQU    0x4006451C
GPIO_PORTN_PUR_R     	EQU    0x40064510	
GPIO_PORTN_DATA_R    	EQU    0x400643FC
GPIO_PORTN_DATA_BITS_R  EQU    0x40064000
GPIO_PORTN              EQU    2_001000000000000	


;porta a;
GPIO_PORTA_AHB_DATA_R EQU  0x400583FC
GPIO_PORTA_AHB_DIR_R  EQU  0x40058400
GPIO_PORTA_AHB_IS_R   EQU  0x40058404
GPIO_PORTA_AHB_IBE_R  EQU  0x40058408
GPIO_PORTA_AHB_IEV_R  EQU  0x4005840C
GPIO_PORTA_AHB_IM_R   EQU  0x40058410
GPIO_PORTA_AHB_RIS_R  EQU  0x40058414
GPIO_PORTA_AHB_MIS_R  EQU  0x40058418
GPIO_PORTA_AHB_ICR_R  EQU  0x4005841C
GPIO_PORTA_AHB_AFSEL_R EQU 0x40058420
GPIO_PORTA_AHB_DR2R_R  EQU 0x40058500
GPIO_PORTA_AHB_DR4R_R  EQU 0x40058504
GPIO_PORTA_AHB_DR8R_R  EQU 0x40058508
GPIO_PORTA_AHB_ODR_R   EQU 0x4005850C
GPIO_PORTA_AHB_PUR_R   EQU 0x40058510
GPIO_PORTA_AHB_PDR_R   EQU 0x40058514
GPIO_PORTA_AHB_SLR_R   EQU 0x40058518
GPIO_PORTA_AHB_DEN_R    EQU 0x4005851C
GPIO_PORTA_AHB_LOCK_R   EQU 0x40058520
GPIO_PORTA_AHB_CR_R     EQU 0x40058524
GPIO_PORTA_AHB_AMSEL_R  EQU 0x40058528
GPIO_PORTA_AHB_PCTL_R   EQU 0x4005852C
GPIO_PORTA_AHB_ADCCTL_R EQU 0x40058530
GPIO_PORTA_AHB_DMACTL_R EQU 0x40058534
GPIO_PORTA_AHB_SI_R     EQU 0x40058538
GPIO_PORTA_AHB_DR12R_R  EQU 0x4005853C
	
	
;port b;
GPIO_PORTB_AHB_DATA_R EQU   0x400593FC
GPIO_PORTB_AHB_DIR_R  EQU   0x40059400
GPIO_PORTB_AHB_IS_R   EQU   0x40059404
GPIO_PORTB_AHB_IBE_R  EQU   0x40059408
GPIO_PORTB_AHB_IEV_R  EQU   0x4005940C
GPIO_PORTB_AHB_IM_R   EQU   0x40059410
GPIO_PORTB_AHB_RIS_R  EQU   0x40059414
GPIO_PORTB_AHB_MIS_R  EQU   0x40059418
GPIO_PORTB_AHB_ICR_R  EQU   0x4005941C
GPIO_PORTB_AHB_AFSEL_R EQU  0x40059420
GPIO_PORTB_AHB_DR2R_R  EQU  0x40059500
GPIO_PORTB_AHB_DR4R_R  EQU  0x40059504
GPIO_PORTB_AHB_DR8R_R  EQU  0x40059508
GPIO_PORTB_AHB_ODR_R   EQU  0x4005950C
GPIO_PORTB_AHB_PUR_R   EQU  0x40059510
GPIO_PORTB_AHB_PDR_R   EQU  0x40059514
GPIO_PORTB_AHB_SLR_R   EQU  0x40059518
GPIO_PORTB_AHB_DEN_R    EQU 0x4005951C
GPIO_PORTB_AHB_LOCK_R   EQU 0x40059520
GPIO_PORTB_AHB_CR_R     EQU 0x40059524
GPIO_PORTB_AHB_AMSEL_R  EQU 0x40059528
GPIO_PORTB_AHB_PCTL_R   EQU 0x4005952C
GPIO_PORTB_AHB_ADCCTL_R EQU 0x40059530
GPIO_PORTB_AHB_DMACTL_R EQU 0x40059534
GPIO_PORTB_AHB_SI_R     EQU 0x40059538
GPIO_PORTB_AHB_DR12R_R  EQU 0x4005953C

;port p;
GPIO_PORTP_DATA_R       EQU 0x400653FC
GPIO_PORTP_DIR_R        EQU 0x40065400
GPIO_PORTP_IS_R         EQU 0x40065404
GPIO_PORTP_IBE_R        EQU 0x40065408
GPIO_PORTP_IEV_R        EQU 0x4006540C
GPIO_PORTP_IM_R         EQU 0x40065410
GPIO_PORTP_RIS_R        EQU 0x40065414
GPIO_PORTP_MIS_R        EQU 0x40065418
GPIO_PORTP_ICR_R        EQU 0x4006541C
GPIO_PORTP_AFSEL_R      EQU 0x40065420
GPIO_PORTP_DR2R_R       EQU 0x40065500
GPIO_PORTP_DR4R_R       EQU 0x40065504
GPIO_PORTP_DR8R_R       EQU 0x40065508
GPIO_PORTP_ODR_R        EQU 0x4006550C
GPIO_PORTP_PUR_R        EQU 0x40065510
GPIO_PORTP_PDR_R        EQU 0x40065514
GPIO_PORTP_SLR_R        EQU 0x40065518
GPIO_PORTP_DEN_R        EQU 0x4006551C
GPIO_PORTP_LOCK_R       EQU 0x40065520
GPIO_PORTP_CR_R         EQU 0x40065524
GPIO_PORTP_AMSEL_R      EQU 0x40065528
GPIO_PORTP_PCTL_R       EQU 0x4006552C
GPIO_PORTP_ADCCTL_R     EQU 0x40065530
GPIO_PORTP_DMACTL_R     EQU 0x40065534
GPIO_PORTP_SI_R         EQU 0x40065538
GPIO_PORTP_DR12R_R      EQU 0x4006553C
GPIO_PORTP_WAKEPEN_R    EQU 0x40065540
GPIO_PORTP_WAKELVL_R    EQU 0x40065544
GPIO_PORTP_WAKESTAT_R   EQU 0x40065548
GPIO_PORTP_PP_R         EQU 0x40065FC0
GPIO_PORTP_PC_R         EQU 0x40065FC4

; port q;
GPIO_PORTQ_DATA_R       EQU 0x400663FC
GPIO_PORTQ_DIR_R        EQU 0x40066400
GPIO_PORTQ_IS_R         EQU 0x40066404
GPIO_PORTQ_IBE_R        EQU 0x40066408
GPIO_PORTQ_IEV_R        EQU 0x4006640C
GPIO_PORTQ_IM_R         EQU 0x40066410
GPIO_PORTQ_RIS_R        EQU 0x40066414
GPIO_PORTQ_MIS_R        EQU 0x40066418
GPIO_PORTQ_ICR_R        EQU 0x4006641C
GPIO_PORTQ_AFSEL_R      EQU 0x40066420
GPIO_PORTQ_DR2R_R       EQU 0x40066500
GPIO_PORTQ_DR4R_R       EQU 0x40066504
GPIO_PORTQ_DR8R_R       EQU 0x40066508
GPIO_PORTQ_ODR_R        EQU 0x4006650C
GPIO_PORTQ_PUR_R        EQU 0x40066510
GPIO_PORTQ_PDR_R        EQU 0x40066514
GPIO_PORTQ_SLR_R        EQU 0x40066518
GPIO_PORTQ_DEN_R        EQU 0x4006651C
GPIO_PORTQ_LOCK_R       EQU 0x40066520
GPIO_PORTQ_CR_R         EQU 0x40066524
GPIO_PORTQ_AMSEL_R      EQU 0x40066528
GPIO_PORTQ_PCTL_R       EQU 0x4006652C
GPIO_PORTQ_ADCCTL_R     EQU 0x40066530
GPIO_PORTQ_DMACTL_R     EQU 0x40066534
GPIO_PORTQ_SI_R         EQU 0x40066538
GPIO_PORTQ_DR12R_R      EQU 0x4006653C
GPIO_PORTQ_WAKEPEN_R    EQU 0x40066540
GPIO_PORTQ_WAKELVL_R    EQU 0x40066544
GPIO_PORTQ_WAKESTAT_R   EQU 0x40066548
GPIO_PORTQ_PP_R         EQU 0x40066FC0
GPIO_PORTQ_PC_R         EQU 0x40066FC4
	
; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT PortN_Output			; Permite chamar PortN_Output de outro arquivo
		EXPORT PortJ_Input          ; Permite chamar PortJ_Input de outro arquivo
		EXPORT GPIO_PORTA_AHB_DATA_R
		EXPORT GPIO_PORTB_AHB_DATA_R
		EXPORT GPIO_PORTA_AHB_DIR_R
		EXPORT GPIO_PORTB_AHB_DIR_R
		EXPORT SYSCTL_PRGPIO_R
		EXPORT SYSCTL_RCGCGPIO_R	
									

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
; enable clock to GPIOF at clock gating register
            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endere�o do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTN                 ;Seta o bit da porta N
			ORR     R1, #GPIO_PORTJ					;Seta o bit da porta J, fazendo com OR
            STR     R1, [R0]						;Move para a mem�ria os bits das portas no endere�o do RCGCGPIO
 
            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endere�o do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;L� da mem�ria o conte�do do endere�o do registrador
			MOV     R2, #GPIO_PORTN                 ;Seta os bits correspondentes �s portas para fazer a compara��o
			ORR     R2, #GPIO_PORTJ                 ;Seta o bit da porta J, fazendo com OR
            TST     R1, R2							;Testa o R1 com R2 fazendo R1 & R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o la�o. Sen�o continua executando
 
; 2. Limpar o AMSEL para desabilitar a anal�gica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a fun��o anal�gica
            LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
            LDR     R0, =GPIO_PORTN_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta N
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta N da mem�ria
			LDR     R0, =GPIO_PORTA_AHB_AMSEL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTB_AHB_AMSEL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTP_AMSEL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTQ_AMSEL_R			
            STR     R1, [R0]
 
; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da mem�ria
            LDR     R0, =GPIO_PORTN_PCTL_R      	;Carrega o R0 com o endere�o do PCTL para a porta N
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTA_AHB_PCTL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTB_AHB_PCTL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTP_PCTL_R			
            STR     R1, [R0]
			LDR     R0, =GPIO_PORTQ_PCTL_R			
            STR     R1, [R0]
; 4. DIR para 0 se for entrada, 1 se for sa�da
            LDR     R0, =GPIO_PORTN_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta N
			MOV     R1, #2_0010						;PN1
            STR     R1, [R0]						;Guarda no registrador
			; O certo era verificar os outros bits da PJ para n�o transformar entradas em sa�das desnecess�rias
            LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
			
			LDR     R0, =GPIO_PORTA_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
			
			LDR     R0, =GPIO_PORTB_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
			
			LDR     R0, =GPIO_PORTP_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
			
			LDR     R0, =GPIO_PORTQ_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria

			
; 5. Limpar os bits AFSEL para 0 para selecionar GPIO 
;    Sem fun��o alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para n�o setar fun��o alternativa
            LDR     R0, =GPIO_PORTN_AFSEL_R			;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]						;Escreve na porta
            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTA_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTB_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]        
            LDR     R0, =GPIO_PORTP_AFSEL_R			;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]		
            LDR     R0, =GPIO_PORTQ_AFSEL_R			;Carrega o endere�o do AFSEL da porta N
            STR     R1, [R0]		                ;Escreve na porta
; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTN_DEN_R			    ;Carrega o endere�o do DEN
            MOV     R1, #2_00000010                     ;N1
            STR     R1, [R0]							;Escreve no registrador da mem�ria funcionalidade digital 
 
            LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endere�o do DEN
			MOV     R1, #2_00000001                     ;J0     
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
			
; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
			MOV     R1, #2_1							;Habilitar funcionalidade digital de resistor de pull-up 
            STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up
			BX      LR

; -------------------------------------------------------------------------------
; Fun��o PortN_Output
; Par�metro de entrada: R0 --> se o BIT1 est� ligado ou desligado
; Par�metro de sa�da: N�o tem
PortN_Output
	LDR	R1, =GPIO_PORTN_DATA_R		    ;Carrega o valor do offset do data register
	;Read-Modify-Write para escrita
	LDR R2, [R1]
	BIC R2, #2_00000010                     ;Primeiro limpamos os dois bits do lido da porta R2 = R2 & 11111101
	ORR R0, R0, R2                          ;Fazer o OR do lido pela porta com o par�metro de entrada
	STR R0, [R1]                            ;Escreve na porta N o barramento de dados do pino N1
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Fun��o PortJ_Input
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: R0 --> o valor da leitura
PortJ_Input
	LDR	R1, =GPIO_PORTJ_AHB_DATA_R		    ;Carrega o valor do offset do data register
	LDR R0, [R1]                            ;L� no barramento de dados dos pinos [J0]
	BX LR									;Retorno

    ALIGN                           ; garante que o fim da se��o est� alinhada 
    END                             ; fim do arquivo