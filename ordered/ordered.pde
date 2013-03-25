PImage src;
PImage res;

// Bayer matrix
int[][] matrix = {   
  {
    1, 9, 3, 11
  }
  , 
  {
    13, 5, 15, 7
  }
  , 
  {
    4, 12, 2, 10
  }
  , 
  {
    16, 8, 14, 6
  }
};

float mratio = 1.0 / 17;
float mfactor = 255.0 / 5;

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
  background(0, 0, 0);
  // Define step
  int s = 1;

  // Scan image
  for (int x = 0; x < src.width; x+=s) {
    for (int y = 0; y < src.height; y+=s) {
      // Calculate pixel
      color oldpixel = src.get(x, y);
      color value = color( brightness(oldpixel) + (mratio*matrix[x%4][y%4] * mfactor));
      color newpixel = findClosestColor(value);
      
      src.set(x, y, newpixel);


      // Draw
      stroke(newpixel);   
      point(x, y);
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

