
float[][] heightMap;

int w = 1920;
int h = 1080;

void setup() {
  size(1920, 1080);
  heightMap = new float[h][w];
  generateMap(noiseZ);
  println("Done");
}

void generateMap(float z){
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      heightMap[y][x] = noise((float)x/200, (float)y/100, z) * 255 + x/20 - 100 + y / 10;
    }
  }
}

int chunkX = 0;
int chunkY = 0;
int factor = 120;
float noiseZ = 240;
float frames = 400;

boolean stopped = false;

void draw() {
  for (int i = 0; i < 1; i++) {
    if (stopped) return;
    if (chunkX == w/factor) {
      chunkX = 0;
      chunkY++;
    }
    if (chunkY == h/factor) {
      /*save("frame" + noiseZ + ".png");
      if(noiseZ == frames){
        stopped = true;
      }else{
        chunkX = 0;
        chunkY = 0;
        noiseZ ++;
        generateMap(noiseZ/100);
      }*/
      stopped=true;
    } else {
      //println(chunkX, chunkY);
      renderChunk(chunkX * factor, chunkY * factor, factor);
      chunkX++;
    }
  }
}

void renderChunk(int xPos, int yPos, int chunkSize) {
  for (int py = yPos; py < yPos + chunkSize; py++) { //pixel y
    for (int px = xPos; px < xPos + chunkSize; px++) { //pixel x
      int y = h - 1;
      int z = h - py;
      while (y > 0 && heightMap[y][px] < z) {
        z--;
        y--;
      }
      int preY = y;
      int thiccness = 1;
      while (heightMap[y][px] > z) {
        y--;
        thiccness++;
        if (y < 0) {
          thiccness = 255;
          break;
        }
      }
      //float darkness = min(1, (float)preY/600 + 0.5);
      stroke(preY, z * 1.2, max(127, 255 - thiccness*10));
      point(px, py);
    }
  }
}
