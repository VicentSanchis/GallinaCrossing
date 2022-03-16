/**
* Classe Animation: s'utilitza per simular animacions
* @author Vicent Sanchis
* @since  14/3/2022
*/
public class Animation {
  private PImage [] images;         // Array amb les imatges que simularan l'animació      
  private int       totalImages;    // Total d'imatges (o frames) que formen l'animació
  private int       currentFrame;   // Frame actual que està mostrant-se de l'animació 
  private int       frameDelay;     // Retras entre canvis de frames. A major delay més lenta és l'animació
  private int       currentDelay;   // Total del delay que s'ha complert ja abans de canviar de frame 
  private boolean   loop;           // Indica si l'animació és un bucle infinit (true) o si només es mostra una vegada i para (false)
  private boolean   finished;       // Indica si l'animació ha acabat
  /**
  * Constructor de la classe Animation, se li passa el prefix de les imatges (frames) que formaran l'animació.
  * Amb aquest constructor el nom de les imatges haurien de tindre el següent format prefix0000.png (0000, 0001, 0002...)
  * @param imgPrefix prefix de cadascuna de les imatges que formaran l'animació
  * @param total nombre total de frames que formaran l'animació
  * @param frameWait nombre de frames que ha d'esperar entre canvi i canvi a l'animació.
  * @param bLoop indica si és una animació que s'executa en bucle infinit o no.
  */
  public Animation (String imgPrefix, int total, int frameWait, boolean bLoop) {
    totalImages  = total;
    images       = new PImage [totalImages];
    currentDelay = 0;
    frameDelay   = frameWait;
    loop         = bLoop;
    finished     = false;
    
    for (int i=0; i < totalImages; i ++ ) {
      String strFileName = imgPrefix + nf(i,4) + ".png";
      images[i] = loadImage("media/img/" + strFileName);
    }
  }
  /**
  * Mostra la imatge o frame actual a la posició 'loc' i en la direcció 'dir'
  * @param loc PVector que ens indica les coordenades on s'ha de dibuixar la imatge
  * @param dir en quina direcció horitzontal (dreta o esquerra) s'ha de mostrar la imatge
  */
  public void display(PVector loc, int dir) {
    // Si l'animació és loop quan arribem a l'últim frame haurem de començar de zero
    if (loop) {
      if (currentDelay == 0) 
        currentFrame = (currentFrame+1)%totalImages;
    
      currentDelay = (currentDelay + 1)%frameDelay;
    }
    // Si pel contrari és una animació que no es repeteix infinitament, quan acabe ho hem d'indicar 
    else {
      if(currentDelay == 0) {
        currentFrame ++;
        if (currentFrame >= totalImages) {
          currentFrame = totalImages - 1;
          finished = true;
        }
      }
      currentDelay = (currentDelay+1)%frameDelay;
    }
    pushMatrix();
    imageMode(CENTER);
    scale(dir,1);
    image(images[currentFrame],dir*loc.x,loc.y);
    popMatrix();
  }
  /**
  * Mètode que ens diu si l'animació (que no és loop) ha acabat
  */  
  public boolean hasFinished() {
    if (loop) 
      return false;
      
    return finished;
  }
  /** 
  * Mètode que reinicia les animacions que no són bucles
  */
  public void reset () {
    finished = false;
  }
}
