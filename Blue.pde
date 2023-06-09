class Blue extends Vogel {
  Blue children[] = new Blue[2];

  Blue() {
    super.attachImage(blueTexture);
  }

  @Override
    void split() {
    if (children[0] == null) {      //Wenn die Blauen abgeschossen werden, dann werden zwei neue Instanzen erzeugt, die leicht unter und über der Originalinstanz sind und versetzte Geschwindigkeiten haben
      children[0] = new Blue();
      children[1] = new Blue();
      world.add(children[0]);
      world.add(children[1]);
      children[0].setPosition(getX(), getY()-5);
      children[1].setPosition(getX(), getY()+5);
      children[0].setVelocity(getVelocityX(), getVelocityY()*-5);
      children[1].setVelocity(getVelocityX(), getVelocityY()*5);
    }
  }
  
  @Override
  void remove() {
   world.remove(children[0]);
   world.remove(children[1]);
   world.remove(this);
  }
}
