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
  // Init canvas
  background(0,0,0);
  // Define step
  int s = 4;
  
  // Scan image
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      // Calculate pixel
      color oldpixel = src.get(x, y);
      color newpixel = findClosestColor(oldpixel);
      float quant_error = brightness(oldpixel) - brightness(newpixel);
      src.set(x, y, newpixel);
      
      // Atkinson algorithm http://verlagmartinkoch.at/software/dither/index.html
      src.set(x+s, y, color(brightness(src.get(x+s, y)) + 1.0/8 * quant_error) );
      src.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 1.0/8 * quant_error) );
      src.set(x, y+s, color(brightness(src.get(x, y+s)) + 1.0/8 * quant_error) );
      src.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/8 * quant_error));
      src.set(x+2*s, y, color(brightness(src.get(x+2*s, y)) + 1.0/8 * quant_error));
      src.set(x, y+2*s, color(brightness(src.get(x, y+2*s)) + 1.0/8 * quant_error));
      
      // Draw
      stroke(newpixel);   
      point(x,y);
      
    }
  }
  
}

// Threshold function
color findClosestColor(color in) {  
  color out;
  if (brightness(in) < 128) {
    out = color(0);
  }
  else {
    out = color(255);
  }
  return out;
}


