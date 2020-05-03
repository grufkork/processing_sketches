
void setup() {
  size(800, 800);
  noStroke();
}

int distance = 20;

void draw() {
  background(255, 200, 50);
  for (int x = 0; x <= width; x+= distance) {
    for (int y = 0; y <= height; y+= distance) {
      float siz = distance * sin(frameCount/20.0f + x/2.0f + y/8.0f) + 5;
      rect(x - siz/2, y - siz/2, siz, siz, 2);
    }
  }
  if(frameCount/20.0f < 2*PI){
    saveFrame();
  }
}
