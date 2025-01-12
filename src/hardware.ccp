unsigned long ownDelay = 0; // millis() is a clock from the start of when it was running to the end. unsigned long creates a time stamp of millis, so that the user can program things at different times

class lightCreate{
public:
    int delayTime;
    int pin;

    lightCreate(int sPin) : delayTime(800), pin(sPin) {}
    
    void lightSwitch(){
        digitalWrite(pin, HIGH);
        delay(delayTime);
        digitalWrite(pin, LOW);
        delay(delayTime);
    };
};

class buttonCreate{
  public:
  int pin;

  buttonCreate(int sPin){
    pin = sPin;
    pinMode(pin, INPUT);
  };

  void buttonInput(){
  };
};

void setup(){
    Serial.begin(9600); // 9600 bits per second passed to arduino
    Serial.println("Setup complete.");
};
lightCreate oneLight(13); // red
lightCreate zeroLight(12); // yellow

buttonCreate oneButton(2);
buttonCreate zeroButton(3);

String inputBit = "";

void loop(){ //check out why its not working rn
  byte buttonStateOne = digitalRead(oneButton.pin);
  byte buttonStateZero = digitalRead(zeroButton.pin);
  delay(200);

  if (buttonStateZero == LOW){
    inputBit = inputBit + "0";
    Serial.println(inputBit);
    delay(200);
    ownDelay = millis();
  };

  if (buttonStateOne == LOW){
    inputBit = inputBit + "1";
    Serial.println(inputBit);
    delay(200);
    ownDelay = millis(); // set our timer from the point the button is pressed. Therefore, the last button pressed millis() is the start of the 5 second timer
  };

  if ((millis() - ownDelay) >= 5000 && inputBit.length() > 0) {
    Serial.println("Initiating light sequence");
    for (int i = 0; i <= inputBit.length(); i++){
        if (inputBit[i] == '0'){
            zeroLight.lightSwitch();
        } else if (inputBit[i] == '1'){
            oneLight.lightSwitch();
        };
    }
    inputBit = "";
  };
};
/*
Need to determine how long the button has been held. but for now we'll have two buttons, one for 1 and another for zero 
*/
