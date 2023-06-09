import fisica.*;
FWorld world;

Schleuder schleuder;
KingPig kingpig;
FBox cliff;
FBox ground;
int numEggs = 3;   //Leben
int score = 0;     //Punktestand
int wave = 1;      //Schwierigkeitsgrad
ArrayList<Ballon> schweindron = new ArrayList<>(); //Wortwitz aus Schwadron und Schwein. Eine Schweindron eben.

PImage pigTexture; //Veriablen für die Bilder
PImage eggTexture;
PImage ballonTexture;
PImage blueTexture;
PImage bubblesTexture;
PImage giantBubblesTexture;
PImage chuckTexture;
PImage corporalTexture;
PImage redTexture;
PImage rocketTexture;
PImage kingpigTexture;
PImage scoreTexture;
PImage gameoverTexture;
PImage victoryTexture;


void setup() {
  size (1000, 500);
  Fisica.init(this);
  world = new FWorld();
  world.remove(world.top);
  pigTexture = loadImage("Pig.png");    //Bilder werden auf die Variablen geladen
  eggTexture = loadImage("Ei.png");
  ballonTexture = loadImage("Ballon.png");
  blueTexture = loadImage("Blue.png");
  bubblesTexture = loadImage("Bubbles.png");
  giantBubblesTexture = loadImage("GiantBubbles.png");
  chuckTexture = loadImage("Chuck.png");
  corporalTexture = loadImage("Corporal.png");
  redTexture = loadImage("Red.png");
  rocketTexture = loadImage("Rocket.png");
  kingpigTexture = loadImage("KingPig.png");
  scoreTexture = loadImage("Kill.png");
  gameoverTexture = loadImage("GameOver.png");
  victoryTexture = loadImage("Victory.png");
  cliff = new FBox (180, 200);
  cliff.setPosition(90, height-100);
  cliff.setFill(130, 12, 12);
  cliff.setStatic(true);
  cliff.setGrabbable(false);
  world.add(cliff);
  ground = new FBox (1100, 20);        //Ein Boden, damit die Schweine auch zerstört werden, wenn man den Ballon trifft
  ground.setPosition(width/2, height + 150);
  ground.setStatic(true);
  ground.setGrabbable(false);
  world.add(ground);
  
  schleuder = new Schleuder();
  kingpig = new KingPig();
}

void draw() {
  background(128, 212, 255);
  image(eggTexture, 50, 20);
  image(scoreTexture, 170, 26);
  fill(0);
  textSize(20);
  text(numEggs, 83, 70);
  text(score, 190, 70);
  schleuder.checkJoint();     //Es wird überprüft ob der Vogel abgeschossen wird
  schleuder.checkRespawn();   //Es wird überprüft ob ein neuer Vogel in die Schleuder gesetzt werden muss

  world.step();
  world.draw();

  kingpig.setVelocity(0, kingpig.getSpeed()); //Dem Endboss wird schonmal eine Geschwindigkeit gegeben

  if (keyPressed == true && key == ' ') { //Die Variablen werden zurückgesetzt, respawn
    wave = 1;
    numEggs = 3;
    score = 0;
    kingpig.bossbar = 5;
    world.remove(kingpig);
  }

  if (wave == 5) {   //Wenn der Bosskampf beginnt, wird eine Lebensleiste generiert
    fill(255, 0, 0);
    rect(800, 50, 30 * kingpig.getBossbar(), 30);
  }

  if (numEggs >= 1 && kingpig.getBossbar() >= 1) { //Die Schweine spawnen nur, wenn noch genug Leben vorhanden sind (man also nicht verloren hat) und der Boss noch lebt (man also nicht gewonnen hat)
    for (Ballon b : schweindron) {                 //Arraylist. Wird benötigt, damit mehrere Instanzen der Schweine spawnen können und nicht nur eine
      if (b.getRank() == 0 || b.getRank() == 1) {  //Es wird überprüft welche Art Schwein vorliegt, weil eines eine höhere Geschwindigkeit hat
        b.setVelocity(0, b.getSpeed());
      } else if (b.getRank() == 2) {
        b.setVelocity(b.getVelocityX()+int(random(-20, 20)), b.getSpeed()*2); //Raketenschweins Geschwindigkeit und der "Schwank"effekt in verschiedene Richtungen
        b.setRotation(-atan(b.getVelocityX()/b.getVelocityY()));
      }

      if (b.getAnhang() == null) {   //Falls der Ballon das obere Ende erreicht, ohne, dass ein Schwein dranhängt, dann soll er entfernt werden
        if (b.getY() < -10) {
          world.remove(b);
        }
      } else if (b.getAnhang().getY() < -10) {   //Falls aber noch ein Schwein am Ballon hängt, dann sollen beide entfernt werden und ein Leben wird abgezogen
        numEggs -= 1;
        world.remove(b.getAnhang());
        world.remove(b);
      }
    }


    /*if (b.anhang.getY() > height + 150) {
     world.remove(b.getAnhang());
     }*/
  }

  if (numEggs <= 0) {    //Falls man verliert passiert das hier
    image(gameoverTexture, width/2, height/2);
    textSize(50);
    text("Game Over", width/2 - 47, height/2 -20);
    textSize(20);
    text("Press [Space] to retry", width/2 -24, height/2 +130);
    kingpig.setVelocity(0, 0);
  }

  if (kingpig.getBossbar() <= 0) {    //Falls man gewinnt passiert das hier
    world.remove(kingpig);
    fill(255, 255, 255);
    image(victoryTexture, width/2, height/2);
    textSize(50);
    text("Good Game", width/2 - 47, height/2 -20);
    textSize(20);
    text("Press [Space] to retry", width/2 -24, height/2 +130);
  }

  if (numEggs >= 1 && kingpig.getBossbar() >= 1) {
    if (wave < 5) {                                     //Je nach Welle spawnen mehr oder weniger Schweine
      if (frameCount % (100*(5-wave)) == 0) {
        schweindron.add(new Ballon());
      }
    } else {
      if (frameCount % 300 == 0) {        //Im Bosskampf spawnen mittelmäßig viele Schweine
        schweindron.add(new Ballon());
      }
    }
  }
}

