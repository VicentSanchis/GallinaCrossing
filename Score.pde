public class Score {
  private PVector location;
  private PFont font;
  private int iWin;
  private int iLost;
  public Score() {
    iWin = 0;
    iLost = 0;
    font = createFont("media/fnt/I-pixel-u.ttf",20);
    textFont(font);
  }
  public void display() {
    location = new PVector(width/2-110,height-40);
    pushMatrix();
    textAlign(LEFT);
    textSize(20);
    translate(location.x, location.y);
    stroke(0,0,0);
    strokeWeight(3);
    
    fill(255,255,255,150);
    rect(0,0,210,30);
    
    fill(40);
    text("WIN: " + iWin + " - DEAD: " + iLost, 12,21);
    popMatrix();
  }
  public void increaseWins() {
    iWin ++;
  }
  public void increaseLost() {
    iLost ++;
  }
}
