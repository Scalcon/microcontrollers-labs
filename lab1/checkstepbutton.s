		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2
			
		IMPORT GPIO_PORTA_AHB_DATA_R	
		EXPORT CheckStepButton
			
			
CheckStepButton
    PUSH {R0, R1, R2}

    LDR R0, =GPIO_PORTA_AHB_DATA_R
    LDR R1, =0x08          

    LDR R2, [R0]           
    TST R2, R1            

    LDR R2, =ButtonState
    TST R2, R1             
    BEQ NoPress           

    ADD R4, R4, #1         
    CMP R4, #10            
    BNE Continue           
    MOV R4, #1             

Continue
    LDR R2, =ButtonState
    STR R1, [R2]           

NoPress
    LDR R2, [R0]           
    TST R2, R1             
    BNE Done               

    LDR R2, =ButtonState
    STR R0, [R2]           

Done
    POP {R0-R2}            
    BX LR                  

ButtonState
    DCD 0x00         

	ALIGN
	END