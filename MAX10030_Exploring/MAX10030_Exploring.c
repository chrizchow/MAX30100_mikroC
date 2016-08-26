// Software I2C connections
sbit Soft_I2C_Scl_Output    at GPIOB_ODR.B6;
sbit Soft_I2C_Scl_Input     at GPIOB_IDR.B6;
sbit Soft_I2C_Sda_Output    at GPIOB_ODR.B7;
sbit Soft_I2C_Sda_Input     at GPIOB_IDR.B7;
// End Software I2C connections

char MAX10030_Read(char reg)
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

void MAX10030_Write(char reg, char value)
{
   Soft_I2C_Start();
   Soft_I2C_Write(0xAE);
   Soft_I2C_Write(reg);
   Soft_I2C_Write(value);
   Soft_I2C_Stop();
   
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
      *(array+i) = Soft_I2C_Read(1);    //ACK
   }
   *(array+count-1) = Soft_I2C_Read(0); //last should be NACK
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
char array[128];

void main() {
   delay_ms(1000);
   Soft_I2C_Init();
   delay_ms(1000);
   MAX10030_Write(0x06, 0x80);
   //M24C02_Write(0x00, 'A');
   //M24C02_Write(0x01, 'B');
   //M24C02_Write(0x02, 'C');
   //M24C02_Read(0x00, array, 128);
   
   while(1){
      delay_ms(1000);
      result = MAX10030_Read(0xFF);
      delay_ms(1);
   }
}