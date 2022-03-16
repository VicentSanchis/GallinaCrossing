/**
* Classe general (superclasse) Vehicle de la qual derivaran totes les variants de vehicles
* que hi han disponibles al nostre joc.
* @author Vicent Sanchis
* @since  7/3/22
*/
public class Vehicle {
  protected String  id;        // Identificador del vehicle
  protected boolean enabled;   // Determina si el vehicle està actiu per tal que es mostre per pantalla
  protected PVector location;  // Vector de posició del vehicle
  protected PVector velocity;  // Vector de velocitat del vehicle
  protected PImage  img;       // Imatge que es mostrarà del vehicle
  protected String  tag;       // Etiqueta que indica quin tipus de vehicle és
  protected int     totalLaps; // Cada vegada que el vehicle torna a apareixer al joc.
  protected int     colRadius; // Radi del colisionador
  /**
  * Constructor de la classe Vehicle
  */
  public Vehicle (PVector v) {
    colRadius = 50;
    tag       = "Vehicle";
    location  = v;
    velocity  = new PVector(0,0);
    enabled   = false;  // Inicialment el vehicle no estarà actiu per tant no es mostrar
    totalLaps = 0;
  }
  /**
  * Mostra el vehicle a la pantalla
  */
  public void display() {
    imageMode(CENTER);
    image(img,location.x,location.y);
    //stroke(255,0,0);
    //noFill();
    //ellipse(location.x,location.y,colRadius,colRadius);
  }
  /**
  * Actualitza la posició del vehicle en base al vector de velocitat
  */
  public void update() {
    location.add(velocity);
    
    // NO TINC CLAR QUE EL TAULER HAJA DE SABER ELS LÍMITS DEL TAULER DE JOC
    if (location.x >= 672) {
      location.x = 10;
      enabled = false;
      totalLaps ++;
    }
  }
  /** 
  * Aquest mètode s'encarrega de comprovar si 'this' ha col·lisionat amb el Vehicle v que es passa per paràmetre
  * @param v Vehicle amb el qual hem de comprovar si col·lisionem
  * @return true si la col·lisió està produint-se, false en cas contrari.
  */
  public boolean colisionaAmb (Vehicle v) {
    if ( !v.isEnabled() || !this.enabled)
      return false;
    
    if (location.dist(v.getLocation()) <= colRadius)
      return true;
      
    else
      return false; 
  }
  public void parar() {
    velocity.x = 0;
  }
  /**
  * Mètode per establir l'Id de l'objecte Vehicle
  * @param strId String que ens indicarà l'identificador del vehicle
  */
  public void setId(String strId) {
    id = strId;
  }
  /**
  * Mètode per obtindre l'identificador de l'objecte Vehicle
  * @return l'identificador del Vehicle en forma d'String
  */
  public String getId() {
    return id;
  }
  /**
  * Mètode per consultar el vector de velocitat del Vehicle
  * @return PVector velocity que ens indica la velocitat actual del vehicle
  */
  public PVector getVelocity() {
    return velocity;
  }
  /**
  * Mètode per accedir al PVector de velocitat del Vehicle
  * @param v PVector que ens indicarà la velocitat a la que es mourà el vehicle
  */
  public void setVelocity(PVector v) {
    velocity = v;
  }
  /**
  * Mètode per obtenir el vector de posició de l'objecte Vehicle
  * @return location PVector amb la localització de l'objecte.
  */
  public PVector getLocation () {
    return location;
  }
  /**
  * Mètode que ens indica quina és l'etiqueta del vehicle
  * @return tag etiqueta del vehicle en forma d'String
  */
  public String getTag() {
    return tag;
  }
  /**
  * Mètode per establir l'etiqueta del vehicle
  * @param strTag String amb l'etiqueta que li volem posar al Vehicle
  */
  public void setTag(String strTag) {
    tag = strTag;
  }
  /**
  * Mètode que ens diu si el vehicle està actiu o no
  " @return true si està actiu false en cas contrari
  */
  public boolean isEnabled() {
    return enabled;
  }
  /**
  * Estableix el vehicle com a actiu (enabled=true)
  */
  public void setEnabled() {
    enabled = true;
  }
  /**
  * Deshabilita el vehicle
  */
  public void disable() {
    enabled = false;
  }
}
