class Sat {
  int id, satid;
  float d, x, y, z, x2, y2, z2, velocity;
  float lat, lon, alt, lat2, lon2, alt2, angleb, angleb2, angle, speed, buffer, realX, realY;
  PVector pos, pos2;
  JSONObject satellit1;
  JSONObject satellit2;
  
  String satname;

  PVector raxis, raxis2, naxis;
  
  color c;

  Sat(int identifier) {
    id = identifier;
    
    //c = color(random(0.0, 255.0), random(0,255), random(0,255));
    c = color(250, 255, 61);
  }

  void async() {
    thread("getPos");
  }

  void getPos() {
    satellit1 = new JSONObject();
    satellit1 = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/"+id+"/41.702/-71.014/0/2/&apiKey=KLH6Z6-VB9X47-UQLZJK-4KGO");

    JSONArray positions = satellit1.getJSONArray("positions");
    JSONObject info = satellit1.getJSONObject("info");
    JSONObject position = positions.getJSONObject(0);

    lon = position.getFloat("satlongitude");
    lat = position.getFloat("satlatitude");
    alt = position.getFloat("sataltitude");
    satid = info.getInt("satid");
    satname = info.getString("satname");
    
    println(satid, satname);

    JSONObject position2 = positions.getJSONObject(1);

    lon2 = position2.getFloat("satlongitude");
    lat2 = position2.getFloat("satlatitude");
    alt2 = position2.getFloat("sataltitude");

    //println("Lon1 og lon2: "+lon, lon2);
  }

  void update() {
  }

  void display() {
    //float buffer = angleb2;
    buffer += angleb2 + speed;
    //println(buffer);
    buffer = angleb2+speed;
    //println(angleb2);
    pushMatrix();
    rotate(buffer, naxis.x, naxis.y, naxis.z); // roter om klode
    translate(pos.x, pos.y, pos.z);
    rotate(angleb, raxis.x, raxis.y, raxis.z); // align
    box.setFill(c);
    buffer = angleb2;
    realX = screenX(0,0);
    realY = screenY(0,0);
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
    //speed = PVector.angleBetween(pos, pos2);
    //println(speed);

    PVector xaxis = new PVector(1, 0, 0);
    angleb = PVector.angleBetween(xaxis, pos);
    raxis = xaxis.cross(pos);

    naxis = pos.cross(pos2);
    angleb2 = PVector.angleBetween(pos, pos2);
  }
  
  void showInfo() {
    println("YO MAMA");
  }
}
