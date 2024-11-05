CheckDirectionButton
    PUSH {R0-R2}           ; Salva R0-R2 no stack para preservar seus valores

    ; Endereço do registrador de dados do botão USR_SW2
    LDR R0, =GPIO_PORTA_DATA_R
    LDR R1, =0x04          ; Máscara para o pino PA2 (bit correspondente ao botão USR_SW2)

    ; Ler estado atual do botão
    LDR R2, [R0]           ; Carrega o valor dos pinos da porta A
    TST R2, R1             ; Verifica se o bit PA2 está baixo (botão pressionado)

    ; Verifica se há transição de borda (estado de 1 para 0)
    LDR R2, =DirectionButtonState   ; Carrega o estado anterior do botão
    TST R2, R1             ; Verifica o estado anterior
    BEQ NoDirectionChange  ; Se já estava pressionado, pula a atualização

    ; Alterna a direção (R3) se o botão foi pressionado
    LDR R3, =CurrentDirection
    LDR R2, [R3]           ; Carrega o valor atual da direção (1 ou -1)
    RSBS R2, R2, #0        ; Inverte o sinal de R2 (1 -> -1 ou -1 -> 1)
    STR R2, [R3]           ; Armazena o novo valor de direção em CurrentDirection

    ; Atualiza o estado do botão para "pressionado"
    LDR R2, =DirectionButtonState
    STR R1, [R2]           ; Armazena estado de "pressionado"

NoDirectionChange
    ; Atualiza o estado para "não pressionado" se o botão não estiver pressionado
    LDR R2, [R0]           ; Lê novamente o estado dos pinos
    TST R2, R1             ; Verifica se PA2 está em alto (não pressionado)
    BNE Done               ; Se não está pressionado, finaliza

    LDR R2, =DirectionButtonState
    STR R0, [R2]           ; Atualiza estado para "não pressionado"

Done
    POP {R0-R2}            ; Restaura os valores originais de R0-R2
    BX LR                  ; Retorna da sub-rotina

DirectionButtonState
    DCD 0x00               ; Variável para armazenar o estado anterior do botão

CurrentDirection
    DCD 1                  ; Variável para armazenar a direção atual (1 para crescente, -1 para decrescente)