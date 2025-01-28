		THUMB

		AREA    |.text|, CODE, READONLY, ALIGN=2

		IMPORT PortA_Output
		IMPORT PortB_Output
		IMPORT PortP_Output	
		IMPORT PortQ_Output
		IMPORT SysTick_Wait1ms
		IMPORT SysTick_Wait1us
		IMPORT SysTick_Wait	

		EXPORT DisplayValue
		EXPORT StoreDisplayAddress			

SEVEN_SEG_DECODER EQU 0x20000A00

StoreDisplayAddress
    LDR R0, =SEVEN_SEG_DECODER
    MOV R1, #0x3F
    STR R1, [R0]               ; Store at SEVEN_SEG_DECODER base address
    MOV R1, #0x06
    STR R1, [R0, #1]           ; Store at SEVEN_SEG_DECODER + 1
    MOV R1, #0x5B
    STR R1, [R0, #2]           ; Store at SEVEN_SEG_DECODER + 2
    MOV R1, #0x4F
    STR R1, [R0, #3]           ; Store at SEVEN_SEG_DECODER + 3
    MOV R1, #0x66
    STR R1, [R0, #4]           ; Store at SEVEN_SEG_DECODER + 4
    MOV R1, #0x6D
    STR R1, [R0, #5]           ; Store at SEVEN_SEG_DECODER + 5
    MOV R1, #0x7D
    STR R1, [R0, #6]           ; Store at SEVEN_SEG_DECODER + 6
    MOV R1, #0x07
    STR R1, [R0, #7]           ; Store at SEVEN_SEG_DECODER + 7
    MOV R1, #0x7F
    STR R1, [R0, #8]           ; Store at SEVEN_SEG_DECODER + 8
    MOV R1, #0x6F
    STR R1, [R0, #9]           ; Store at SEVEN_SEG_DECODER + 9

    BX LR

DisplayValue
    PUSH {R0, R1, R8, R3, R4, R5, LR}
	
	MOV R0, #2_000000
	BL PortB_Output
	MOV R0, #2_100000
	BL PortP_Output
	MOV R0, R8
	BL PortQ_Output
	BL PortA_Output

	MOV R0, #100
	BL SysTick_Wait1ms


	MOV R0, #2_000000
	BL PortP_Output
    MOV R0, R8              
    MOV R1, #10
    UDIV R3, R0, R1         
    MLS R4, R3, R1, R0      
	
	MOV R0, #2_10000
    BL	PortB_Output
	MOV R5, R3
    LDR R1, =SEVEN_SEG_DECODER
	ADD R1, R1, R5
    LDRB R0, [R1]
	BL PortA_Output
	BL PortQ_Output
	
	MOV R0, #100
	BL SysTick_Wait1ms
	
	MOV R0, #2_100000
    BL	PortB_Output
    MOV R5, R4              
    LDR R1, =SEVEN_SEG_DECODER
	ADD R1, R1, R5
    LDRB R0, [R1]
	BL PortA_Output
	BL PortQ_Output
	
	MOV R0, #100
	BL SysTick_Wait1ms
	
    POP {R0, R1, R8, R3, R4, R5, LR}             
    BX LR                   

	ALIGN
	END