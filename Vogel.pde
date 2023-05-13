class Vogel extends FCircle {
  Vogel() {
    super(20);
    super.setFill(255, 0, 0);
    super.setSensor(false);
  }
  
  void split() {}
  void remove() {
   world.remove(this); 
  }
}
