class KingPig extends FCircle {
  float speed = -10;
  float bossbar = 5; 
  KingPig() {
    super(135);
    super.attachImage(kingpigTexture);
     super.setPosition(580, 500);
    super.setGrabbable(false);
    }
    void bossfight() {      //Wird erst beim Bossfight in die Welt geholt
      world.add(this);
    }
float getSpeed() {
  return speed;
}
float getBossbar() {
  return bossbar;
}
void setBossbar(float bossbar) {
  this.bossbar = bossbar; 
}
}
