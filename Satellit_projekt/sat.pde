class Sat {
  int id;
  float lat, lon, alt;
  
  Sat(int identifier) {
    id = identifier;
  }
  
  void getPos() {
    satellit = new JSONObject();
    satellit = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/"+id+"/41.702/-71.014/0/1/&apiKey=KLH6Z6-VB9X47-UQLZJK-4KGO");
  
    JSONArray positions = satellit.getJSONArray("positions");
    JSONObject position = positions.getJSONObject(0);
  
    lon = position.getFloat("satlongitude");
    lat = position.getFloat("satlatitude");
    alt = position.getFloat("sataltitude");
  }
  
  void update() {
    
  }
  
  void display() {
    
  }
}
