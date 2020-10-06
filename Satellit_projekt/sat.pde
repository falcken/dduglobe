class Sat extends Thread {
  int id;
  float d, x, y, z, x2, y2, z2, velocity;
  float lat, lon, alt, lat2, lon2, alt2, angleb, angleb2;
  JSONObject satellit1;
  JSONObject satellit2;

  PVector raxis, raxis2;

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

    println("Lon1 og lon2: "+lon, lon2);
  }

  void update() {

  }

  void display() {
    pushMatrix();
    translate(x, y, z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255);
    box(5, 5, 5);
    popMatrix();
  }

  void calcCoor(){
    float theta = radians(lat);
    float phi = radians(lon) + PI;
    float h = map(alt, 0, 1000, 0, 32);

    float theta2 = radians(lat2);
    float phi2 = radians(lon2) + PI;
    float h2 = map(alt2, 0, 1000, 0, 32);

    // original version
    // float x = r * sin(theta) * cos(phi);
    // float y = -r * sin(theta) * sin(phi);
    // float z = r * cos(theta);

    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    x = r * cos(theta) * cos(phi);
    y = -r * sin(theta);
    z = -r * cos(theta) * sin(phi) - h;

    x2 = r * cos(theta2) * cos(phi2);
    y2 = -r * sin(theta2);
    z2 = -r * cos(theta2) * sin(phi2) - h2;

    PVector pos = new PVector(x, y, z);
    PVector pos2 = new PVector(x2, y2, z2);

    PVector xaxis = new PVector(1, 0, 0);
    angleb = PVector.angleBetween(xaxis, pos);
    raxis = xaxis.cross(pos);

    PVector xaxis2 = new PVector(1, 0, 0);
    angleb2 = PVector.angleBetween(xaxis2, pos2);
    raxis2 = xaxis2.cross(pos2);
  }
}
