		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2
			
		IMPORT PortJ_Input	
		EXPORT CheckStepButton
			
			
CheckStepButton
    PUSH {LR}           
	CMP R0, #2_10 
	BNE	Continue          
	
ButtonPress
	CMP R6, #0
	BGT Soma1
	NEG R6, R6
Soma1
    ADD R6, R6, #1        
    CMP R6, #10            
    BNE Continue            
    MOV R6, #1             

Continue
    POP {LR}           
    BX LR               
                         
	ALIGN
	END