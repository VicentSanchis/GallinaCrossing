/**
* Classe Cotxe
* Classe derivada de la classe Vehicle
*/
public class Cotxe extends Vehicle {
  private final float vMin = 0.4;
  private final float vMax = 0.8;
  /**
  * Constructor de la subclasee Cotxe derivada de la superclasse Vehicle
  */
  public Cotxe (PVector v) {
    super(v);
    img       = loadImage("media/img/car.png");   // Carreguem la imatge per al cotxe
    velocity  = new PVector(random(vMin,vMax),0); // Establim la velocitat
    colRadius = 45;
  }
}
