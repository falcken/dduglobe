class Sat extends Thread {
  int id;
  float d, x, y, z, x2, y2, z2, velocity;
  float lat, lon, alt, lat2, lon2, alt2, angleb, angleb2;
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

    println("Lon1 og lon2: "+lon, lon2);
  }

  void update() {

  }

  void display() {
    pushMatrix();
    translate(x, y, z);
    rotate(angleb, naxis.x, naxis.y, naxis.z);
    fill(255);
    box(5, 5, 5);
    popMatrix();
  }

  void calcPath(){
    PVector pos = convert(lat, lon);
    PVector pos2 = convert(lat2, lon2);
    

    PVector xaxis = new PVector(1, 0, 0);
    angleb = PVector.angleBetween(xaxis, pos);
    raxis = xaxis.cross(pos);
    
    PVector naxis = pos.cross(pos2);
  }
}
