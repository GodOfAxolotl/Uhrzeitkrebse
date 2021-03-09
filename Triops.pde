class Triops {


  PVector pos;
  PVector vel;
  PVector acc;
  float speed = random(1);
  int id;
  boolean alive = true;
  boolean gone = false;
  boolean hasEaten = false;
  float size = random(10, 20);
  int time = frameCount;
  float sizeVel = 0.01;
  float sizeAcc = -0.00001;
  boolean laidEggs = false;

  float colour = 145;
  float opp = 255;

  int rush = floor(random(5, 15));

  Triops(float x, float y, int id) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.id = id;
  }

  //-------------------------------------------------------------------------

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading2D() + HALF_PI);
    fill(colour, opp);
    ellipse(0, 0, size/2, size+size/3);

    popMatrix();
  }

  //-------------------------------------------------------------------------


  void update() {

    if (alive) {
      if (frameCount % rush == 0) {
        vel.add(acc);
        vel.limit(3);
      }
      
      if(size > 30 && !laidEggs) {
        int numberOfEggs = floor(random(map(triops.size(), 0, 200, 7, 0), map(triops.size(), 0, 200, 10, 0)));
        for(int i = 0; i < numberOfEggs; i++) {
         eggs.add(new Egg(pos.x + random(-5, 5), pos.y + random(-5, 5), runningID)); 
        }
        laidEggs = true;
      }
      
      pos.add(vel);

      if (hasEaten) {
        sizeVel = 0.01;
        hasEaten = false;
      }

      if (size >= 50) {
        alive = false;
      }

      if (pos.x < 0) {
        pos.x = 0;
        acc = new PVector(random(0, 1), random(-1, 1));
      } else if ( pos.x > width - 0) {
        pos.x = width - 0;
        acc = new PVector(random(-1, 0), random(-1, 1));
      } else if ( pos.y < 0) {
        pos.y = 0;
        acc = new PVector(random(-1, 1), random(0, 1));
      } else if ( pos.y > height - 0) {
        pos.y = height - 0;
        acc = new PVector(random(-1, 1), random(-1, 0));
      } else if (pos.x < size*2) {
        acc = new PVector(random(-0, 1), random(-0.5, 0.5));
      } else if ( pos.x > width - size*2) {
        acc = new PVector(random(-1, 0), random(-0.5, 0.5));
      } else if ( pos.y < size*2) {
        acc = new PVector(random(-0.5, 0.5), random(-0, 1));
      } else if ( pos.y > height - size*2) {
        acc = new PVector(random(-0.5, 0.5), random(-1, 0));
      } else {
        acc = new PVector(random(-0.5, 0.5), random(-0.5, 0.5));
      }

      size += sizeVel;
      sizeVel += sizeAcc;

      if (sizeVel <= 0) {
        alive = false;
      }
    } else {

      if (colour < 200) {
        colour -= 0.1;
        opp  -= 0.5;

        if ( opp <= 0) {
          gone = true;
        }
      }

      if (pos.x <= 0) {
        pos.x = 1;
        vel.x = -vel.x/1.5;
      } else if ( pos.x >= width - 0) {
        pos.x = width - 1;     
        vel.x = -vel.x/1.5;
      } else if ( pos.y <= 0) {
        pos.y = 1;       
        vel.y = -vel.y/1.5;
      } else if ( pos.y >= height - 0) {
        pos.y = height - 1;
        vel.y = -vel.y/1.5;
      }
      pos.add(vel);
      vel.add(gAcc);
    }
  }

  //-------------------------------------------------------------------------

  boolean eat(Pallet pallet) {
    
    if(!alive) {
      return false;
    }
    float distanceBetweenCircles = (float)Math.sqrt((pos.x - pallet.pos.x) * (pos.x - pallet.pos.x) + (pos.y - pallet.pos.y) * (pos.y - pallet.pos.y));

    if (distanceBetweenCircles < size/2 + pallet.size / 2)
    {
      hasEaten = true;
      return true;
    }

    return false;
  }
}
