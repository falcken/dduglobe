class Sat {
  int id;
  float d, x, y, z, x2, y2, z2, velocity;
  float lat, lon, alt, lat2, lon2, alt2, angleb, angleb2, angle, speed;
  PVector pos, pos2;
  JSONObject satellit1;
  JSONObject satellit2;

  PVector raxis, raxis2, naxis;

  Sat(int identifier) {
    id = identifier;
  }

  void async() {
    thread("getPos");
  }

  void getPos() {
    satellit1 = new JSONObject();
    satellit1 = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/"+id+"/41.702/-71.014/0/2/&apiKey=KLH6Z6-VB9X47-UQLZJK-4KGO");

    JSONArray positions = satellit1.getJSONArray("positions");
    JSONObject position = positions.getJSONObject(0);

    lon = position.getFloat("satlongitude");
    lat = position.getFloat("satlatitude");
    alt = position.getFloat("sataltitude");

    JSONObject position2 = positions.getJSONObject(1);

    lon2 = position2.getFloat("satlongitude");
    lat2 = position2.getFloat("satlatitude");
    alt2 = position2.getFloat("sataltitude");

    //println("Lon1 og lon2: "+lon, lon2);
  }

  void update() {
  }

  void display() {
    angleb2 = angleb2 + speed*frameCount/30;
    //println(angleb2);
    pushMatrix();
    rotate(angleb2+speed, naxis.x, naxis.y, naxis.z);
    translate(pos.x, pos.y, pos.z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255);
    
    shape(box);
    popMatrix();
  }

  void calcPath() {
    float h1 = map(alt, 0, 1000, 0, 32);
    float h2 = map(alt2, 0, 1000, 0, 32);
    
    pos = convert(lat, lon, h1+200);
    //println(h1, h2);
    pos2 = convert(lat2, lon2, h2+200);
    
    speed = (sqrt(sq(pos2.x-pos.x)+sq(pos2.y-pos.y)+sq(pos2.z-pos.z)));
    //println(speed);

    PVector xaxis = new PVector(1, 0, 0);
    angleb = PVector.angleBetween(xaxis, pos);
    raxis = xaxis.cross(pos);

    naxis = pos.cross(pos2);
    angleb2 = PVector.angleBetween(pos, pos2);
  }
}
