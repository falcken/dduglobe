ArrayList<Sat> sats = new ArrayList<Sat>();
float angle;

float r = 200;

PImage earth;
PShape globe;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  sats.add(new Sat(25544));
  sats.add(new Sat(28300));

  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }

  //println(timestamp);

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

void draw() {
  if (frameCount % 150 == 0) {
    thread("updateSats");
  }

  background(51);
  translate(width*0.5, height*0.5);
  //rotateY(angle);
  //angle += 0.01;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
  
  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.calcPath();
    s.display();
  }

  //println(satellit);
}

void updateSats() {
  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }
}
