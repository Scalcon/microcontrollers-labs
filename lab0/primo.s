; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
;<NOME>         EQU <VALOR>
; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a 
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira 
                                           ; posi��o da RAM		

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de 
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo	;
        EXPORT Start                ; Permite chamar a fun��o Start a partir de ;
			                        ; outro arquivo. No caso startup.s;
									
        ; Definir endere�os de mem�ria
LISTA_NUM_ALE EQU 0x20000A00     ; Endere�o para lista de numero aleatorios;
LISTA_NUM_PRIMOS EQU 0x20000B00    ; Endere�o para lista de n�meros primos;
LISTA_SIZE EQU 20
									
Start

        LDR     R0, =LISTA_NUM_ALE       ; Carregar o endere�o inicial da lista de n�meros aleatorios em R0
        LDR     R1, =LISTA_NUM_PRIMOS      ; Carregar o endere�o inicial da lista de primos em R1
		LDR     R8, =LISTA_SIZE
        MOV     R2, #0              ; Inicializar o contador de n�meros primos em R2
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
		
		CMP		R9, R8							; Compara-se o n�mero no registrador R3 com 0. Se for igual a 0, significa que chegamos ao fim da lista.
        BGT sort_primes          ; Se o n�mero for 0, o algoritmo pula para a parte de ordena��o dos n�meros primos (fase do Bubble Sort), pois a lista de n�meros j� foi percorrida.
        
        MOV R4, #2                   ; O registrador R4 � inicializado com o valor 2, pois come�amos a verifica��o se o n�mero R3 � divis�vel por 2. A ideia e verificar de 2 ate R3-1


loop_verif_primo
        CMP R4, R3                  ; Comparamos o divisor atual R4 com o n�mero R3. Se R4 for igual ou maior que R3, significa que n�o encontramos nenhum divisor e, portanto, R3 � primo.
        BGE armazena_primo             ; Se R4 for maior ou igual a R3, o n�mero � considerado primo e vamos armazen�-lo. Saltamos para a parte do c�digo que armazena o n�mero  primo.

;se for menor, segue o codigo:;


       UDIV R5, R3, R4               ; Aqui fazemos a divis�o de R3 por R4 e armazenamos o quociente em R5.
       MLS R6, R5, R4, R3            ; Em seguida, usamos a instru��o MLS. Esta instru��o faz R6 = R3 - (R5 * R4). Isso permite calcular o resto da divis�o. Se R6 for 0, significa que R3 � divis�vel por R4 e, portanto, n�o � primo.

       CMP R6, #0                    ; verifica se o R6 � zero
       BEQ loop_percorre_lista_num_ale       ; se for zero, R3 nao � primmo entao podemos ir para o proximo numero da fila de numero aleatorios

       ADD R4, R4, #1                ; Incrementa o valor do divisor R4 em 1, para testar o pr�ximo n�mero como divisor.
       B loop_verif_primo            ; Volta para o loop de verifica��o se e primo ou nao, onde testamos o pr�ximo divisor para R3.

armazena_primo
      STRB R3, [R1], #1              ; Se o n�mero R3 for primo, ele � armazenado no endere�o R1, que aponta para a lista de n�meros primos (em 0x20000B00). O ponteiro R1 � incrementado em 1 ap�s armazenar o n�mero.
      ADD R2, R2, #1                 ; O registrador R2 guarda o tamanho da lista de n�meros primos. Ele � incrementado toda vez que armazenamos um n�mero primo.
      B loop_percorre_lista_num_ale  ; Depois de armazenar o n�mero primo, voltamos para o in�cio do loop para verificar o pr�ximo n�mero da lista de num aleatorios

sort_primes
        MOV     R0, #0              ; Inicializa o ponteiro para o in�cio da lista de primos
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
        LDRB    R5, [R0]            ; Carrega o n�mero atual
        LDRB    R6, [R0, #1]        ; Carrega o pr�ximo n�mero
        CMP     R5, R6              ; Compara os dois n�meros
        BLE     skip_swap           ; Se estiverem na ordem correta, pule a troca

        ; Troca os dois n�meros
        STRB    R6, [R0]            ; Armazena o pr�ximo n�mero na posi��o atual
        STRB    R5, [R0, #1]        ; Armazena o n�mero atual na pr�xima posi��o
        MOV     R4, #1              ; Marca que uma troca foi feita

skip_swap
        ADD     R0, R0, #1          ; Incrementa o ponteiro para o pr�ximo par
        CMP     R0, R3              ; Verifica se chegou ao final da lista
        BLT     bubble_sort_inner_loop ; Se n�o, continue comparando

        CMP     R4, #0              ; Verifica se houve troca
        BEQ     end_program         ; Se n�o houve troca, a lista est� ordenada
        SUB     R3, R3, #1          ; Reduz o tamanho da lista para a pr�xima itera��o
        B       bubble_sort_outer_loop ; Repete o processo de ordena��o

end_program
	  NOP
	  ALIGN
	  END