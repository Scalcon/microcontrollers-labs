CheckStepButton
    PUSH {R0-R2}           ; Salva R0-R2 no stack para preservar seus valores

    ; Endereço do registrador de dados do botão USR_SW1
    LDR R0, =GPIO_PORTA_DATA_R
    LDR R1, =0x08          ; Máscara para o pino PA3 (bit correspondente ao botão USR_SW1)

    ; Ler estado atual do botão
    LDR R2, [R0]           ; Carrega o valor dos pinos da porta A
    TST R2, R1             ; Verifica se o bit PA3 está baixo (botão pressionado)

    ; Verifica se há transição de borda (estado de 1 para 0)
    LDR R2, =ButtonState   ; Carrega o estado anterior do botão
    TST R2, R1             ; Verifica o estado anterior
    BEQ NoPress            ; Se já estava pressionado, pula a atualização

    ; Atualiza o passo (R4) se o botão foi pressionado
    ADD R4, R4, #1         ; Incrementa o passo
    CMP R4, #10            ; Verifica se passo é maior que 9
    BNE Continue           ; Se não for maior que 9, continue
    MOV R4, #1             ; Caso contrário, reseta para 1

Continue
    ; Atualiza o estado do botão
    LDR R2, =ButtonState
    STR R1, [R2]           ; Armazena estado de "pressionado"

NoPress
    ; Atualiza o estado para "não pressionado" se o botão não estiver pressionado
    LDR R2, [R0]           ; Lê novamente o estado dos pinos
    TST R2, R1             ; Verifica se PA3 está em alto (não pressionado)
    BNE Done               ; Se não está pressionado, finaliza

    LDR R2, =ButtonState
    STR R0, [R2]           ; Atualiza estado para "não pressionado"

Done
    POP {R0-R2}            ; Restaura os valores originais de R0-R2
    BX LR                  ; Retorna da sub-rotina

ButtonState
    DCD 0x00               ; Variável para armazenar o estado anterior do botão