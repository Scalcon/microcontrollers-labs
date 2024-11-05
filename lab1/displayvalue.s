		THUMB

		AREA    |.text|, CODE, READONLY, ALIGN=2

		IMPORT GPIO_PORTB_AHB_DATA_R
		IMPORT GPIO_PORTA_AHB_DATA_R
		IMPORT  SysTick_Wait1ms		

		EXPORT DisplayValue			

DisplayValue
    PUSH {R0, R1, R2, R3, R4, R5}

    MOV R0, R2              
    MOV R1, #10
    UDIV R3, R0, R1         
    MLS R4, R3, R1, R0      

    BL DisplayDigit
    LDR R0, =GPIO_PORTB_AHB_DATA_R
    MOV R1, #0x10           
    STR R1, [R0]
    BL SysTick_Wait1ms			             
    MOV R1, #0x00           
    STR R1, [R0]

    MOV R0, R4              
    BL DisplayDigit
    LDR R0, =GPIO_PORTB_AHB_DATA_R
    MOV R1, #0x20           
    STR R1, [R0]
    BL SysTick_Wait1ms			             
    MOV R1, #0x00           
    STR R1, [R0]

    POP {R0-R5}             
    BX LR                   

DisplayDigit
    LDR R1, =SegmentMap     
    LDRB R2, [R1, R0]      
    LDR R3, =GPIO_PORTA_AHB_DATA_R
    STR R2, [R3]            

    BX LR                   
	
	
SegmentMap DCB 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

	ALIGN
	END