		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2

		IMPORT GPIO_PORTA_AHB_DATA_R
		EXPORT CheckDirectionButton

CheckDirectionButton
    
	PUSH {R0, R1, R2}   

    LDR R0, =GPIO_PORTA_AHB_DATA_R
    LDR R1, =0x04          

    LDR R2, [R0]           
    TST R2, R1             

    LDR R2, =DirectionButtonState   
    TST R2, R1             
    BEQ NoDirectionChange  

    LDR R3, =CurrentDirection
    LDR R2, [R3]           
    RSBS R2, R2, #0        
    STR R2, [R3]           

    LDR R2, =DirectionButtonState
    STR R1, [R2]           

NoDirectionChange
    LDR R2, [R0]           
    TST R2, R1             
    BNE Done               

    LDR R2, =DirectionButtonState
    STR R0, [R2]           

Done
    POP {R0-R2}            
    BX LR                  

DirectionButtonState
    DCD 0x00               

CurrentDirection
    DCD 1                  
		
	ALIGN
	END