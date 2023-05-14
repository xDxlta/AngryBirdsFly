import fisica.*;
FWorld world;

Schleuder schleuder;
Bubbles bubbles; 
FBox cliff;
int numEggs = 3;
int score = 0;
ArrayList<Ballon> schweindron = new ArrayList<>(); //Wortwitz aus Schwadron und Schwein. Eine schweindron eben.

PImage pigTexture;
PImage eggTexture;


void setup() {
  size (1000, 500);
  Fisica.init(this);
  world = new FWorld();
  world.remove(world.top);
  cliff = new FBox (180, 200);
  cliff.setPosition(90, height-100);
  cliff.setFill(130, 12, 12);
  cliff.setStatic(true);
  cliff.setGrabbable(false);
  world.add(cliff);
  schleuder = new Schleuder();
  pigTexture = loadImage("Pig.png");
  eggTexture = loadImage("Ei.png");
}

void draw() {
  background(128, 212, 255);
  image(eggTexture, 50, 20);
  fill(0);
  textSize(20);
  text(numEggs, 83, 70);
  text(score, 200, 200);
  schleuder.checkJoint();
  schleuder.checkRespawn();
  
  world.step();
  world.draw();

  for (Ballon b : schweindron) {
    b.setVelocity(0, b.getSpeed());
    if (b.getAnhang() == null) {
      if(b.getY() < -10) {
        world.remove(b);
      }
    }
    else if (b.getAnhang().getY() < -10) {
      numEggs -= 1;
      world.remove(b.getAnhang());
      world.remove(b);
    }
  }

  if (frameCount % 100 == 0) {
    schweindron.add(new Ballon());
  }
}

void contactStarted(FContact contact) { //bug: ballons können ineinander spawnen, platzen, bug: ballons fallen runter
  for (int i = schweindron.size() - 1; i >= 0; i--) {
    Ballon b = schweindron.get(i);
    if (contact.getBody1() == b || contact.getBody2() == b) {
      world.remove(b);
      score += 1;
    }

    if (contact.getBody1() == b.getAnhang() || contact.getBody2() == b.getAnhang()) {
      b.setSpeed(-100);
      b.removeAnhang();
      score += 1;
    }
    if (contact.getBody1() == schleuder.bird && schleuder.bird instanceof Bubbles || contact.getBody2() == schleuder.bird && schleuder.bird instanceof Bubbles) {
      bubbles.blowup(); 
      println("Blow");
    }
  }
}
