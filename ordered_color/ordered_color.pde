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
  src = loadImage("sky.jpg");
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
      color value = color( (oldpixel >> 16 & 0xFF) + (mratio*matrix[x%4][y%4] * mfactor), (oldpixel >> 8 & 0xFF) + (mratio*matrix[x%4][y%4] * mfactor), (oldpixel & 0xFF) + + (mratio*matrix[x%4][y%4] * mfactor) );
      color newpixel = findClosestColor(value);      
      src.set(x, y, newpixel);
      // Draw
      stroke(newpixel);   
      //point(x, y);
      line(x,y,x+s,y+s);
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
  PVector vcolor = new PVector( (in >> 16 & 0xFF) , (in >> 8 & 0xFF), (in & 0xFF));
  int current = 0;
  float distance = vcolor.dist(new PVector(0,0,0));
  
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

