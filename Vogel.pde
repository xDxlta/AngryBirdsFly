class Vogel extends FCircle {
  Vogel() {
    super(20);
    super.setFill(255, 0, 0);
    super.setSensor(false);
  }
  
  void split() {}      //Wird hier schonmal erzeugt (aber leer), dmait ich in den Klassen später mit Override etwas hinzufügen kann
  void blowup() {}
  void remove() {
   world.remove(this); 
  }
}
