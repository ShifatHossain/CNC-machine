#include <Servo.h>

Servo dr;
int tray = 75;
int xgrid = 30;

int sptr = 25;
int spxg = 200;

int stTR = 0;
int stXG = 0;

void setup() {
pinMode(13, OUTPUT);
pinMode(12, OUTPUT);
pinMode(11, OUTPUT);
pinMode(10, OUTPUT);
pinMode(9, OUTPUT);
pinMode(8, OUTPUT);
pinMode(7, OUTPUT);
pinMode(6, OUTPUT);
Serial.begin(9600);
dr.attach(2);
dr.write(5);
rPoTr(20);
rNeTr(20);
rPoXg(20);
rNeXg(20);
turnOffTr();
turnOffXg();
Serial.println("Program Started!");
}

char state;
int value;

void loop() {
  if(Serial.available() > 0)
  {
    state = Serial.read();
    Serial.println(state);
    if(state == '1')
    {
      rPoTr(1);
    }
    else if(state == '2')
    {
      rNeTr(1);
    }
    else if(state == '3')
    {
      rPoXg(1);
    }
    else if(state == '4')
    {
      rNeXg(1);
    }
    else if(state == '5')
    {
      while(1)
      {
        value = Serial.parseInt();
        if(value > 0)
        {
          rPoTr(value);
          break;
        }
      }
    }
    else if(state == '6')
    {
      while(1)
      {
        value = Serial.parseInt();
        if(value > 0)
        {
          rNeTr(value);
          break;
        }
      }
    }
    else if(state == '7')
    {
      while(1)
      {
        value = Serial.parseInt();
        if(value > 0)
        {
          rPoXg(value);
          break;
        }
      }
    }
    else if(state == '8')
    {
      while(1)
      {
        value = Serial.parseInt();
        if(value > 0)
        {
          rNeXg(value);
          break;
        }
      }
    }
    else if(state == '9')
    {
      while(1)
      {
        value = Serial.parseInt();
        if(value >= 1)
        {
          if(value == 1)
          {
            drill(500);
          }
          else if(value == 2)
          {
            drill(1000);
          }
          else if(value == 3)
          {
            drill(2000);
          }
          break;
        }
      }
    }
    else if(state == 'a')
    {
      turnOffTr();
    }
    else if(state == 'b')
    {
      turnOffXg();
    }
    else if(state == 'c')
    {
      while(1)
      {
        rPoTr(1);
        if(Serial.read() == 'h')
        {
          turnOffTr();
          break;
        }
      }
    }
    else if(state == 'd')
    {
      while(1)
      {
        rNeTr(1);
        if(Serial.read() == 'h')
        {
          turnOffTr();
          break;
        }
      }
    }
    else if(state == 'e')
    {
      while(1)
      {
        rPoXg(1);
        if(Serial.read() == 'h')
        {
          turnOffXg();
          break;
        }
      }
    }
    else if(state == 'f')
    {
      while(1)
      {
        rNeXg(1);
        if(Serial.read() == 'h')
        {
          turnOffXg();
          break;
        }
      }
    }
    else if(state == 'q')
    {
      dDown();
    }
    else if(state == 'w')
    {
      dUp();
    }
  }

}

void rPoTr(int steps) // Positive direction - 
{
  for(int i=0;i<steps;i++)
  {
    if(stTR == 0)
    {
     analogWrite(13, 0);
     analogWrite(12, tray);
     analogWrite(11, 0);
     analogWrite(10, 0);
     stTR = 1;
     delay(sptr);
    }
    else if(stTR == 1)
    {
     analogWrite(13, 0);
     analogWrite(12, 0);
     analogWrite(11, tray);
     analogWrite(10, 0);
     stTR = 2;
     delay(sptr);
    }
    else if(stTR == 2)
    {
     analogWrite(13, 0);
     analogWrite(12, 0);
     analogWrite(11, 0);
     analogWrite(10, tray);
     stTR = 3;
     delay(sptr);
    }
    else if(stTR == 3)
    {
      analogWrite(13, tray);
      analogWrite(12, 0);
      analogWrite(11, 0);
      analogWrite(10, 0);
      stTR = 0;
      delay(sptr);
    }
  }
  Serial.print('y');
}

