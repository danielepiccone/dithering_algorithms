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
  int s = 1;
  
  // Scan image
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      // Calculate pixel
      color oldpixel = src.get(x, y);
      color newpixel = findClosestColor(oldpixel);
      color quant_error = color(red(oldpixel) - red(newpixel), green(oldpixel) - green(newpixel), blue(oldpixel) - blue(newpixel));
      src.set(x, y, newpixel);
      
      // Atkinson algorithm http://verlagmartinkoch.at/software/dither/index.html
      color s1 = src.get(x+s, y);
      src.set(x+s, y, color( red(s1) + 1.0/8 * red(quant_error), green(s1) + 1.0/8 * green(quant_error), blue(s1) + 1.0/8 * blue(quant_error) ));      
      color s2 = src.get(x-s, y+s);
      src.set(x-s, y+s, color( red(s2) + 1.0/8 * red(quant_error), green(s2) + 1.0/8 * green(quant_error), blue(s2) + 1.0/8 * blue(quant_error) ));      
      color s3 = src.get(x, y+s);
      src.set(x, y+s, color( red(s3) + 1.0/8 * red(quant_error), green(s3) + 1.0/8 * green(quant_error), blue(s3) + 1.0/8 * blue(quant_error) ));      
      color s4 = src.get(x+s, y+s);
      src.set(x+s, y+s, color( red(s4) + 1.0/8 * red(quant_error), green(s4) + 1.0/8 * green(quant_error), blue(s4) + 1.0/8 * blue(quant_error) ));      
      color s5 = src.get(x+2*s, y);
      src.set(x+2*s, y, color( red(s5) + 1.0/8 * red(quant_error), green(s5) + 1.0/8 * green(quant_error), blue(s5) + 1.0/8 * blue(quant_error) ));      
      color s6 = src.get(x, y+2*s);
      src.set(x, y+2*s, color( red(s6) + 1.0/8 * red(quant_error), green(s6) + 1.0/8 * green(quant_error), blue(s6) + 1.0/8 * blue(quant_error) ));
      
      // Draw
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


