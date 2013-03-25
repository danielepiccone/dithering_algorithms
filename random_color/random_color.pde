import processing.pdf.*;

PImage src;
PImage res;


void setup() {
  src = loadImage("medusa.jpg");
  res = createImage(src.width, src.height, RGB);
  size(src.width, src.height, JAVA2D);

  //smooth();
  noLoop();
  noStroke();
  noSmooth(); 
  //beginRecord(PDF, "canvas.pdf");
}

void draw() {
  background(255,0,0);
  int s = 1;
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      color oldpixel = src.get(x, y);
      color newpixel = findClosestColor( color ( red(oldpixel) + random(-64,64),green(oldpixel) + random(-64,64),blue(oldpixel) + random(-64,64) ) );      
      src.set(x, y, newpixel);
      
      stroke(newpixel);      
      point(x,y);     
    }
  }
  
}


// Find closest colors in palette
color findClosestColor(color in) {

  //Palette colors
  color[] palette = {
    color(0), 
    color(255), 
    color(255, 0, 0), 
    color(0, 255, 0), 
    color(0, 0, 255), 
    color(255, 255, 0), 
    color(0, 255, 255), 
    color(255, 0, 255), 
    color(0, 255, 255),
  };


  PVector[] vpalette = new PVector[palette.length];  
  PVector vcolor = new PVector( (in >> 16 & 0xFF), (in >> 8 & 0xFF), (in & 0xFF));
  int current = 0;
  float distance = vcolor.dist(new PVector(0, 0, 0));

  for (int i=0; i<palette.length; i++) {
    // Using bit shifting in for loop is faster
    int r = (palette[i] >> 16 & 0xFF);
    int g = (palette[i] >> 8 & 0xFF);
    int b = (palette[i] & 0xFF);
    vpalette[i] = new PVector(r, g, b);
    float d = vcolor.dist(vpalette[i]);
    if (d < distance) {
      distance = d;
      current = i;
    }
  }
  return palette[current];
}

