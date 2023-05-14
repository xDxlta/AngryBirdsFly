class Bubbles extends Vogel {
  Bubbles() {
    super.attachImage(loadImage("Bubbles.png"));
  }
  
  void blowup() {
      super.setSize(100); 
      super.attachImage(loadImage("GiantBubbles.png")); 
  }

}
