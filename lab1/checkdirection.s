		THUMB

        AREA    |.text|, CODE, READONLY, ALIGN=2

		IMPORT PortJ_Input
		EXPORT CheckDirectionButton

CheckDirectionButton
    PUSH {LR}   
	CMP R0, #2_01
	BNE	Continue          

ButtonPress
    NEG R6, R6                 

Continue
    POP {LR}           
    BX LR               
                         
	ALIGN
	END