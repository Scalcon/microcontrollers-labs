		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2

		IMPORT PortJ_Input
		EXPORT CheckDirectionButton

CheckDirectionButton
    PUSH {R0, R1, R6, LR}
		
    BL	PortJ_Input
    LDR R1, = 2_000000          
	TST R0, R1
	BNE	Continue          

ButtonPress
    RSB R6, R6, #0                   

Continue
    POP {R0, R1, R6, LR}           
    BX LR               
                         
	ALIGN
	END