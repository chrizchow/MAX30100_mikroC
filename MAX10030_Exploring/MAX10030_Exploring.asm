_MAX10030_Read:
;MAX10030_Exploring.c,8 :: 		char MAX10030_Read(char reg)
; reg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; reg end address is: 0 (R0)
; reg start address is: 16 (R4)
;MAX10030_Exploring.c,10 :: 		char take = 0;
;MAX10030_Exploring.c,12 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,13 :: 		Soft_I2C_Write(0xAE);
MOVS	R0, #174
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,14 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,15 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,16 :: 		Soft_I2C_Write(0xAF);
MOVS	R0, #175
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,17 :: 		take = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
; take start address is: 8 (R2)
UXTB	R2, R0
;MAX10030_Exploring.c,18 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,20 :: 		return take;
UXTB	R0, R2
; take end address is: 8 (R2)
;MAX10030_Exploring.c,22 :: 		}
L_end_MAX10030_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX10030_Read
_MAX10030_Write:
;MAX10030_Exploring.c,24 :: 		void MAX10030_Write(char reg, char value)
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
;MAX10030_Exploring.c,26 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,27 :: 		Soft_I2C_Write(0xAE);
MOVS	R0, #174
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,28 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,29 :: 		Soft_I2C_Write(value);
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,30 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,32 :: 		}
L_end_MAX10030_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MAX10030_Write
_M24C02_Read:
;MAX10030_Exploring.c,34 :: 		void M24C02_Read(char address, char* array, char count)
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
;MAX10030_Exploring.c,36 :: 		char i = 0;
;MAX10030_Exploring.c,38 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,39 :: 		Soft_I2C_Write(0xA0);
MOVS	R0, #160
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,40 :: 		Soft_I2C_Write(address);
UXTB	R0, R6
; address end address is: 24 (R6)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,41 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,42 :: 		Soft_I2C_Write(0xA1);
MOVS	R0, #161
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,43 :: 		for(i=0; i<count-1; i++){
; i start address is: 32 (R8)
MOVW	R8, #0
; array end address is: 16 (R4)
; count end address is: 20 (R5)
; i end address is: 32 (R8)
MOV	R6, R4
L_M24C02_Read0:
; i start address is: 32 (R8)
; count start address is: 20 (R5)
; array start address is: 24 (R6)
SUBS	R3, R5, #1
SXTH	R3, R3
CMP	R8, R3
IT	GE
BGE	L_M24C02_Read1
;MAX10030_Exploring.c,44 :: 		*(array+i) = Soft_I2C_Read(1);    //ACK
ADD	R3, R6, R8, LSL #0
STR	R3, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDR	R3, [SP, #4]
STRB	R0, [R3, #0]
;MAX10030_Exploring.c,43 :: 		for(i=0; i<count-1; i++){
ADD	R8, R8, #1
UXTB	R8, R8
;MAX10030_Exploring.c,45 :: 		}
; i end address is: 32 (R8)
IT	AL
BAL	L_M24C02_Read0
L_M24C02_Read1:
;MAX10030_Exploring.c,46 :: 		*(array+count-1) = Soft_I2C_Read(0); //last should be NACK
ADDS	R3, R6, R5
; count end address is: 20 (R5)
; array end address is: 24 (R6)
SUBS	R3, R3, #1
STR	R3, [SP, #4]
MOVS	R0, #0
BL	_Soft_I2C_Read+0
LDR	R3, [SP, #4]
STRB	R0, [R3, #0]
;MAX10030_Exploring.c,47 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,49 :: 		}
L_end_M24C02_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _M24C02_Read
_M24C02_Write:
;MAX10030_Exploring.c,51 :: 		void M24C02_Write(char reg, char value)
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
;MAX10030_Exploring.c,53 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;MAX10030_Exploring.c,54 :: 		Soft_I2C_Write(0xA0);
MOVS	R0, #160
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,55 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,56 :: 		Soft_I2C_Write(value);
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_Soft_I2C_Write+0
;MAX10030_Exploring.c,57 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;MAX10030_Exploring.c,58 :: 		delay_ms(30);
MOVW	R7, #28926
MOVT	R7, #2
NOP
NOP
L_M24C02_Write3:
SUBS	R7, R7, #1
BNE	L_M24C02_Write3
NOP
NOP
NOP
;MAX10030_Exploring.c,59 :: 		}
L_end_M24C02_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _M24C02_Write
_main:
;MAX10030_Exploring.c,64 :: 		void main() {
SUB	SP, SP, #4
;MAX10030_Exploring.c,65 :: 		delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main5:
SUBS	R7, R7, #1
BNE	L_main5
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,66 :: 		Soft_I2C_Init();
BL	_Soft_I2C_Init+0
;MAX10030_Exploring.c,67 :: 		delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main7:
SUBS	R7, R7, #1
BNE	L_main7
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,68 :: 		MAX10030_Write(0x06, 0x80);
MOVS	R1, #128
MOVS	R0, #6
BL	_MAX10030_Write+0
;MAX10030_Exploring.c,74 :: 		while(1){
L_main9:
;MAX10030_Exploring.c,75 :: 		delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,76 :: 		result = MAX10030_Read(0xFF);
MOVS	R0, #255
BL	_MAX10030_Read+0
MOVW	R1, #lo_addr(_result+0)
MOVT	R1, #hi_addr(_result+0)
STRB	R0, [R1, #0]
;MAX10030_Exploring.c,77 :: 		delay_ms(1);
MOVW	R7, #5331
MOVT	R7, #0
NOP
NOP
L_main13:
SUBS	R7, R7, #1
BNE	L_main13
NOP
NOP
NOP
NOP
;MAX10030_Exploring.c,78 :: 		}
IT	AL
BAL	L_main9
;MAX10030_Exploring.c,79 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
