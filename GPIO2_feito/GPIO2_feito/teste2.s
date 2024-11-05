CheckDirectionButton
    PUSH {R0-R2}           ; Salva R0-R2 no stack para preservar seus valores

    ; Endere�o do registrador de dados do bot�o USR_SW2
    LDR R0, =GPIO_PORTA_DATA_R
    LDR R1, =0x04          ; M�scara para o pino PA2 (bit correspondente ao bot�o USR_SW2)

    ; Ler estado atual do bot�o
    LDR R2, [R0]           ; Carrega o valor dos pinos da porta A
    TST R2, R1             ; Verifica se o bit PA2 est� baixo (bot�o pressionado)

    ; Verifica se h� transi��o de borda (estado de 1 para 0)
    LDR R2, =DirectionButtonState   ; Carrega o estado anterior do bot�o
    TST R2, R1             ; Verifica o estado anterior
    BEQ NoDirectionChange  ; Se j� estava pressionado, pula a atualiza��o

    ; Alterna a dire��o (R3) se o bot�o foi pressionado
    LDR R3, =CurrentDirection
    LDR R2, [R3]           ; Carrega o valor atual da dire��o (1 ou -1)
    RSBS R2, R2, #0        ; Inverte o sinal de R2 (1 -> -1 ou -1 -> 1)
    STR R2, [R3]           ; Armazena o novo valor de dire��o em CurrentDirection

    ; Atualiza o estado do bot�o para "pressionado"
    LDR R2, =DirectionButtonState
    STR R1, [R2]           ; Armazena estado de "pressionado"

NoDirectionChange
    ; Atualiza o estado para "n�o pressionado" se o bot�o n�o estiver pressionado
    LDR R2, [R0]           ; L� novamente o estado dos pinos
    TST R2, R1             ; Verifica se PA2 est� em alto (n�o pressionado)
    BNE Done               ; Se n�o est� pressionado, finaliza

    LDR R2, =DirectionButtonState
    STR R0, [R2]           ; Atualiza estado para "n�o pressionado"

Done
    POP {R0-R2}            ; Restaura os valores originais de R0-R2
    BX LR                  ; Retorna da sub-rotina

DirectionButtonState
    DCD 0x00               ; Vari�vel para armazenar o estado anterior do bot�o

CurrentDirection
    DCD 1                  ; Vari�vel para armazenar a dire��o atual (1 para crescente, -1 para decrescente)