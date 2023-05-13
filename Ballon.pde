class Ballon extends Hittable {
  FCircle anhang;
  FDistanceJoint schnur;
  float x = random(40, 70);
  float speed = -50;
  
  Ballon() {
    super.setFill(255, 0, 0);
    super.setPosition(random(210, 950), 550);
    super.setGrabbable(false);
    super.attachImage(loadImage("Ballon.png"));
    world.add(this);

    anhang = new Schwein();
    anhang.setPosition(getX(), getY() + x);
    anhang.setGrabbable(false);
    world.add(anhang);

    schnur = new FDistanceJoint(this, anhang);
    schnur.setLength(x);
    schnur.setStrokeColor(#8b4513);
    schnur.setFillColor(#8b4513);
    schnur.setFrequency(2);
    world.add(schnur);
  }
  
  void setSpeed(float speed) {
    this.speed = speed;
  }
  
  float getSpeed() {
    return speed;
  }
  
  FCircle getAnhang() {
    return anhang;
  }
  
  void removeAnhang() {
    world.remove(anhang);
    anhang = null;
  }
}
