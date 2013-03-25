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
      color newpixel = findClosestColor( color(brightness(oldpixel) + random(-64,64)) );      
      src.set(x, y, newpixel);
      
      
      stroke(newpixel);      
      //rect(x, y, s, s);
      //line(x, y, x+s, y+s);
      
      point(x,y);
      //set(x, y, newpixel);
    }
  }
  //image(src, 0, 0, width, height);
  //endRecord();
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
//*/

/*
color findClosestColor(color c) {
 color r;
 color[] palette = new color[16];
 palette[0] = color(0);
 palette[1] = color(255);
 palette[2] = color(255,0,0);
 palette[3] = color(0,255,0);
 palette[4] = color(0,0,255);
 palette[5] = color(255,255,0);
 palette[6] = color(0,255,255);
 palette[7] = color(255,0,255);
 palette[8] = color(0,255,255);
 
 float diff = 999;
 int i = 0;
 int f = 0;
 for(color p : palette){
 if (diff >= abs(c - p) )
 {
 diff = abs(c - p);
 f=i;
 }
 i++;   
 }
 return palette[f];
 }
 //*/
