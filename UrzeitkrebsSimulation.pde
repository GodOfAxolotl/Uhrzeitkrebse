
PVector gAcc = new PVector(0, 0.01);
ArrayList<Egg> eggs = new ArrayList<Egg>();
ArrayList<Shell> shells = new ArrayList<Shell>();
ArrayList<Triops> triops = new ArrayList<Triops>();
ArrayList<Pallet> pallets = new ArrayList<Pallet>();

int runningID = 0;

boolean autofeed = false;


void setup() {
  size(600, 600, P2D);
  smooth(64);
  frameRate(60);
  background(105, 189, 210);
  noStroke();
}


void draw() {
  background(105, 189, 210);
  fill(255);
  text(frameRate, 10, 20);
  text(triops.size(), 10, 36);
  println(map(triops.size(), 0, 500, 10, 1));
  
  if(autofeed && frameCount % 20 == 0) {
    pallets.add(new Pallet(random(0, width), 0)); 
  }
  
  if(triops.size() >= 300 && frameCount % 2 == 0) {
   triops.remove(floor(random(0, triops.size())));
  }

  for (int i = 0; i < eggs.size(); i++) {
    Egg egg = eggs.get(i);
    egg.display();
    egg.update();
    if (egg.hatched) {
      eggs.remove(i);
    }
  } 

  for (int i = 0; i < shells.size(); i++) {
    Shell shell = shells.get(i);
    shell.display();
    shell.update();
    if (shell.done) {
      int numberOfPallet = floor(random(1, 6));
      for(int k = 0; k < numberOfPallet; k++) {
       pallets.add(new Pallet(shell.pos.x + random(-9, 9), shell.pos.y + random(-9, 9))); 
      }
      shells.remove(i);
    }
  }

  for (int i = 0; i < triops.size(); i++) {
    Triops triop = triops.get(i);
    triop.display();
    triop.update();

    for (int j = 0; j < pallets.size(); j++) {
      Pallet pallet = pallets.get(j);
      if (triop.eat(pallet)) {
        pallets.remove(j);
      }
    }

    if (triop.gone) {
      for(int k = 0; k < triop.size/2; k++) {
       pallets.add(new Pallet(triop.pos.x + random(-14, 14), triop.pos.y + random(-14, 14))); 
      }
      triops.remove(i);
      
    }
  }

  for (int j = 0; j < pallets.size(); j++) {
    Pallet pallet = pallets.get(j);
    pallet.display();
    pallet.update();
  }
}

//-------------------------------------------------------------------------

void mousePressed() {
  if (mousePressed && mouseButton == LEFT) {
    eggs.add(new Egg(mouseX, mouseY, runningID));
  } else if ( mousePressed && mouseButton == RIGHT) {
    pallets.add(new Pallet(mouseX, mouseY));
  }
}

void keyPressed() {
 if(key == 'a') {
  autofeed = true; 
 }
 if(key == 's') {
  autofeed = false; 
 }
}
