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

		; Se alguma função do arquivo for chamada em outro arquivo	;
        EXPORT Start                ; Permite chamar a função Start a partir de ;
			                        ; outro arquivo. No caso startup.s;
									
        ; Definir endereços de memória
LISTA_NUM_ALE EQU 0x20000A00     ; Endereço para lista de numero aleatorios;
LISTA_NUM_PRIMOS EQU 0x20000B00    ; Endereço para lista de números primos;
LISTA_SIZE EQU 20
									
Start

        LDR     R0, =LISTA_NUM_ALE       ; Carregar o endereço inicial da lista de números aleatorios em R0
        LDR     R1, =LISTA_NUM_PRIMOS      ; Carregar o endereço inicial da lista de primos em R1
		LDR     R8, =LISTA_SIZE
        MOV     R2, #0              ; Inicializar o contador de números primos em R2
		MOV		R9, #0
		
		;carregando valores na lista de n aleatorios;
		MOV		R7, #193
		STRB 	R7, [R0], #1
		
		MOV		R7, #63
		STRB 	R7, [R0], #1
		
		MOV		R7, #176
		STRB 	R7, [R0], #1
		
		MOV		R7, #127
		STRB 	R7, [R0], #1
		
		MOV		R7, #43
		STRB 	R7, [R0], #1
		
		MOV		R7, #13
		STRB 	R7, [R0], #1
		
		MOV		R7, #211
		STRB 	R7, [R0], #1
		
		MOV		R7, #3
		STRB 	R7, [R0], #1
		
		MOV		R7, #203
		STRB 	R7, [R0], #1
		
		MOV		R7, #5
		STRB 	R7, [R0], #1
		
		MOV		R7, #21
		STRB 	R7, [R0], #1
		
		MOV		R7, #7
		STRB 	R7, [R0], #1
		
		MOV		R7, #206
		STRB 	R7, [R0], #1
		
		MOV		R7, #245
		STRB 	R7, [R0], #1
		
		MOV		R7, #157
		STRB 	R7, [R0], #1
		
		MOV		R7, #237
		STRB 	R7, [R0], #1
		
		MOV		R7, #241
		STRB 	R7, [R0], #1
		
		MOV		R7, #105
		STRB 	R7, [R0], #1
		
		MOV		R7, #252
		STRB 	R7, [R0], #1
		
		MOV		R7, #19
		STRB 	R7, [R0]
		
		LDR     R0, =LISTA_NUM_ALE 


loop_percorre_lista_num_ale
        LDRB    R3, [R0], #1        ; R0 sera armazenado em R3, sendo R0 a posicao atual da lista de numeros aleatorios, apos iso, encrementa-se #1, R0 e o ponteiro que percorre a lista de numeros aleatorios
        ADD 	R9, R9, #1
		
		CMP		R9, R8							; Compara-se o número no registrador R3 com 0. Se for igual a 0, significa que chegamos ao fim da lista.
        BGT sort_primes          ; Se o número for 0, o algoritmo pula para a parte de ordenação dos números primos (fase do Bubble Sort), pois a lista de números já foi percorrida.
        
        MOV R4, #2                   ; O registrador R4 é inicializado com o valor 2, pois começamos a verificação se o número R3 é divisível por 2. A ideia e verificar de 2 ate R3-1


loop_verif_primo
        CMP R4, R3                  ; Comparamos o divisor atual R4 com o número R3. Se R4 for igual ou maior que R3, significa que não encontramos nenhum divisor e, portanto, R3 é primo.
        BGE armazena_primo             ; Se R4 for maior ou igual a R3, o número é considerado primo e vamos armazená-lo. Saltamos para a parte do código que armazena o número  primo.

;se for menor, segue o codigo:;


       UDIV R5, R3, R4               ; Aqui fazemos a divisão de R3 por R4 e armazenamos o quociente em R5.
       MLS R6, R5, R4, R3            ; Em seguida, usamos a instrução MLS. Esta instrução faz R6 = R3 - (R5 * R4). Isso permite calcular o resto da divisão. Se R6 for 0, significa que R3 é divisível por R4 e, portanto, não é primo.

       CMP R6, #0                    ; verifica se o R6 é zero
       BEQ loop_percorre_lista_num_ale       ; se for zero, R3 nao é primmo entao podemos ir para o proximo numero da fila de numero aleatorios

       ADD R4, R4, #1                ; Incrementa o valor do divisor R4 em 1, para testar o próximo número como divisor.
       B loop_verif_primo            ; Volta para o loop de verificação se e primo ou nao, onde testamos o próximo divisor para R3.

armazena_primo
      STRB R3, [R1], #1              ; Se o número R3 for primo, ele é armazenado no endereço R1, que aponta para a lista de números primos (em 0x20000B00). O ponteiro R1 é incrementado em 1 após armazenar o número.
      ADD R2, R2, #1                 ; O registrador R2 guarda o tamanho da lista de números primos. Ele é incrementado toda vez que armazenamos um número primo.
      B loop_percorre_lista_num_ale  ; Depois de armazenar o número primo, voltamos para o início do loop para verificar o próximo número da lista de num aleatorios

sort_primes
        MOV     R0, #0              ; Inicializa o ponteiro para o início da lista de primos
		LDR		R3, =LISTA_NUM_PRIMOS
		ADD 	R3, R3, R2				; Usa o tamanho da lista de primos para determinar o limite
		SUB 	R3, R3, #1
        

bubble_sort_outer_loop
        CMP     R3, #1              ; Verifica se o tamanho da lista e 1, se for 1 nao tem o que ordenar
        BLE     end_program         ; Se tiver so 1 numero, a ordenacao terminou, fim do programa

        ;caso nao tenha so um numero, continua;

        LDR     R0, =LISTA_NUM_PRIMOS       ; Reinicializa o ponteiro para a lista de primos
        MOV     R4, #0              ; Reinicializa o contador de troca
		
bubble_sort_inner_loop
        LDRB    R5, [R0]            ; Carrega o número atual
        LDRB    R6, [R0, #1]        ; Carrega o próximo número
        CMP     R5, R6              ; Compara os dois números
        BLE     skip_swap           ; Se estiverem na ordem correta, pule a troca

        ; Troca os dois números
        STRB    R6, [R0]            ; Armazena o próximo número na posição atual
        STRB    R5, [R0, #1]        ; Armazena o número atual na próxima posição
        MOV     R4, #1              ; Marca que uma troca foi feita

skip_swap
        ADD     R0, R0, #1          ; Incrementa o ponteiro para o próximo par
        CMP     R0, R3              ; Verifica se chegou ao final da lista
        BLT     bubble_sort_inner_loop ; Se não, continue comparando

        CMP     R4, #0              ; Verifica se houve troca
        BEQ     end_program         ; Se não houve troca, a lista está ordenada
        SUB     R3, R3, #1          ; Reduz o tamanho da lista para a próxima iteração
        B       bubble_sort_outer_loop ; Repete o processo de ordenação

end_program
	  NOP
	  ALIGN
	  END