void rNeTr(int steps) // Negative direction - 
{
  for(int i=0;i<steps;i++)
  {
    if(stTR == 0)
    {
     analogWrite(13, 0);
     analogWrite(12, 0);
     analogWrite(11, 0);
     analogWrite(10, tray);
     stTR = 3;
     delay(sptr);
    }
    else if(stTR == 1)
    {
     analogWrite(13, tray);
     analogWrite(12, 0);
     analogWrite(11, 0);
     analogWrite(10, 0);
     stTR = 0;
     delay(sptr);
    }
    else if(stTR == 2)
    {
     analogWrite(13, 0);
     analogWrite(12, tray);
     analogWrite(11, 0);
     analogWrite(10, 0);
     stTR = 1;
     delay(sptr);
    }
    else if(stTR == 3)
    {
      analogWrite(13, 0);
      analogWrite(12, 0);
      analogWrite(11, tray);
      analogWrite(10, 0);
      stTR = 2;
      delay(sptr);
    }
  }
  Serial.print('y');
}

//////////////////////////////////////////////////////////
void rPoXg(int steps) // Positive direction - 
{
  for(int i=0;i<steps;i++)
  {
    if(stXG == 0)
    {
     analogWrite(9, 0);
     analogWrite(8, xgrid);
     analogWrite(7, 0);
     analogWrite(6, 0);
     stXG = 1;
     delay(spxg);
    }
    else if(stXG == 1)
    {
     analogWrite(9, 0);
     analogWrite(8, 0);
     analogWrite(7, xgrid);
     analogWrite(6, 0);
     stXG = 2;
     delay(spxg);
    }
    else if(stXG == 2)
    {
     analogWrite(9, 0);
     analogWrite(8, 0);
     analogWrite(7, 0);
     analogWrite(6, xgrid);
     stXG = 3;
     delay(spxg);
    }
    else if(stXG == 3)
    {
      analogWrite(9, xgrid);
      analogWrite(8, 0);
      analogWrite(7, 0);
      analogWrite(6, 0);
      stXG = 0;
      delay(spxg);
    }
  }
  Serial.print('y');
}

void rNeXg(int steps) // Negative direction - 
{
  for(int i=0;i<steps;i++)
  {
    if(stXG == 0)
    {
     analogWrite(9, 0);
     analogWrite(8, 0);
     analogWrite(7, 0);
     analogWrite(6, xgrid);
     stXG = 3;
     delay(spxg);
    }
    else if(stXG == 1)
    {
     analogWrite(9, xgrid);
     analogWrite(8, 0);
     analogWrite(7, 0);
     analogWrite(6, 0);
     stXG = 0;
     delay(spxg);
    }
    else if(stXG == 2)
    {
     analogWrite(9, 0);
     analogWrite(8, xgrid);
     analogWrite(7, 0);
     analogWrite(6, 0);
     stXG = 1;
     delay(spxg);
    }
    else if(stXG == 3)
    {
      analogWrite(9, 0);
      analogWrite(8, 0);
      analogWrite(7, xgrid);
      analogWrite(6, 0);
      stXG = 2;
      delay(spxg);
    }
  }
  Serial.print('y');
}

/////////////////////////////////////////////////

void turnOffTr()
{
  analogWrite(13, 0);
  analogWrite(12, 0);
  analogWrite(11, 0);
  analogWrite(10, 0);
}
void turnOffXg()
{
  analogWrite(9, 0);
  analogWrite(8, 0);
  analogWrite(7, 0);
  analogWrite(6, 0);
}

void drill(int del)
{
  dr.write(60);
  delay(del);
  dr.write(5);
}
void dDown()
{
  dr.write(40);
}
void dUp()
{
  dr.write(5);
}

