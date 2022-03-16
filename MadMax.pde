/**
* Classe MadMax
* Classe derivada de la classe Vehicle

*/
public class MadMax extends Vehicle {
  private final float vMin = 0.3;
  private final float vMax = 0.8;
  /**
  * Constructor de la subclasse MadMax derivada de la superclasse Vehicle
  */
  public MadMax(PVector v) {
    super(v);
    img       = loadImage("media/img/madMax.png"); // Carreguem la imatge del MadMax
    velocity  = new PVector(random(vMin,vMax),0);  // Establim la velocitat
    colRadius = 54;
  }
}
