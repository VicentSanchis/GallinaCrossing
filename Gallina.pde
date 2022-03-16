/**
* Classe Gallina personatge principal del nostre joc
*/
public class Gallina {
  private final int IDLE    = 0; // La gallina està parada esperant 
  private final int WALKING = 1; // La gallina està caminant
  private final int DYING   = 2; // La gallina està morint
  private final int DEAD    = 3; // La gallina ha mort
  private final int vel     = 2; // Velocitat a la que es mourà la nostra gallina
 
  private boolean down;       // true si la gallina està anant cap avall
  private boolean left;       // true si la gallina està anant cap a la l'esquerra
  private boolean right;      // true si la gallina està anant cap a la dreta
  private boolean enabled;    // Si no està activa la gallina, les col·lisions no es tenen en compte
  private PVector location;   // Posició en la que es troba la gallina
  private PVector origin;     // Posició inicial a la que tornarà quan la maten
  private int     estat;      // Control d'estat de l'animalet. 0: normal, 1: morint;
  private int     dir;        // -1 dreta, 1 esquerra
  private int     colRadius;  // Radi de col·lisió de la Gallina
  
  // Animacions del nostre personatge
  private Animation deathAnimation;
  private Animation idleAnimation;
  private Animation walkAnimation;
  
  /**
  * Constructor de la gallina
  * @param v objecte PVector que determina la posició 2D del personatge
  */
  public Gallina (PVector v) {
    dir       = 1;
    estat     = IDLE;
    enabled   = true;
    location  = v;
    origin    = v.copy();
    down      = false;
    left      = false;
    right     = false;
    colRadius = 35;
    
    // Control de les animacions
    idleAnimation  = new Animation("gallinaIdle", 2, 20, true);
    walkAnimation  = new Animation("gallinaWalk", 4, 20, true);
    deathAnimation = new Animation("gallinaKill", 8, 7, false);
  }
  /**
  * Metode display() mostra la gallina a la posició que li indica el vector location, mirant cap a la direcció dir
  */ //<>//
  public void display() {
    
    switch (estat) {
      case IDLE:
        idleAnimation.display(location, dir);
      break;
      
      case WALKING:
        walkAnimation.display(location, dir);
      break;
      
      case DYING:
        deathAnimation.display(location, dir); //<>//
        if (deathAnimation.hasFinished())
          estat = DEAD;
      break;
      
      case DEAD:        
        sendBack();
        deathAnimation = new Animation("gallinaKill", 8, 7, false);
      break;
    }
  }
  /**
  * Actualitza la posició de la gallina segons estiga movent-se //<>//
  */
  public void update() {
    if (down)
      mouAvall();
      
    else if (left)
      mouEsquerra();
      
    else if (right) 
      mouDreta();
  }
   /** 
  * Aquest mètode s'encarrega de comprovar si la gallina ha col·lisionat amb el Vehicle v que es passa per paràmetre
  * @param v Vehicle amb el qual hem de comprovar si col·lisionem
  * @return true si la col·lisió està produint-se, false en cas contrari.
  */
  public boolean colisionaAmb (Vehicle v) {
    if ( !v.isEnabled() || !enabled )
      return false;
     
    if (location.dist(v.getLocation()) <= colRadius)
      return true;
      
    else
      return false; 
  }
  public void mor() {
    estat = DYING;
    down  = false;  // NO SE SI AIXÓ HA D'ESTAR AHÍ
    left  = false;
    right = false;
  }
  public void sendBack() {
    enabled = true;
    estat = IDLE;
    location = origin.copy();
  }
  public void setEnabled(boolean b) {
    enabled = b;
  }
  public boolean isEnabled() {
    return enabled;
  }
  /**
  * Estableix el moviment de la gallina per evitar el latency del keyPressed
  * @param k (int) code de la tecla que estem avaluant
  * @param b (boolean) valor que volem establir
  */
  public void setMovement(int k, boolean b) {
    if (!enabled)
      return;
      
    switch (k) {
      case DOWN:
        down = b;
        estat = WALKING; 
        break;
        
      case LEFT:
        left = b;
        estat = WALKING;
        break;
        
      case RIGHT:
        right = b;
        estat = WALKING;
        break;
    }
  }
  /**
  * Desplaça la posició de la gallina cap avall
  */
  private void mouAvall() {
    location.y += vel;
  }
  /**
  * Desplaça la posició de la gallina cap a la dreta
  */
  private void mouDreta() {
    location.x += vel;
    dir = -1;
  }
  /**
  * Desplaça la posició de la gallina cap a l'esquerra
  */
  private void mouEsquerra() {
    location.x -= vel;
    dir = 1;
  }
  
  private PVector getLocation() {
    return location;
  }
}
