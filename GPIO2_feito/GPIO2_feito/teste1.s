CheckStepButton
    PUSH {R0-R2}           ; Salva R0-R2 no stack para preservar seus valores

    ; Endere�o do registrador de dados do bot�o USR_SW1
    LDR R0, =GPIO_PORTA_DATA_R
    LDR R1, =0x08          ; M�scara para o pino PA3 (bit correspondente ao bot�o USR_SW1)

    ; Ler estado atual do bot�o
    LDR R2, [R0]           ; Carrega o valor dos pinos da porta A
    TST R2, R1             ; Verifica se o bit PA3 est� baixo (bot�o pressionado)

    ; Verifica se h� transi��o de borda (estado de 1 para 0)
    LDR R2, =ButtonState   ; Carrega o estado anterior do bot�o
    TST R2, R1             ; Verifica o estado anterior
    BEQ NoPress            ; Se j� estava pressionado, pula a atualiza��o

    ; Atualiza o passo (R4) se o bot�o foi pressionado
    ADD R4, R4, #1         ; Incrementa o passo
    CMP R4, #10            ; Verifica se passo � maior que 9
    BNE Continue           ; Se n�o for maior que 9, continue
    MOV R4, #1             ; Caso contr�rio, reseta para 1

Continue
    ; Atualiza o estado do bot�o
    LDR R2, =ButtonState
    STR R1, [R2]           ; Armazena estado de "pressionado"

NoPress
    ; Atualiza o estado para "n�o pressionado" se o bot�o n�o estiver pressionado
    LDR R2, [R0]           ; L� novamente o estado dos pinos
    TST R2, R1             ; Verifica se PA3 est� em alto (n�o pressionado)
    BNE Done               ; Se n�o est� pressionado, finaliza

    LDR R2, =ButtonState
    STR R0, [R2]           ; Atualiza estado para "n�o pressionado"

Done
    POP {R0-R2}            ; Restaura os valores originais de R0-R2
    BX LR                  ; Retorna da sub-rotina

ButtonState
    DCD 0x00               ; Vari�vel para armazenar o estado anterior do bot�o