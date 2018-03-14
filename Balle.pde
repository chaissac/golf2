class Balle {
  PVector position, vitesse, acceleration;
  int rayon = 7;
  int precision = 12;
  Balle(float x, float y) {
    position = new PVector(x, y);
    vitesse = new PVector(0, 0); 
    acceleration = new PVector(0, 0);
  }
  void trace() {
    noStroke();
    fill(0, 100);
    ellipse((int)position.x+3, (int)position.y+3, rayon*2, rayon*2);
    stroke(0);
    strokeWeight(1);    
    fill(255);
    ellipse((int)position.x, (int)position.y, rayon*2, rayon*2);
  }
  int bouge() {
    color c;
    float step = max(1,round(vitesse.mag()),round(acceleration.mag()));
    PVector v = PVector.mult(vitesse, 1/step);
    PVector a = PVector.mult(acceleration, 1/step);
    for (int i=0; i<step; i++) {
      v.add(a);
      position.add(v);
      fg.set(int(position.x), int(position.y), #FF0000);
      gererRebond();
    }
    c =lireCouleur(new PVector(0, 0));
    vitesse.add(acceleration);
    vitesse.mult(FROTTEMENTS);    
    acceleration.mult(0);
    if      (c == #FF0000) force(new PVector(-0.1, 0)) ; 
    else if (c == #0000FF) force(new PVector( 0.1, 0)) ;
    else if (c == #FFFF00) {
      vitesse.mult(pow(FROTTEMENTS,6));
    }

    PVector toTrou=PVector.sub(position, trou);
    if (toTrou.mag()<rayon*2.5) {
      force(PVector.mult(toTrou, -.06));
    }
    if (toTrou.mag()<.1) {
      acceleration.mult(0);
      vitesse.mult(0);
      position=trou.copy();
      return 2;
    }
    if (vitesse.magSq()<0.01 && acceleration.magSq()<0.01) { vitesse.mult(0); acceleration.mult(0); }
    return (vitesse.magSq()!=0 || acceleration.magSq()!=0)?1:0 ;
  }
  void force(PVector f) {
    acceleration.add(f);
  } 
  void gererRebond() {
    PVector normale = new PVector();
    for (int i=-precision; i<=precision; i++) {
      normale = PVector.fromAngle(i*HALF_PI/(precision)+vitesse.heading());
      if ( lireCouleur(normale)==#000000 ) {
        vitesse = PVector.sub(vitesse, normale.mult(2*PVector.dot(vitesse, normale))).mult(REBOND);
      }
    }
  }
  color lireCouleur(PVector normale) {
    PVector point = PVector.mult(normale, rayon).add(position) ; 
    return get((int)point.x, (int)point.y);
  }
}