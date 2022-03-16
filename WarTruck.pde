/**
* Classe WarTruck 
* Classe derivada de la classe Vehicle
*/
public class WarTruck extends Vehicle {
  private final float vMin = 0.3;
  private final float vMax = 0.7;
  /**
  * Constructor de la subClasse WarTruck derivada de la superclasse Vehicle
  */
  public WarTruck(PVector v) {
    super(v);
    img       = loadImage("media/img/warTruck.png"); // Carreguem la imatge del WarTruck
    velocity  = new PVector(random(vMin,vMax),0);    // Establim la velocitat
    colRadius = 64;
  }
}
