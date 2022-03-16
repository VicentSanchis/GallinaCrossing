// Constants de l'aplicació
final int WIDTH        = 672;
final int HEIGHT       = 522;
final int CARRILS      = 8;
final int MAX_VEHICLES = 5;
final int FRAME_DELAY  = 500;
final int CARRIL_DIST  = 53;

PImage bg;
PFont  font;

// Variables globals
boolean countDownActive;
int countDownNumber;
int countDownAlpha;
Score                 marcador;
Gallina               gallina;           // Personatge principal del joc
int                   latestFrameCount;  // Variable per controlar l'eixida de cotxe
int                   nextVehicleColumn; // Següent columna de vehicles a mostrar a l'escenari
ArrayList<Vehicle> [] alVehicles;        // Per tal de controlar els vehicles que estaran circulant pel nostre escenari crearem 8 ArrayLists un per cada carril

/**
* Mètode de configuració principal de la nostra apliació.
*/
void setup () {
  size(672,522);
  bg = loadImage("media/img/fons1.png");
  smooth ();
  carregaVehicles ();
  gallina = new Gallina(new PVector(width/2,25));
  gallina.setEnabled(true); 
  nextVehicleColumn = 1;  // La columna 0 estarà activa d'inici  
  latestFrameCount  = 0;
  marcador = new Score();
  countDownNumber = 3;
  countDownAlpha  = 255;
  countDownActive = true;
}
/**
* Bucle de joc
*/
void draw () {
  clear();
  background(bg);
  
  // Dibuixem el marcador
  marcador.display();
  
  if (countDownActive)
    showCountDown();
    
      
    // Dibuixem i actualitzem el nostre personatge
    if (!countDownActive) {
      gallina.display();
      gallina.update();
    
      if (gallina.getLocation().y >= height-40) {
        gallina.sendBack();
        marcador.increaseWins();
      }
    }
  
    // Activem (si escau), dibuixem i comprovem colisionss dels vehicles
    activaVehicles();
    mostraVehicles();
    comprovaColisions();
}
void showCountDown() {
  pushMatrix();
  translate(height/2,width/2);
  //textAlign(CENTER);
  font = createFont("media/fnt/I-pixel-u.ttf",300);
  textFont(font);
  fill(255,countDownAlpha);
  text(countDownNumber,0,0);
  countDownAlpha -= 10;
  if (countDownAlpha <= 20) {
    countDownNumber --;
    countDownAlpha = 255;
  }
  if ( countDownNumber == 0)
    countDownActive = false;
  popMatrix();
}
/**
* Mètode que emplena el nostre array de Vehicles que es mostraran i mouran per pantalla i la gallina haurà de esquivar
*/
void carregaVehicles ( ) {
  alVehicles = new ArrayList[CARRILS];
  
  // Per cada carril  hem d'afegir un nombre de vehicles  
  for (int i=0; i < CARRILS; i ++) {
    alVehicles[i] = new ArrayList<Vehicle>();
    
    for (int j = 0; j < MAX_VEHICLES; j ++) {
      int tipusVehicle = (int)random(1,5);    // El tipus de cotxe que afegirem serà de forma aleatòria.
      switch (tipusVehicle) {        
        case 1:
          Cotxe cot = new Cotxe(new PVector(10,i*53+75));
          cot.setId(cot.getTag()+i+"-"+j);
          if (j==0)
            cot.setEnabled();
            
          alVehicles[i].add(cot);
        break;
        
        case 2:
          Camio cam = new Camio(new PVector(10,i*53+75));
          cam.setId(cam.getTag()+i+"-"+j);
          if (j==0)
            cam.setEnabled();
          alVehicles[i].add(cam);
        break;
        
        case 3:
          MadMax mad = new MadMax(new PVector(10,i*53+75));
          mad.setId(mad.getTag()+i+"-"+j);
          if (j==0)
            mad.setEnabled();
          alVehicles[i].add(mad);
        break;
        
        case 4:
          WarTruck war = new WarTruck(new PVector(10,i*53+75));
          war.setId(war.getTag()+i+"-"+j);
          if (j==0)
            war.setEnabled();
          alVehicles[i].add(war);
        break;
      }
    }
  }
}
/**
* Mètode que s'encarrega d'activar els vehicles que s'han carregat a l'inici en cadascun dels carrils
* Per tal de controlar els intervals utilitzarem la variable del sistema frameCount
*/
void activaVehicles () {
  // Esperarem FRAME_DELAY frames entre vehicle i vehicle
  if (frameCount - latestFrameCount > FRAME_DELAY) {
    latestFrameCount = frameCount;
    
    for(int i=0; i < CARRILS; i ++) 
      alVehicles[i].get(nextVehicleColumn).setEnabled();
      
   nextVehicleColumn ++;
   if(nextVehicleColumn >= MAX_VEHICLES)
     nextVehicleColumn = 0;
  }
}
/**
* Comprova si algun cotxe xoca amb un altre cotxe o si la gallina es atropellada
*/
void comprovaColisions() {
  boolean bCalComprovar;
  Vehicle vehicle, vehicleDavant;
  // Primer hem de comprovar si els vehicles entre els vehicles
  for(int i=0; i < CARRILS; i++) {
    for(int j=0; j < MAX_VEHICLES; j++) {
      bCalComprovar = true;
      vehicle = alVehicles[i].get(j);   // Cotxe que comprovarem si colisiona amb algú
      
      // L'únic vehicle amb el que pot colisionar és el què ha eixit abans
      int indexDavant = j-1;
      if ( indexDavant == -1)
        indexDavant = alVehicles[i].size()-1;
      
      // Aquest cas nomḿes es donaria quan al carril nomḿes hi ha un vehicle
      if ( indexDavant == j)
        bCalComprovar = false;
        
      vehicleDavant = alVehicles[i].get(indexDavant);
      
      if (!vehicleDavant.isEnabled() )
        bCalComprovar = false;
       
      // En cas que el suposat vehicle que està davant realment estiga darrere
      if ( vehicle.getLocation().x > vehicleDavant.getLocation().x)
        bCalComprovar = false;
      
      // Comprovem si els dos vehicles xoquen
      if (bCalComprovar && vehicle.colisionaAmb(vehicleDavant)) {
        vehicleDavant.getLocation().x += 1;
        vehicle.getLocation().x -= 1;
        
        PVector aux = vehicleDavant.getVelocity().copy();
        vehicleDavant.setVelocity(vehicle.getVelocity().copy());
        vehicle.setVelocity(aux);
      }
      
      if (gallina.colisionaAmb(vehicle)) {
        gallina.mor();
        gallina.setEnabled(false);
        vehicle.parar();
        marcador.increaseLost();
      }
    }
  }
}
/**
* Mètode que mostra tots els vehicles del nostre array de vehicles que estan actius.
* Després de mostrar-los els actualitza.
*/
void mostraVehicles() {
  for(int i=0; i < CARRILS; i++) {
    for(int j=0; j < alVehicles[i].size(); j ++) {
      Vehicle v = alVehicles[i].get(j);
      if (v.isEnabled()) {
        v.display();
        v.update();
      }
    }
  }   
}
/**
* Control de teclat 
*/
void keyPressed() {
  gallina.setMovement(keyCode,true);
}
void keyReleased() {
  gallina.setMovement(keyCode,false);
}
