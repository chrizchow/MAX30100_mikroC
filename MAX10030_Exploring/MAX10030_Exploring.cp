#line 1 "C:/Users/cmc7/Desktop/MAX10030_Exploring/MAX10030_Exploring.c"

sbit Soft_I2C_Scl_Output at GPIOB_ODR.B6;
sbit Soft_I2C_Scl_Input at GPIOB_IDR.B6;
sbit Soft_I2C_Sda_Output at GPIOB_ODR.B7;
sbit Soft_I2C_Sda_Input at GPIOB_IDR.B7;


char MAX30100_PARTID;
char MAX30100_INTERRUPT_STATUS;
int SPO2_Table[1152];
int HR_Table[1152];
int times = 0;


char MAX30100_Read(char reg)
{
 char take = 0;

 Soft_I2C_Start();
 Soft_I2C_Write(0xAE);
 Soft_I2C_Write(reg);
 Soft_I2C_Start();
 Soft_I2C_Write(0xAF);
 take = Soft_I2C_Read(0);
 Soft_I2C_Stop();

 return take;

}

void MAX30100_Write(char reg, char value)
{
 Soft_I2C_Start();
 Soft_I2C_Write(0xAE);
 Soft_I2C_Write(reg);
 Soft_I2C_Write(value);
 Soft_I2C_Stop();

}

int i, ir_15_8 ,ir_7_0, red_15_8, red_7_0;
void MAX30100_FIFO_Read(int* SPO2, int* HR, int count)
{

 Soft_I2C_Start();
 Soft_I2C_Write(0xAE);
 Soft_I2C_Write(0x05);
 Soft_I2C_Start();
 Soft_I2C_Write(0xAF);
 for(i=0 ; i<count; i++){
 ir_15_8 = Soft_I2C_Read(1);
 ir_7_0 = Soft_I2C_Read(1);
 red_15_8 = Soft_I2C_Read(1);
 if(i!=count-1){
 red_7_0 = Soft_I2C_Read(1);
 }else{
 red_7_0 = Soft_I2C_Read(0);
 }

 *(SPO2+i) = ir_15_8<<8 | ir_7_0;
 *(HR+i) = red_15_8<<8 | red_7_0;
 }
 Soft_I2C_Stop();

}




void INTERRUPT() iv IVT_INT_EXTI2 ics ICS_AUTO {
 EXTI_PR.B2 = 1;
#line 83 "C:/Users/cmc7/Desktop/MAX10030_Exploring/MAX10030_Exploring.c"
}

void Run() {

 if(times<=71){
 MAX30100_FIFO_Read(SPO2_Table+16*times, HR_Table+16*times, 16);
 times++;
 }else{
 delay_ms(10);
 }

}



void MAX30100_Init(){

 delay_ms(300);


 GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_2);

 RCC_APB2ENR.AFIOEN = 1;
 AFIO_EXTICR1 = 0x0100;
 EXTI_FTSR = 0x00000004;

 EXTI_IMR |= 0x00000004;
 NVIC_IntEnable(IVT_INT_EXTI2);
 EnableInterrupts();


 MAX30100_Write(0x06, 0x80);
 delay_ms(300);


 MAX30100_Write(0x06, 0x40);
 delay_ms(300);


 MAX30100_PARTID = MAX30100_Read(0xFF);


 MAX30100_Write(0x09, 0xFF);


 MAX30100_Write(0x07, (0x03|0x04));


 MAX30100_Write(0x01, (0x80|0x20));


 MAX30100_Write(0x06, 0x02);



}




void M24C02_Read(char address, char* array, char count)
{
 char i = 0;

 Soft_I2C_Start();
 Soft_I2C_Write(0xA0);
 Soft_I2C_Write(address);
 Soft_I2C_Start();
 Soft_I2C_Write(0xA1);
 for(i=0; i<count-1; i++){
 *(array+i) = Soft_I2C_Read(1);
 }
 *(array+count-1) = Soft_I2C_Read(0);
 Soft_I2C_Stop();

}

void M24C02_Write(char reg, char value)
{
 Soft_I2C_Start();
 Soft_I2C_Write(0xA0);
 Soft_I2C_Write(reg);
 Soft_I2C_Write(value);
 Soft_I2C_Stop();
 delay_ms(30);
}

char result;
int temp_value;
char array[128];

void main() {
 delay_ms(1000);
 Soft_I2C_Init();
 MAX30100_Init();

 while(1){
 MAX30100_INTERRUPT_STATUS = MAX30100_Read(0x00);
 if(MAX30100_INTERRUPT_STATUS==0xA0){
 Run();
 }else{
 delay_ms(10);
 }
 }
}
