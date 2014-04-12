
ArrayList Balls;
short mass;
byte h;
PFont font;


void setup() {

  size(640, 640);
  frameRate(60);

  Balls = new ArrayList();

  mass = 400;
  h = 80;
}

float distance(PVector pos, PVector pos2) {
  return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
}

PVector grav(PVector pos) {
  PVector direction = new PVector(width/2 - pos.x, height/2 - pos.y);
  direction.normalize();
  float d = distance(pos, new PVector(width/2, height/2));
  direction.mult(mass/(d*d));
  return direction;
}


class Ball {
  PVector position;
  PVector velocity;
  Ball(float px, float py, float vx, float vy) {
    position = new PVector(px, py);
    velocity = new PVector(vx/100, vy/100);
  }
  void drawball(int rad) {
    PVector gravity = grav(position);
    PVector velgrav = velocity;
    velgrav.add(gravity);
    position.add(velgrav);
    if ( rad <=5) {
      strokeWeight(2);
      fill(255, 0, 0);
      strokeWeight(0);
      ellipse(position.x, position.y, rad, rad);
    }
    else {
      strokeWeight(0);
      fill(0);
      stroke(255);
      strokeWeight(1);
      ellipse(position.x, position.y, rad, rad);
    }
  }
}

void draw() {
  background(0);
  text("mouseClick -> add asteroids", 10, 10);

  text("c - clear", 10, 30);
  float ds = distance(new PVector(mouseX, mouseY), new PVector(width/2, height/2 - 60));
  stroke(200*(ds/250), 100, 50);
  strokeWeight(2);

  fill(150);

  for (int i = Balls.size()-1; i >= 0; i--) {
    Ball a = (Ball) Balls.get(i);
    if ( i == 10)
      a.drawball(50);
    else
      a.drawball(5);
    float dis = distance(a.position, new PVector(width/2, height/2));
    if ( dis < 10 || dis > 2000) {
      Balls.remove(i);
    }
  }

  strokeWeight(2);
  fill(150);
  stroke(200, 100, 50);
  for (int i1 = Balls.size()-1; i1 >= 0; i1--) {
    Ball a = (Ball) Balls.get(i1);
    float dt = 100000000;
    for (int i2 = Balls.size()-1; i2 >= 0; i2--) {
      if ( i1 != i2 ) {
        Ball b = (Ball) Balls.get(i2);
        float dd = distance ( a.position, b.position );
        if ( dd < dt ) dt = dd;
        if ( dd < 50.0 )
          line ( a.position.x, a.position.y, b.position.x, b.position.y);
      }
    }
  }
}

void mousePressed() {

  int hh = h/10;
  background(0);
  for ( int i = 2; i<20; i++) {
    int hi = hh*i;

    PVector m = new PVector(width/2, height/2 );
    PVector v1 = new PVector(width/2, height/2 - hi);
    PVector v2 = new PVector((mouseX - width/2)*10/pow(hi, .50), 0);

    v1.sub(m);
    v1.rotate(random(50)*PI/100);
    v2.rotate(random(50)*PI/100);
    v1.add(m); 

    Balls.add(new Ball(v1.x, v1.y, v2.x, v2.y ));
  }

  for ( int i = 20; i<80; i++) {
    int hi = hh*(20 + i/3);

    PVector m = new PVector(width/2, height/2 );
    PVector v1 = new PVector(width/2, height/2 - hi);
    PVector v2 = new PVector((mouseX - width/2)*10/pow(hi, .50), 0);

    v1.sub(m);
    v1.rotate(random(50)*PI/100);
    v2.rotate(random(50)*PI/100);
    v1.add(m); 

    Balls.add(new Ball(v1.x, v1.y, v2.x, v2.y ));
  }
}


void keyPressed() {
  if (key == 'w' && h < 121) {
    h++;
  }
  else if (key == 's' && h > 61) {
    h--;
  }
  else if (key == 'c') {
    for (int i = Balls.size()-1; i >= 0; i--) {
      Balls.remove(i);
    }
  }
}

