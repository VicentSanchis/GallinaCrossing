/**
* Classe Camio
* Classe derivada de la classe Vehicle
* @author Vicent Sanchis
*/
public class Camio extends Vehicle {
  private final float vMin = 0.4;
  private final float vMax = 0.7;
  
  /**
  * Constructor de la subclasee Camió derivada de la superclasse Vehicle
  */
  public Camio(PVector v) {
    super(v);
    img       = loadImage("media/img/truck.png");  // Carreguem la imatge del Camió
    velocity  = new PVector(random(vMin,vMax),0);  // Establim la velocitat de la subclasse
    colRadius = 42; 
  }
}
