class Schleuder {
  FBox slingshot;
  FDistanceJoint band;
  Vogel bird;
  int species = 1;
  float bandSize = 0;

  Schleuder() {                        //Erzeugt die Schleuder
    slingshot = new FBox (5, 20);
    slingshot.setPosition(120, 290);
    slingshot.setStatic(true);
    slingshot.setFill(139, 69, 19);
    slingshot.setGrabbable(false);
    slingshot.setSensor(true);
    world.add(slingshot);

    species = int(random(0, 4));      //Generiert einen zufälligen Vogel, der in die Schleuder gesetzt wird
    if (species == 0) {
      bird = new Red();
    } else if (species == 1) {
      bird = new Chuck();
    } else if (species == 2) {
      bird = new Blue(); 
    } else if (species == 3) {
      bird = new Bubbles(); 
    }
    bird.setSensor(true);
    bird.setPosition(120, 280);
    bird.setForce(0, 0);
    world.add(bird);

    band = new FDistanceJoint(slingshot, bird);    //Erzeugt einen DistanceJoint zwischen Schleuder und Vogel, der den Vogel zurückzieht um ihn zu schießen
    band.setLength(bandSize);
    band.setStrokeColor(#8b4513);
    band.setFillColor(#8b4513);
    band.setAnchor1(0, -10);
    if (bird instanceof Chuck) {      //Chuck soll schneller fliegen als die anderen Vögel
      band.setFrequency(4);
    } else {
      band.setFrequency(2);
    }
    world.add(band);
  }

  void checkJoint() {                            //Wenn der Vogel wieder zurück über die Schleuder ist, soll der DistanceJoint entfernt werden, damit der Vogel wegfliegt und nicht hängen bleibt
    if (bird.getX() > slingshot.getX()+3) {
      band.removeFromWorld();
      bird.setGrabbable(false);
      bird.setSensor(false);
      
      if (bird instanceof Blue) {        //Bei den Blauen wird an dieser STelle auch geteilt
        bird.split();
      }
    }
  }

  void checkRespawn() {                                //Wenn der Vogel aus dem Bildschirm fliegt, soll ein neuer Vogel in die Shcleuder gesetzt werden
    if (bird.getX() > width ||bird.getY() < 0 || bird.getY() > height) {

     bird.remove();            //Es wird wieder ein zufälliger Vogel erzeugt und in die Schleuder gesetzt
      band.removeFromWorld();
      if (species == 0) {
        bird = new Red();
      } else if (species == 1) {
        bird = new Chuck();
      } else if (species == 2) {
        bird = new Blue();
      } else if (species == 3) {
        bird = new Bubbles(); 
      }

      bird.setSensor(true);
      bird.setGrabbable(true);
      bird.setPosition(120, 280);
      species = int(random(0, 4));

      world.add(bird);

      band = new FDistanceJoint(slingshot, bird);
      band.setLength(bandSize);
      band.setStrokeColor(#8b4513);
      band.setFillColor(#8b4513);
      band.setAnchor1(0, -10);
      band.setFrequency(2);
      if (bird instanceof Chuck) {
        band.setFrequency(4);
      }
      world.add(band);
    }
  }
}
