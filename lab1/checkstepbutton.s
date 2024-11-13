		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2
			
		IMPORT PortJ_Input	
		EXPORT CheckStepButton
			
			
CheckStepButton
    PUSH {R0, R1, R6, LR}
		
    BL	PortJ_Input
    LDR R1, =2_00000          
	TST R0, R1
	BNE	Continue          

ButtonPress
    ADD R6, R6, #1        
    CMP R6, #10            
    BNE Continue            
    MOV R6, #1             

Continue
    POP {R0, R1, R6, LR}           
    BX LR               
                         
	ALIGN
	END