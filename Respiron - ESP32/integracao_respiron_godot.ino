#include <WiFi.h>

#define ldr 34
int valorldr = 0;
#define btn 22


const char *ssid = "MINHA INTERNET";
const char *pw = "MinhaSenha";

WiFiServer server(80);

int flag_btn = 0;
String txt = "";

int deBounce(int estado, int pino) {
  int estadoAtual = digitalRead(pino);

  if (estado != estadoAtual) {
    delay(5);
    estadoAtual = digitalRead(pino);
  }
  return estadoAtual;
}

void setup() {
  pinMode(btn, INPUT_PULLUP);
  Serial.begin(115200);
  delay(1000);
  WiFi.begin(ssid, pw);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }

  Serial.println("Conectado");
  Serial.println(WiFi.localIP());
  server.begin();

}

void loop() {

  WiFiClient client = server.available();
  if (client) {
    while (client.connected()) {
     
  
      if (deBounce(flag_btn, btn) == LOW) { //BOTAO PRESSIONADO
        if (flag_btn == 0) {
          client.print("Pulou\n");
          Serial.print("Pulou\n");
        }
        //Serial.write("PULOU \n");
        flag_btn = 1;
      }

      if (flag_btn == 1 && deBounce(flag_btn, btn) == HIGH) { //BOTAO SOLTO
        //Serial.write("SOLTOU \n");
        //client.print("Soltou\n");
        flag_btn = 0;
      }
      
      int valorcru = analogRead(ldr);
      valorldr = map(valorcru, 0, 4095, 100, 0);

      if (valorldr <= 55) {//VALOR DO LDR PARA DAR SINAL DE RESPIRAR
         Serial.print("Respirou\n");
         client.print("Respirou\n");
         delay(50);
         Serial.print("Valor ldr: ");
         Serial.println(valorldr);
      } else {
         //Serial.print("Valor ldr: ");
         //Serial.println(valorldr);
      }
    }
  }

}
