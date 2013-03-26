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
      color newpixel = findClosestColor(oldpixel);
      float quant_error = brightness(oldpixel) - brightness(newpixel);
      src.set(x, y, newpixel);

      src.set(x+s, y, color(brightness(src.get(x+s, y)) + 7.0/16 * quant_error) );
      src.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 3.0/16 * quant_error) );
      src.set(x, y+s, color(brightness(src.get(x, y+s)) + 5.0/16 * quant_error) );
      src.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/16 * quant_error));

      
      stroke(newpixel);      
      point(x,y);
      
    }
  }
  
}


color findClosestColor(color c) {
  color r;

  if (brightness(c) < 128) {
    r = color(0);
  }
  else {
    r = color(255);
  }
  return r;
}

