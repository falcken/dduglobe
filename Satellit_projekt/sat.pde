class Sat {
  int id;
  float d;
  float lat, lon, alt, lat2, lon2, alt2;
  JSONObject satellit1;
  JSONObject satellit2;
  
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
    
    println("Lon1 og lon2: "+lon,lon2);
  }
  
  void update() {
    
  }
  
  void display() {
    
  }
  
  void calcVel(){
    
  }
}
