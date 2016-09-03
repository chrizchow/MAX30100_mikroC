_MAX30100_Read:
;MAX10030_Exploring.c,15 :: 		char MAX30100_Read(char reg)
; reg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; reg end address is: 0 (R0)
; reg start address is: 16 (R4)
;MAX10030_Exploring.c,17 :: 		char take = 0;
;MAX10030_Exploring.c,19 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,20 :: 		Soft_I2C_Write(0xAE);
MOVS	R0, #174
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,21 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,22 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,23 :: 		Soft_I2C_Write(0xAF);
MOVS	R0, #175
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,24 :: 		take = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
; take start address is: 8 (R2)
UXTB	R2, R0
;MAX10030_Exploring.c,25 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,27 :: 		return take;
UXTB	R0, R2
; take end address is: 8 (R2)
;MAX10030_Exploring.c,29 :: 		}
L_end_MAX30100_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX30100_Read
_MAX30100_Write:
;MAX10030_Exploring.c,31 :: 		void MAX30100_Write(char reg, char value)
; value start address is: 4 (R1)
; reg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
UXTB	R5, R1
; value end address is: 4 (R1)
; reg end address is: 0 (R0)
; reg start address is: 16 (R4)
; value start address is: 20 (R5)
;MAX10030_Exploring.c,33 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,34 :: 		Soft_I2C_Write(0xAE);
MOVS	R0, #174
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,35 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,36 :: 		Soft_I2C_Write(value);
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,37 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,39 :: 		}
L_end_MAX30100_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX30100_Write
_MAX30100_FIFO_Read:
;MAX10030_Exploring.c,42 :: 		void MAX30100_FIFO_Read(int* SPO2, int* HR, int count)
; count start address is: 8 (R2)
; HR start address is: 4 (R1)
; SPO2 start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
MOV	R6, R1
SXTH	R8, R2
; count end address is: 8 (R2)
; HR end address is: 4 (R1)
; SPO2 end address is: 0 (R0)
; SPO2 start address is: 20 (R5)
; HR start address is: 24 (R6)
; count start address is: 32 (R8)
;MAX10030_Exploring.c,45 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,46 :: 		Soft_I2C_Write(0xAE);
MOVS	R0, #174
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,47 :: 		Soft_I2C_Write(0x05); //the FIFO Data register
MOVS	R0, #5
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,48 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,49 :: 		Soft_I2C_Write(0xAF);
MOVS	R0, #175
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,50 :: 		for(i=0 ; i<count; i++){
MOVS	R4, #0
SXTH	R4, R4
MOVW	R3, #lo_addr(_i+0)
MOVT	R3, #hi_addr(_i+0)
STRH	R4, [R3, #0]
; SPO2 end address is: 20 (R5)
; HR end address is: 24 (R6)
; count end address is: 32 (R8)
MOV	R10, R5
MOV	R9, R6
L_MAX30100_FIFO_Read0:
; SPO2 start address is: 40 (R10)
; HR start address is: 36 (R9)
; count start address is: 32 (R8)
; HR start address is: 36 (R9)
; HR end address is: 36 (R9)
; SPO2 start address is: 40 (R10)
; SPO2 end address is: 40 (R10)
MOVW	R3, #lo_addr(_i+0)
MOVT	R3, #hi_addr(_i+0)
LDRSH	R3, [R3, #0]
CMP	R3, R8
IT	GE
BGE	L_MAX30100_FIFO_Read1
; HR end address is: 36 (R9)
; SPO2 end address is: 40 (R10)
;MAX10030_Exploring.c,51 :: 		ir_15_8 = Soft_I2C_Read(1);
; SPO2 start address is: 40 (R10)
; HR start address is: 36 (R9)
MOVS	R0, #1
BL	_Soft_I2C_Read+0
MOVW	R3, #lo_addr(_ir_15_8+0)
MOVT	R3, #hi_addr(_ir_15_8+0)
STRH	R0, [R3, #0]
;MAX10030_Exploring.c,52 :: 		ir_7_0 = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
MOVW	R3, #lo_addr(_ir_7_0+0)
MOVT	R3, #hi_addr(_ir_7_0+0)
STRH	R0, [R3, #0]
;MAX10030_Exploring.c,53 :: 		red_15_8 = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
MOVW	R3, #lo_addr(_red_15_8+0)
MOVT	R3, #hi_addr(_red_15_8+0)
STRH	R0, [R3, #0]
;MAX10030_Exploring.c,54 :: 		if(i!=count-1){
SUB	R4, R8, #1
SXTH	R4, R4
MOVW	R3, #lo_addr(_i+0)
MOVT	R3, #hi_addr(_i+0)
LDRSH	R3, [R3, #0]
CMP	R3, R4
IT	EQ
BEQ	L_MAX30100_FIFO_Read3
;MAX10030_Exploring.c,55 :: 		red_7_0 = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
MOVW	R3, #lo_addr(_red_7_0+0)
MOVT	R3, #hi_addr(_red_7_0+0)
STRH	R0, [R3, #0]
;MAX10030_Exploring.c,56 :: 		}else{
IT	AL
BAL	L_MAX30100_FIFO_Read4
L_MAX30100_FIFO_Read3:
;MAX10030_Exploring.c,57 :: 		red_7_0 = Soft_I2C_Read(0);   //last byte should be NACK
MOVS	R0, #0
BL	_Soft_I2C_Read+0
MOVW	R3, #lo_addr(_red_7_0+0)
MOVT	R3, #hi_addr(_red_7_0+0)
STRH	R0, [R3, #0]
;MAX10030_Exploring.c,58 :: 		}
L_MAX30100_FIFO_Read4:
;MAX10030_Exploring.c,60 :: 		*(SPO2+i) = ir_15_8<<8 | ir_7_0;
MOVW	R6, #lo_addr(_i+0)
MOVT	R6, #hi_addr(_i+0)
LDRSH	R3, [R6, #0]
LSLS	R3, R3, #1
ADD	R5, R10, R3, LSL #0
MOVW	R3, #lo_addr(_ir_15_8+0)
MOVT	R3, #hi_addr(_ir_15_8+0)
LDRSH	R3, [R3, #0]
LSLS	R4, R3, #8
SXTH	R4, R4
MOVW	R3, #lo_addr(_ir_7_0+0)
MOVT	R3, #hi_addr(_ir_7_0+0)
LDRSH	R3, [R3, #0]
ORR	R3, R4, R3, LSL #0
STRH	R3, [R5, #0]
;MAX10030_Exploring.c,61 :: 		*(HR+i) = red_15_8<<8 | red_7_0;
MOV	R3, R6
LDRSH	R3, [R3, #0]
LSLS	R3, R3, #1
ADD	R5, R9, R3, LSL #0
MOVW	R3, #lo_addr(_red_15_8+0)
MOVT	R3, #hi_addr(_red_15_8+0)
LDRSH	R3, [R3, #0]
LSLS	R4, R3, #8
SXTH	R4, R4
MOVW	R3, #lo_addr(_red_7_0+0)
MOVT	R3, #hi_addr(_red_7_0+0)
LDRSH	R3, [R3, #0]
ORR	R3, R4, R3, LSL #0
STRH	R3, [R5, #0]
;MAX10030_Exploring.c,50 :: 		for(i=0 ; i<count; i++){
MOV	R3, R6
LDRSH	R3, [R3, #0]
ADDS	R3, R3, #1
STRH	R3, [R6, #0]
;MAX10030_Exploring.c,62 :: 		}
; count end address is: 32 (R8)
; HR end address is: 36 (R9)
; SPO2 end address is: 40 (R10)
IT	AL
BAL	L_MAX30100_FIFO_Read0
L_MAX30100_FIFO_Read1:
;MAX10030_Exploring.c,63 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,65 :: 		}
L_end_MAX30100_FIFO_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX30100_FIFO_Read
_INTERRUPT:
;MAX10030_Exploring.c,70 :: 		void INTERRUPT() iv IVT_INT_EXTI2 ics ICS_AUTO {
SUB	SP, SP, #4
;MAX10030_Exploring.c,71 :: 		EXTI_PR.B2 = 1;                     // clear flag
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;MAX10030_Exploring.c,83 :: 		}
L_end_INTERRUPT:
ADD	SP, SP, #4
BX	LR
; end of _INTERRUPT
_Run:
;MAX10030_Exploring.c,85 :: 		void Run() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MAX10030_Exploring.c,87 :: 		if(times<=71){
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
LDRSH	R0, [R0, #0]
CMP	R0, #71
IT	GT
BGT	L_Run5
;MAX10030_Exploring.c,88 :: 		MAX30100_FIFO_Read(SPO2_Table+16*times, HR_Table+16*times, 16);
MOVW	R0, #lo_addr(_times+0)
MOVT	R0, #hi_addr(_times+0)
LDRSH	R0, [R0, #0]
LSLS	R0, R0, #4
SXTH	R0, R0
LSLS	R2, R0, #1
MOVW	R0, #lo_addr(_HR_Table+0)
MOVT	R0, #hi_addr(_HR_Table+0)
ADDS	R1, R0, R2
MOVW	R0, #lo_addr(_SPO2_Table+0)
MOVT	R0, #hi_addr(_SPO2_Table+0)
ADDS	R0, R0, R2
MOVS	R2, #16
SXTH	R2, R2
BL	_MAX30100_FIFO_Read+0
;MAX10030_Exploring.c,89 :: 		times++;
MOVW	R1, #lo_addr(_times+0)
MOVT	R1, #hi_addr(_times+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;MAX10030_Exploring.c,90 :: 		}else{
IT	AL
BAL	L_Run6
L_Run5:
;MAX10030_Exploring.c,91 :: 		delay_ms(10);
MOVW	R7, #53331
MOVT	R7, #0
NOP
NOP
L_Run7:
SUBS	R7, R7, #1
BNE	L_Run7
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,92 :: 		}
L_Run6:
;MAX10030_Exploring.c,94 :: 		}
L_end_Run:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Run
_MAX30100_Init:
;MAX10030_Exploring.c,98 :: 		void MAX30100_Init(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MAX10030_Exploring.c,100 :: 		delay_ms(300);
MOVW	R7, #27134
MOVT	R7, #24
NOP
NOP
L_MAX30100_Init9:
SUBS	R7, R7, #1
BNE	L_MAX30100_Init9
NOP
NOP
NOP
;MAX10030_Exploring.c,103 :: 		GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_2);
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;MAX10030_Exploring.c,105 :: 		RCC_APB2ENR.AFIOEN = 1;              // Enable clock for alternate pin functions
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;MAX10030_Exploring.c,106 :: 		AFIO_EXTICR1 = 0x0100;               // PB2 as External interrupt
MOVW	R1, #256
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;MAX10030_Exploring.c,107 :: 		EXTI_FTSR = 0x00000004;              // Set interrupt on Falling edge
MOVS	R1, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;MAX10030_Exploring.c,109 :: 		EXTI_IMR |= 0x00000004;              // Set mask
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;MAX10030_Exploring.c,110 :: 		NVIC_IntEnable(IVT_INT_EXTI2);       // Enable External interrupt
MOVW	R0, #24
BL	_NVIC_IntEnable+0
;MAX10030_Exploring.c,111 :: 		EnableInterrupts();                  // Enables the processor interrupt.
BL	_EnableInterrupts+0
;MAX10030_Exploring.c,114 :: 		MAX30100_Write(0x06, 0x80);
MOVS	R1, #128
MOVS	R0, #6
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,115 :: 		delay_ms(300);
MOVW	R7, #27134
MOVT	R7, #24
NOP
NOP
L_MAX30100_Init11:
SUBS	R7, R7, #1
BNE	L_MAX30100_Init11
NOP
NOP
NOP
;MAX10030_Exploring.c,118 :: 		MAX30100_Write(0x06, 0x40);
MOVS	R1, #64
MOVS	R0, #6
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,119 :: 		delay_ms(300);
MOVW	R7, #27134
MOVT	R7, #24
NOP
NOP
L_MAX30100_Init13:
SUBS	R7, R7, #1
BNE	L_MAX30100_Init13
NOP
NOP
NOP
;MAX10030_Exploring.c,122 :: 		MAX30100_PARTID = MAX30100_Read(0xFF);
MOVS	R0, #255
BL	_MAX30100_Read+0
MOVW	R1, #lo_addr(_MAX30100_PARTID+0)
MOVT	R1, #hi_addr(_MAX30100_PARTID+0)
STRB	R0, [R1, #0]
;MAX10030_Exploring.c,125 :: 		MAX30100_Write(0x09, 0xFF);
MOVS	R1, #255
MOVS	R0, #9
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,128 :: 		MAX30100_Write(0x07, (0x03|0x04));
MOVS	R1, #7
MOVS	R0, #7
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,131 :: 		MAX30100_Write(0x01, (0x80|0x20));
MOVS	R1, #160
MOVS	R0, #1
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,134 :: 		MAX30100_Write(0x06, 0x02);
MOVS	R1, #2
MOVS	R0, #6
BL	_MAX30100_Write+0
;MAX10030_Exploring.c,138 :: 		}
L_end_MAX30100_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX30100_Init
_M24C02_Read:
;MAX10030_Exploring.c,143 :: 		void M24C02_Read(char address, char* array, char count)
; count start address is: 8 (R2)
; array start address is: 4 (R1)
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R6, R0
MOV	R4, R1
UXTB	R5, R2
; count end address is: 8 (R2)
; array end address is: 4 (R1)
; address end address is: 0 (R0)
; address start address is: 24 (R6)
; array start address is: 16 (R4)
; count start address is: 20 (R5)
;MAX10030_Exploring.c,145 :: 		char i = 0;
;MAX10030_Exploring.c,147 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,148 :: 		Soft_I2C_Write(0xA0);
MOVS	R0, #160
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,149 :: 		Soft_I2C_Write(address);
UXTB	R0, R6
; address end address is: 24 (R6)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,150 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,151 :: 		Soft_I2C_Write(0xA1);
MOVS	R0, #161
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,152 :: 		for(i=0; i<count-1; i++){
; i start address is: 32 (R8)
MOVW	R8, #0
; array end address is: 16 (R4)
; count end address is: 20 (R5)
; i end address is: 32 (R8)
MOV	R6, R4
L_M24C02_Read15:
; i start address is: 32 (R8)
; count start address is: 20 (R5)
; array start address is: 24 (R6)
SUBS	R3, R5, #1
SXTH	R3, R3
CMP	R8, R3
IT	GE
BGE	L_M24C02_Read16
;MAX10030_Exploring.c,153 :: 		*(array+i) = Soft_I2C_Read(1);    //ACK
ADD	R3, R6, R8, LSL #0
STR	R3, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDR	R3, [SP, #4]
STRB	R0, [R3, #0]
;MAX10030_Exploring.c,152 :: 		for(i=0; i<count-1; i++){
ADD	R8, R8, #1
UXTB	R8, R8
;MAX10030_Exploring.c,154 :: 		}
; i end address is: 32 (R8)
IT	AL
BAL	L_M24C02_Read15
L_M24C02_Read16:
;MAX10030_Exploring.c,155 :: 		*(array+count-1) = Soft_I2C_Read(0); //last should be NACK
ADDS	R3, R6, R5
; count end address is: 20 (R5)
; array end address is: 24 (R6)
SUBS	R3, R3, #1
STR	R3, [SP, #4]
MOVS	R0, #0
BL	_Soft_I2C_Read+0
LDR	R3, [SP, #4]
STRB	R0, [R3, #0]
;MAX10030_Exploring.c,156 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,158 :: 		}
L_end_M24C02_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _M24C02_Read
_M24C02_Write:
;MAX10030_Exploring.c,160 :: 		void M24C02_Write(char reg, char value)
; value start address is: 4 (R1)
; reg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
UXTB	R5, R1
; value end address is: 4 (R1)
; reg end address is: 0 (R0)
; reg start address is: 16 (R4)
; value start address is: 20 (R5)
;MAX10030_Exploring.c,162 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,163 :: 		Soft_I2C_Write(0xA0);
MOVS	R0, #160
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,164 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,165 :: 		Soft_I2C_Write(value);
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,166 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,167 :: 		delay_ms(30);
MOVW	R7, #28926
MOVT	R7, #2
NOP
NOP
L_M24C02_Write18:
SUBS	R7, R7, #1
BNE	L_M24C02_Write18
NOP
NOP
NOP
;MAX10030_Exploring.c,168 :: 		}
L_end_M24C02_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _M24C02_Write
_main:
;MAX10030_Exploring.c,174 :: 		void main() {
SUB	SP, SP, #4
;MAX10030_Exploring.c,175 :: 		delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,176 :: 		Soft_I2C_Init();
BL	_Soft_I2C_Init+0
;MAX10030_Exploring.c,177 :: 		MAX30100_Init();
BL	_MAX30100_Init+0
;MAX10030_Exploring.c,179 :: 		while(1){
L_main22:
;MAX10030_Exploring.c,180 :: 		MAX30100_INTERRUPT_STATUS = MAX30100_Read(0x00);
MOVS	R0, #0
BL	_MAX30100_Read+0
MOVW	R1, #lo_addr(_MAX30100_INTERRUPT_STATUS+0)
MOVT	R1, #hi_addr(_MAX30100_INTERRUPT_STATUS+0)
STRB	R0, [R1, #0]
;MAX10030_Exploring.c,181 :: 		if(MAX30100_INTERRUPT_STATUS==0xA0){
CMP	R0, #160
IT	NE
BNE	L_main24
;MAX10030_Exploring.c,182 :: 		Run();
BL	_Run+0
;MAX10030_Exploring.c,183 :: 		}else{
IT	AL
BAL	L_main25
L_main24:
;MAX10030_Exploring.c,184 :: 		delay_ms(10);
MOVW	R7, #53331
MOVT	R7, #0
NOP
NOP
L_main26:
SUBS	R7, R7, #1
BNE	L_main26
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,185 :: 		}
L_main25:
;MAX10030_Exploring.c,186 :: 		}
IT	AL
BAL	L_main22
;MAX10030_Exploring.c,187 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
