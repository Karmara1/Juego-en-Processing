float rocaX[];
float rocaY[];

float nubeX[];
float nubeY[];

float pajaroX[];
float pajaroY[];

float comidaX[];
float comidaY[];

int x = 0;
int y = 0;

int estado[];
int estadoComida[];

int puntaje = 0;
float distancia = 0;
int vida = 0;

int begin;
int duration;
int time;

float xpos;
float ypos;

int xBtn = 550;
int yBtn = 570;
int anBtn = 480;
int alBtn = 180;

int xBtn2 = 980;
int yBtn2 = 670;
int anBtn2 = 490;
int alBtn2 = 80;

int state = 0;
final int mainMenu = 0;
final int game=1;

boolean instruccionesB = false;
boolean juego = false;

PImage fondo, intro, instrucciones, roca, personaje, nube, pajaro, comida, perder;
int velocidad = 5;
int velocidad2 = 10;

void setup() {
  size(1920, 1080);
  frameRate(24);
  time = duration = 120;

  rocaX = new float[10];
  rocaY = new float[10];
  nubeX = new float[10];
  nubeY = new float[10];
  pajaroX = new float[10];
  pajaroY = new float[10];
  estado = new int[10];
  comidaX = new float[15];
  comidaY = new float[15];
  estadoComida = new int[15];

  fondo = loadImage("PantallaJuegoUI.png");
  intro = loadImage("Intro.png");
  instrucciones = loadImage("Instrucciones.png");
  roca = loadImage("Roca.png");
  personaje = loadImage("Personaje1.png");
  nube = loadImage("Nube1.png");
  pajaro = loadImage("Ave.png");
  comida = loadImage("Comida2.png");
  perder = loadImage("perder.png");

  for (int i=0; i<10; i++) {
    rocaX[i] = random(1800); 
    rocaY[i] = 870;
    nubeX[i] = random(1800);
    nubeY[i] = random(100, 600);
    pajaroX[i] = random(1800);
    pajaroY[i] = random(100, 600);

    estado[i] =1;
  }

  for (int i=0; i<15; i++) {
    comidaX[i] = random(1920); 
    comidaY[i] = random(700);
    estadoComida[i] = 1;
  }
}

void draw() {
  Menu();
}

void Menu() {
  background(intro);

  if (mousePressed == true) {
    if (mouseX >xBtn && mouseX <xBtn + anBtn && mouseY >yBtn && mouseY <yBtn +alBtn) {
      instruccionesB = true;
    }
  }

  if (instruccionesB == true) {
    Tutorial();
  }
}


void Tutorial() {
  background(instrucciones);
  switch(key) {
  case 'j':
    Game();
    juego = true;
    break;
  }
}

void Game() {
  background(fondo); 

  image(personaje, x, y, 100, 110);
  y += velocidad;
  x += velocidad2;
  interactionMouse();

  if (juego == true) {
    for (int i=0; i<10; i++) {
      rocaX[i] = rocaX[i] + random(5, 10);
      nubeX[i] = nubeX[i] + random(-3, -8);
      pajaroX[i] = pajaroX[i] + random(2, 10);

      if (rocaX[i] >= 1920 || rocaX[i] <= 0) {
        rocaX[i] = 0;
      }
      
      if (nubeX[i] >= 1920 || nubeX[i] <= 0){
        nubeX[i] = 1920;
      }
      
      if (pajaroX[i] >= 1920 || pajaroX[i] <= 0){
        pajaroX[i] = 0;
      }
    }
    
    for (int i=0; i<15; i++){
      comidaY[i] = comidaY[i] + random(2, 10);
      
      if (comidaY[i] >= 1080 || comidaX[i] <= 0){
        comidaY[i] = 0;
      }
    }

    for (int i=0; i<10; i++){
      if (estado[i] == 1){
        image(roca, rocaX[i], rocaY[i], 50, 80);
        image(nube, nubeX[i], nubeY[i], 110, 120);
        image(pajaro, pajaroX[i], pajaroY[i], 60, 90);
      }
    }
    
    for (int i=0; i<15; i++){
      if (estadoComida[i] == 1) {
        image(comida, comidaX[i], comidaY[i], 50, 80);
      }
    }
  }
  
  for (int i=0; i<15; i++){
    if (mousePressed == true) {
      distancia = dist(mouseX, mouseY, comidaX[i], comidaY[i]);

      if (distancia <45){
        estadoComida[i]=0;
      }
    }
  }

  fill(#ffffff);
  textSize(45);
  text(puntaje, 1100, 160);
  text(time, 1600, 160);
  puntaje=0;
  
  for (int i =0; i<15; i++){
    if (estadoComida[i] == 0){
      puntaje ++;
    }
    
    if (puntaje == 15) {
      textSize(20);
      background(intro);
      text("¡Ganaste!", 430, 630 );
      if (mousePressed == true){
        if (mouseX >xBtn && mouseX <xBtn + anBtn && mouseY >yBtn && mouseY <yBtn + alBtn){
          setup();
        }
      }
    }
  }

  for (int i =0; i<10; i++){

    if (time > 0)  time = duration - (millis() - begin)/1000;
    if (time <= 0 && puntaje != 15){
      background(perder);  

      if (mousePressed == true) {
        if (mouseX >xBtn2 && mouseX <xBtn2 + anBtn2 && mouseY >yBtn2 && mouseY <yBtn2 + alBtn2) {
          setup();
        }
      }
    }
  }


  for (int i=0; i<10; i++){
    if (mousePressed == true) {
      distancia = dist(mouseX, mouseY, nubeX[i], nubeY[i]);
      distancia = dist(mouseX, mouseY, rocaX[i], rocaY[i]);
      distancia = dist(mouseX, mouseY, pajaroX[i], pajaroY[i]);

      if (distancia <50)
      {
        estado[i]=0;
      }
    }
  }

  for (int i =0; i<10; i++) {
    if (estado[i] == 0){
      background(perder);

      if (mousePressed == true) {
        if (mouseX >xBtn2 && mouseX <xBtn2 + anBtn2 && mouseY >yBtn2 && mouseY <yBtn2 + alBtn2){
          setup();
        }
      }
    }
  }
}


void interactionMouse() {
  x = mouseX;
  y = mouseY;
}
