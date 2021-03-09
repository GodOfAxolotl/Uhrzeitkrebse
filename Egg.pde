class Egg {

  PVector pos;
  PVector vel;
  int id;
  boolean hatchable = true;
  boolean hatched = false;
  int size = 10;
  int time = frameCount;
  int hatchTime = floor(random(250, 500));


  Egg(float xPos, float yPos, int id) {
    pos = new PVector(xPos, yPos);
    vel = new PVector(0, 0);
    this.id = id;
    runningID++;

    if (random(10) >= 9.9) {
      hatchable = false;  //kaputte Eier
    }
  }
  
//-------------------------------------------------------------------------

  void display() {
    fill(128, 57, 30);
    ellipse(pos.x, pos.y, size, size);
  }
  
//-------------------------------------------------------------------------

  void update() {
    if (pos.y > height - size/2) {
      pos.y = height-size/2;
      vel.x = 0;
      vel.y = -vel.y + vel.y/2;
    } else {
      pos.add(vel);
      vel.add(gAcc);
    }

    if (frameCount - time >= hatchTime && !hatched) {
      hatch();
    }
  }
  
//-------------------------------------------------------------------------

  void hatch() {
    if (!hatchable) {
      return;
    }
    shells.add(new Shell(pos.x, pos.y, vel.x, vel.y, random(-3, 3)));
    shells.add(new Shell(pos.x, pos.y, vel.x, vel.y, random(-3, 3)));
    triops.add(new Triops(pos.x, pos.y, id));
    hatched = true;
  }
}
