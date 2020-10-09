ArrayList<Sat> sats = new ArrayList<Sat>();
float angle = 0;

float r = 200, rxx, ryy;
int rx, ry;
float rotangle = 0;
float targetAngle = 0;
float easing = 0.05;

PImage earth;
PShape globe, box;

void setup() {
  size(600, 600, P3D);
  smooth();
  earth = loadImage("earth.jpg");
  sats.add(new Sat(25544));
  sats.add(new Sat(28300));

  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }

  //println(timestamp);

  noStroke();
  box = createShape(BOX, 5, 5, 5);
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

void draw() {
  if (frameCount % 150 == 0) {
    thread("updateSats");
  }

  if (mousePressed) {
    rx = (mouseX - pmouseX);
    ry = (mouseY - pmouseY);
    //rxx = map(rx, 0, width, -PI, PI);
    //ryy = map(ry, 0, height, -PI, PI);
    rxx = rxx + rx / 100.0;
    ryy = ryy + ry / -100.0;
    println(rxx,ryy,mouseX, pmouseX);
  }
  
  
  background(51);
  translate(width*0.5, height*0.5);
  //rotateY(rxx);
  //angle += 0.01;


  lights();
  fill(200);
  noStroke();
  //sphere(r);
  //globe.rotateX(ryy);
  //globe.rotateY(rxx);
    rotateY(rxx);
  rotateX(ryy);
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
