PImage src;
PImage res;


void setup() {
  src = loadImage("medusa.jpg");
  res = createImage(src.width, src.height, RGB);
  size(src.width, src.height, JAVA2D);

 
  noLoop();
  noStroke();
  noSmooth(); 
  
}

void draw() {
  background(255,0,0);
  int s = 1;
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      color oldpixel = src.get(x, y);
      color newpixel = findClosestColor( color(brightness(oldpixel) + random(-64,64)) );      
      src.set(x, y, newpixel);
      
      
      stroke(newpixel);      
     
      point(x,y);
     
    }
  }
 
}


color findClosestColor(color c) {
  color r;
  // Treshold function
  if (brightness(c) < 128) {
    r = color(0);
  }
  else {
    r = color(255);
  }
  return r;
}

