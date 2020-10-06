PVector convert(float lat, float lon) {
 float theta = radians(lat);

 float phi = radians(lon) + PI;

 float x = r * cos(theta) * cos(phi);
 float y = -r * sin(theta);
 float z = -r * cos(theta) * sin(phi);
 
 return new PVector(x, y, z);
}
