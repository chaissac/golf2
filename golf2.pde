PImage bg, fg, tp;
float FROTTEMENTS = .993 ; 
float REBOND = 0.94 ;
Balle balle;
PVector club, trou ;
int coup;
PGraphics trace ; 
void setup() {
  size(1024, 768);    
  smooth();
  frameRate(60);
  textAlign(CENTER, CENTER);
  init();
}
void init() {
  bg = loadImage ("golf_bg_1.png");
  fg = loadImage ("golf_fg_1.png");
  tp = loadImage ("golf_tp_1.png");
  trou = new PVector(538, 352);
  //balle = new Balle(500, 330); // TEST près du trou
  //balle = new Balle(900, 200); // TEST près du sable
  balle = new Balle(140, 670); // au départ
  coup = 0;
}
void draw()
{
  background(bg);
  //println(frameRate);
  int bouge = balle.bouge();
  background(fg);
  if (bouge==0) {
    stroke(#B09040);
    strokeWeight(3);
    club = new PVector(balle.position.x-mouseX, balle.position.y-mouseY);
    club.limit(80);
    line(balle.position.x, balle.position.y, balle.position.x-club.x, balle.position.y-club.y);
    fill(#B09040);
    ellipse(balle.position.x-club.x, balle.position.y-club.y, 6, 6);
    if (mouseButton==LEFT) {
      coup++;
      balle.force(club.mult(.1));
    }
  }
  balle.trace();
  image(tp, 0, 0);
  textSize(24);
  fill(200);
  text("Coups : "+coup, 700, 730);
  if (bouge==2) {
    textSize(128);
    fill(255, 180);
    text("GAGNÉ !", width/2, height/2);
  }
  if (mouseButton==RIGHT) init();
}