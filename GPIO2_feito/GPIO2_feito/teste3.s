DisplayValue
    PUSH {R0-R5}            ; Salva os registradores usados no stack

    ; Separar dígitos (unidade e dezena) de R2
    MOV R0, R2              ; Copia o valor do contador para R0
    MOV R1, #10
    UDIV R3, R0, R1         ; Divide R0 por 10 para obter a dezena em R3
    MLS R4, R3, R1, R0      ; Multiplica a dezena por 10 e subtrai de R0 para obter a unidade em R4

    ; Exibir dígito da dezena no display DS1
    BL DisplayDigit
    LDR R0, =GPIO_PORTB_DATA_R
    MOV R1, #0x10           ; Ativa PB4 (controla o display DS1)
    STR R1, [R0]
    BL Delay                ; Pequeno atraso para visualização (ex: 1 ms)
    MOV R1, #0x00           ; Desativa DS1
    STR R1, [R0]

    ; Exibir dígito da unidade no display DS2
    MOV R0, R4              ; Carrega o dígito da unidade
    BL DisplayDigit
    LDR R0, =GPIO_PORTB_DATA_R
    MOV R1, #0x20           ; Ativa PB5 (controla o display DS2)
    STR R1, [R0]
    BL Delay                ; Pequeno atraso para visualização (ex: 1 ms)
    MOV R1, #0x00           ; Desativa DS2
    STR R1, [R0]

    POP {R0-R5}             ; Restaura os valores originais dos registradores
    BX LR                   ; Retorna da sub-rotina

DisplayDigit
    ; Converte o valor em R0 para o código correspondente ao display de 7 segmentos
    LDR R1, =SegmentMap     ; Carrega o endereço da tabela de mapeamento de segmentos
    LDRB R2, [R1, R0]       ; Carrega o código de segmento correspondente ao dígito em R0
    LDR R3, =GPIO_PORTA_DATA_R
    STR R2, [R3]            ; Envia o código para os pinos PA7-PA0 (conectar ao display)

    BX LR                   ; Retorna da sub-rotina
	
	
SegmentMap
    ; Mapeamento dos códigos de segmento para os dígitos de 0 a 9
    DCB 0x3F  ; 0
    DCB 0x06  ; 1
    DCB 0x5B  ; 2
    DCB 0x4F  ; 3
    DCB 0x66  ; 4
    DCB 0x6D  ; 5
    DCB 0x7D  ; 6
    DCB 0x07  ; 7
    DCB 0x7F  ; 8
    DCB 0x6F  ; 9