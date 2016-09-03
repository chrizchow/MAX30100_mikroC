// Software I2C connections
sbit Soft_I2C_Scl_Output    at GPIOB_ODR.B6;
sbit Soft_I2C_Scl_Input     at GPIOB_IDR.B6;
sbit Soft_I2C_Sda_Output    at GPIOB_ODR.B7;
sbit Soft_I2C_Sda_Input     at GPIOB_IDR.B7;
// End Software I2C connections

char MAX30100_PARTID;
char MAX30100_INTERRUPT_STATUS;
int SPO2_Table[1152];
int HR_Table[1152];
int times = 0;

// *************** Basic IO of MAX30100 ***************
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
   //int i, ir_15_8 ,ir_7_0, red_15_8, red_7_0;
   Soft_I2C_Start();
   Soft_I2C_Write(0xAE);
   Soft_I2C_Write(0x05); //the FIFO Data register
   Soft_I2C_Start();
   Soft_I2C_Write(0xAF);
   for(i=0 ; i<count; i++){
      ir_15_8 = Soft_I2C_Read(1);
      ir_7_0 = Soft_I2C_Read(1);
      red_15_8 = Soft_I2C_Read(1);
      if(i!=count-1){ 
         red_7_0 = Soft_I2C_Read(1);
      }else{ 
         red_7_0 = Soft_I2C_Read(0);   //last byte should be NACK
      }
      
      *(SPO2+i) = ir_15_8<<8 | ir_7_0;
      *(HR+i) = red_15_8<<8 | red_7_0;
   }
   Soft_I2C_Stop();

}


// *************** Interrupt IO of MAX30100 ***************
// Use PB.2 as interrupt pin
void INTERRUPT() iv IVT_INT_EXTI2 ics ICS_AUTO {
  EXTI_PR.B2 = 1;                     // clear flag
  //Do something else:
  /*
  if(times<=71){
     MAX30100_FIFO_Read(SPO2_Table+16*times, HR_Table+16*times, 16);
     times++;
  }else{
     delay_ms(10);
  }
  MAX30100_INTERRUPT_STATUS = MAX30100_Read(0x00);
  */
  
}

void Run() {
  //Do something else:
  if(times<=71){
     MAX30100_FIFO_Read(SPO2_Table+16*times, HR_Table+16*times, 16);
     times++;
  }else{
     delay_ms(10);
  }

}


// *************** Initialization of MAX30100 ***************
void MAX30100_Init(){
   //Wait for device to stablize:
   delay_ms(300);
   
   //Initialize Interrupt Pin (PB.2):
   GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_2);
   //GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_2, _GPIO_CFG_DIGITAL_INPUT|_GPIO_CFG_OTYPE_OD);
   RCC_APB2ENR.AFIOEN = 1;              // Enable clock for alternate pin functions
   AFIO_EXTICR1 = 0x0100;               // PB2 as External interrupt
   EXTI_FTSR = 0x00000004;              // Set interrupt on Falling edge
   //EXTI_RTSR = 0x00000004;              // Set interrupt on Rising edge
   EXTI_IMR |= 0x00000004;              // Set mask
   NVIC_IntEnable(IVT_INT_EXTI2);       // Enable External interrupt
   EnableInterrupts();                  // Enables the processor interrupt.
   
   //Shutdown the MAX30100:
   MAX30100_Write(0x06, 0x80);
   delay_ms(300);
   
   //Reset the MAX30100:
   MAX30100_Write(0x06, 0x40);
   delay_ms(300);
   
   //Check Existence:
   MAX30100_PARTID = MAX30100_Read(0xFF);
   
   //Set LED current to 50mA (highest):
   MAX30100_Write(0x09, 0xFF);
   
   //Set sample rate and pulse width:
   MAX30100_Write(0x07, (0x03|0x04));
   
   //Enable FIFO-Almost-Full and HR_RDY:
   MAX30100_Write(0x01, (0x80|0x20));
   
   //Set mode to HR-Only:
   MAX30100_Write(0x06, 0x02);
   //MAX30100_Write(0x06, 0x03); //spo2 and hrm
   

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