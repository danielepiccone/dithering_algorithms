PImage src;
PImage res;

void setup() {
  src = loadImage("medusa.jpg");  
  res = createImage(src.width, src.height, RGB);
  float scale = 1;
  src.resize((int)(scale*src.width), (int)(scale*src.height));
  size(src.width, src.height, JAVA2D);

  //smooth();
  noLoop();
  noStroke();
  noSmooth(); 
  //beginRecord(PDF, "canvas.pdf");
}

void draw() {  
  // Init canvas
  background(0, 0, 0);
  // Define step
  int s = 1;

  // Scan image
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      color oldpixel = src.get(x, y);
      color newpixel = findClosestColor(oldpixel);
      color quant_error = color(red(oldpixel) - red(newpixel), green(oldpixel) - green(newpixel), blue(oldpixel) - blue(newpixel));
      src.set(x, y, newpixel);

      //Floys Steinberg
      color s1 = src.get(x+s, y);
      src.set(x+s, y, color( red(s1) + 7.0/16 * red(quant_error), green(s1) + 7.0/16 * green(quant_error), blue(s1) + 7.0/16 * blue(quant_error) ));
      color s2 = src.get(x-s, y+s);
      src.set(x-s, y+s, color( red(s2) + 3.0/16 * red(quant_error), green(s2) + 3.0/16 * green(quant_error), blue(s2) + 3.0/16 * blue(quant_error) ));
      color s3 = src.get(x, y+s);
      src.set(x, y+s, color( red(s3) + 5.0/16 * red(quant_error), green(s3) + 5.0/16 * green(quant_error), blue(s3) + 5.0/16 * blue(quant_error) ));
      color s4 = src.get(x+s, y+s);
      src.set(x+s, y+s, color( red(s4) + 1.0/16 * red(quant_error), green(s4) + 1.0/16 * green(quant_error), blue(s4) + 1.0/16 * blue(quant_error) ));

      stroke(newpixel); 
      point(x, y);
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

