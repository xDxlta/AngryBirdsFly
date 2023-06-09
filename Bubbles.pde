class Bubbles extends Vogel {
  Bubbles() {
    super.attachImage(bubblesTexture);
  }
  
  @Override
  void blowup() {        //Neue Textur und neue Größe beim Aufblähen 
      super.setSize(100); 
      super.attachImage(giantBubblesTexture); 
  }
}
