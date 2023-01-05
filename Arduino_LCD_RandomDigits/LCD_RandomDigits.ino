//YWROBOT
//Compatible with the Arduino IDE 1.0
//Library version:1.1
#include <LiquidCrystal_I2C.h>

int array[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9} ;
char array_char[10] = {'0','1','2','3','4','5','6','7','8','9'} ;
char print_array[10] = {'0','1','2','3','4','5','6','7','8','9'} ;

LiquidCrystal_I2C lcd(0x27,20,4);  // set the LCD address to 0x27 for a 16 chars and 2 line display

void setup()
{
  Serial.begin(9600);
  randomSeed(analogRead(0));
// this is the trick
  for (int i= 0; i< 10; i++) 
  {
    int pos = random(10);
    int t = array[i];   
    array[i] = array[pos];
    array[pos] = t;
  }

  
  for (int i= 0; i< 10; i++)
  {
    print_array[i] = array_char[array[i]];
    Serial.println(array_char[array[i]]);
  }  
    
  lcd.init();                      // initialize the lcd 
  // Print a message to the LCD.
  lcd.backlight();
  lcd.setCursor(3,0);
  lcd.print(print_array[0]);
  lcd.print(print_array[1]);
  lcd.print(print_array[2]);
  lcd.print(print_array[3]);
  lcd.print(print_array[4]);
  lcd.print(print_array[5]);
  lcd.print(print_array[6]);
  lcd.print(print_array[7]);
  lcd.print(print_array[8]);
  lcd.print(print_array[9]);
  lcd.setCursor(2,1);
  lcd.print("");
  lcd.setCursor(0,2);
  lcd.print("");
  lcd.setCursor(2,3);
  lcd.print("");
}


void loop()
{
  randomSeed(analogRead(0));
// this is the trick
  for (int i= 0; i< 10; i++) 
  {
    int pos = random(10);
    int t = array[i];   
    array[i] = array[pos];
    array[pos] = t;
  }

  
  for (int i= 0; i< 10; i++)
  {
    print_array[i] = array_char[array[i]];
    Serial.println(array_char[array[i]]);
  }  
    
  lcd.backlight();
  lcd.setCursor(3,0);
  lcd.print(print_array[0]);
  lcd.print(print_array[1]);
  lcd.print(print_array[2]);
  lcd.print(print_array[3]);
  lcd.print(print_array[4]);
  lcd.print(print_array[5]);
  lcd.print(print_array[6]);
  lcd.print(print_array[7]);
  lcd.print(print_array[8]);
  lcd.print(print_array[9]);
  lcd.setCursor(2,1);
  lcd.print("");
  lcd.setCursor(0,2);
  lcd.print("");
  lcd.setCursor(2,3);
  lcd.print("");

  delay(5000);                // waits for a second  
}
