class Pallet {

  PVector pos;
  PVector vel;

  float size = random(4, 7);

  boolean gone = false;


  Pallet(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
  }

  //-------------------------------------------------------------------------


  void display() {
    fill(170, 60, 30);
    ellipse(pos.x, pos.y, size, size);
  }

  //-------------------------------------------------------------------------


  void update() {
    pos.add(vel);
    if(pos.y >= width){
     pos.y = width-size/2; 
     vel.y = - vel.y + vel.y/8;
    } else {
    vel.add(gAcc);
    }
    
    vel.limit(2);
  }
}
