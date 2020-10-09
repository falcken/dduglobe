ArrayList<Sat> sats = new ArrayList<Sat>();
float angle = 0;

int[] satList = {25544, 28300, 39509, 27818, 27436, 20103, 46380, 46142};

float r = 200, rxx, ryy;
int rx, ry;
float rotangle = 0;
float targetAngle = 0;
float easing = 0.05;

PImage earth;
PShape globe, box, bigBox;

boolean clicked = false;

void setup() {
  size(600, 600, P3D);
  smooth();
  earth = loadImage("earth.jpg");

  for (int i = 0; i < satList.length; i++) {
    sats.add(new Sat(satList[i]));
  }

  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }

  //println(timestamp);

  noStroke();
  box = createShape(BOX, 5, 5, 5);
  bigBox = createShape(BOX, 10, 10, 10);
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

void draw() {
  background(51);
  if (frameCount % 150 == 0) {
    thread("updateSats");
  }
  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.displayInfo();
  }

  if (mousePressed) {
    rx = (mouseX - pmouseX);
    ry = (mouseY - pmouseY);
    //rxx = map(rx, 0, width, -PI, PI);
    //ryy = map(ry, 0, height, -PI, PI);
    rxx = rxx + rx / 100.0;
    ryy = ryy + ry / -100.0;
    println(rxx, ryy, mouseX, pmouseX);
  }


  translate(width*0.5, height*0.5);
  //rotateY(rxx);
  //angle += 0.01;


  lights();
  fill(200);
  noStroke();
  //sphere(r);
  //globe.rotateX(ryy);
  //globe.rotateY(rxx);
  pushMatrix();
  rotateY(rxx);
  rotateX(ryy);
  shape(globe);


  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.calcPath();
    s.display();
  }
  popMatrix();
  //println(satellit);
}

void updateSats() {
  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }
}

void mouseClicked() {
  checkSatClick();
}

void checkSatClick() {
  println("detected click");
  for (int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    //println(modelX(s.pos.x, s.pos.y, s.pos.z), mouseX);
    //println(green(get(mouseX, mouseY)), green(s.c));

    if (s.realX < mouseX+20 && s.realX+20 > mouseX && s.realY < mouseY+20 && s.realY+20 > mouseY) {
      println("CLICKED: "+i);
      for (int u = 0; u < sats.size(); u++) {
        Sat ss = sats.get(u);
        if (ss.showingInfo && u != i) {
          ss.showInfo();
        }
      }
      s.showInfo();
      stroke(1);
      //rect(s.realX + 20, s.realY + 20, 30, 30);
    }

    //if (red(get(mouseX, mouseY))+25 > red(s.c) && red(get(mouseX, mouseY))-25 < red(s.c)) {
    //  println("CLICKED: "+i);
    //}
  }
}
