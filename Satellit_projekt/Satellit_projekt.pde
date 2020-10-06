// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

ArrayList<Sat> sats = new ArrayList<Sat>();
float angle;

float r = 200;

PImage earth;
PShape globe;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  // table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_day.csv", "header");
  /*satellit = new JSONObject();
  satellit = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-71.014/0/1/&apiKey=KLH6Z6-VB9X47-UQLZJK-4KGO");

  JSONArray positions = satellit.getJSONArray("positions");
  JSONObject position = positions.getJSONObject(0);

  lon = position.getFloat("satlongitude");
  lat = position.getFloat("satlatitude");
  alt = position.getFloat("sataltitude");
  */
  sats.add(new Sat(25544));
  sats.add(new Sat(28300));
  
  for(int i = 0; i < sats.size(); i++) {
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
  rotateY(angle);
  angle += 0.01;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);

  //println(satellit);
}

void updateSats() {
  for(int i = 0; i < sats.size(); i++) {
    Sat s = sats.get(i);
    s.getPos();
  }
}