void contactStarted(FContact contact) {
  for (int i = schweindron.size() - 1; i >= 0; i--) {
    Ballon b = schweindron.get(i);
    if (contact.getBody1() == b || contact.getBody2() == b) {    //Wenn zwei Objekte kollidieren, von denen eines der Ballon ist, dann wird der Ballon entfernt und der Score wird (außer im Bosskampf) hochgesetzt
      world.remove(b);
      /*if (wave <= 5) {
        score += 1;
      }
      if (score != 0 && score % 20 == 0) {          //Alle 20 Kills wird der Schwierigkeitsgrad um 1 erhöht
        wave += 1;
        if (wave == 5) {          //Nach 80 besiegten Schweinen startet der Bosskampf
          kingpig.bossfight();
        }
      }*/
    }

    if ((contact.getBody1() == b.getAnhang() || contact.getBody2() == b.getAnhang()) && !(b.getAnhang() instanceof Corporal)) {      //Wenn ein Schwein abgeschossen wird, dass kein Corporal ist, dann wird dieses zerstört und der Ballon fliegt schneller nach oben
      b.setSpeed(-100);
      b.removeAnhang();
      if (wave <= 5) {
        score += 1;
      }
      if (score != 0 && score % 20 == 0) {
        wave += 1;
        if (wave == 5) {
          kingpig.bossfight();
        }
      }
    }
    
    if(contact.getBody1() == b.getAnhang() && b.getAnhang() instanceof Corporal && contact.getBody2() == ground || contact.getBody2() == b.getAnhang() && b.getAnhang() instanceof Corporal && contact.getBody1() == ground) {        //Der Corporal soll durch die Vögel unzerstörbar sein, wenn er allerdings auf dem Boden aufschlägt, soll man die Punkte bekommen
      b.removeAnhang();
      if (wave <= 5) {
        score += 1;
      }
      if (score != 0 && score % 20 == 0) {
        wave += 1;
        if (wave == 5) {
          kingpig.bossfight();
        }
      }
    }

    if (contact.getBody1() == b.getAnhang() && b.getAnhang() instanceof Corporal && contact.getBody2() == kingpig || contact.getBody2() == b.getAnhang() && b.getAnhang() instanceof Corporal && contact.getBody1() == kingpig) {     //Wenn der Boss von einem Corporal getroffen wird, dann verliert er ein Leben
      b.removeAnhang();
      kingpig.setBossbar(kingpig.getBossbar()-1);
    }

    if ((contact.getBody1() == schleuder.bird && schleuder.bird instanceof Bubbles || contact.getBody2() == schleuder.bird && schleuder.bird instanceof Bubbles) && schleuder.bird.getX() > schleuder.slingshot.getX()+20) {      //Wenn der Vogel Bubbles etwas berührt, dann bläht er sich auf
      schleuder.bird.blowup();
    }
  }
}
