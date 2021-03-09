class Shell {


  PVector pos;
  PVector vel;
  int size = 10;
  float degrees = random(360);
  float turnVel = 0.08;
  float turnAcc = 0.0005;
  boolean done;
  float opp = 255;

  Shell(float x, float y, float vx, float vy, float vxPlus) {
    pos = new PVector(x, y);
    vel = new PVector(vx+vxPlus, vy);
  }

  //-------------------------------------------------------------------------


  void display() {
    pushMatrix();
    fill(128, 57, 30, opp);

    if (opp <= 0) {
      done = true;
    } else {
      opp -= 0.7;
    }
    translate(pos.x, pos.y);
    rotate(degrees);
    arc(0, 0, 10, 10, 0, PI);
    degrees += turnVel;
    if (turnVel >= 0) {
      turnVel -= turnAcc;
    } else {
      turnVel = 0;
    }
    popMatrix();
  }

  //-------------------------------------------------------------------------

  void update() {

    if (pos.y > height - size/2) {
      pos.y = height-size/2;
      vel.x = vel.x - vel.x/8;
      vel.y = -vel.y + vel.y/1.5;
    } else {
      pos.add(vel);
      vel.add(gAcc);
    }

    if (pos.x <= size/2 || pos.x >= width - size/2) {
      vel.x = - vel.x + vel.x/4;
    }
  }
}
