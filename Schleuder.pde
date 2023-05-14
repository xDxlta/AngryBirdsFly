class Schleuder {
  FBox slingshot;
  FDistanceJoint band;
  Vogel bird;
  int species = 1;
  float bandSize = 0;

  Schleuder() {
    slingshot = new FBox (5, 20);
    slingshot.setPosition(120, 290);
    slingshot.setStatic(true);
    slingshot.setFill(139, 69, 19);
    slingshot.setGrabbable(false);
    slingshot.setSensor(true);
    world.add(slingshot);

    species = int(random(0, 4));
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

    band = new FDistanceJoint(slingshot, bird);
    band.setLength(bandSize);
    band.setStrokeColor(#8b4513);
    band.setFillColor(#8b4513);
    band.setAnchor1(0, -10);
    if (bird instanceof Chuck) {
      band.setFrequency(4);
    } else {
      band.setFrequency(2);
    }
    world.add(band);
  }

  void checkJoint() {
    if (bird.getX() > slingshot.getX()+3) {
      band.removeFromWorld();
      bird.setGrabbable(false);
      bird.setSensor(false);
      
      if (bird instanceof Blue) {
        bird.split();
      }
    }
  }

  void checkRespawn() {
    if (bird.getX() > width ||bird.getY() < 0 || bird.getY() > height) {

     bird.remove();
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
