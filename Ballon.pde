class Ballon extends Hittable {
  FCircle anhang;
  FDistanceJoint schnur;
  float x = random(40, 70);
  float speed = -50;
  int rank;

  Ballon() {
    if(wave == 1) {      //Je nach Welle, spawnen andere Schweinarten
      rank = 0;
    } else if(wave == 2) {
      rank = int(random(0, 2));
    } else if(wave == 3 || wave == 4) {
      rank = int(random(0,3));
    } else {
      rank = 1;
    }
    super.setFill(255, 0, 0);
    if(wave < 5) {        //Im Bosskampf spawnen die Schweine nur über dem Boss
    super.setPosition(random(210, 950), 550);
    }
    else {      //Ansonsten überall eigentlich
      float rnd = random(kingpig.getX()-90, kingpig.getX()+90);
      super.setPosition(rnd, kingpig.getY()-160);
    }
    super.setGrabbable(false);
    if (rank == 0 || rank == 1) {      //Hier werden die verschiedenen Ballonarten texturiert
      super.attachImage(ballonTexture);
      world.add(this);
    } else {
      super.attachImage(rocketTexture);
      world.add(this);
    }


    if (rank == 0 || rank == 2) {      
      anhang = new Schwein();
    } else if (rank == 1) {
      anhang = new Corporal();
    }
    anhang.setPosition(getX(), getY() + x);
    anhang.setGrabbable(false);
    world.add(anhang);

    schnur = new FDistanceJoint(this, anhang);       //Die Schweine werden an den Ballon gebunden mit eienr Schnur, die in der Länge veriiert 
    schnur.setLength(x);
    schnur.setStrokeColor(#8b4513);
    schnur.setFillColor(#8b4513);
    schnur.setFrequency(2);
    world.add(schnur);
  }

  int getRank() {
    return rank;
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

  void removeAnhang() {        //Wenn der Anhang zerstört wird, dann soll der Ballon noch kurz weiterbestehen, deshalb null
    world.remove(anhang);
    anhang = null;
  }
}
