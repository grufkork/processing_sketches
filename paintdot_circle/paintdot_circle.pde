

void setup() {
  size(400, 400);
  noStroke();
  colorMode(HSB, 100);

  /*droplets[0][0] = width/2;
   droplets[0][1] = height/2;
   droplets[0][2] = 20;*/
}

float[][] droplets = new float[10000][3];
int dropletCount = 0;

float centreBlobRadius = 50.0f;
float centreBlobCircumference = PI * centreBlobRadius * centreBlobRadius;

void draw() {
  background(100, 0, 100);


  for (int i = 1; i < dropletCount; i++) {
    float xVel = 0;
    float yVel = 0;
    if (frameCount < 200) {
      for (int n = 0; n < dropletCount; n++) {
        if (n != i) {
          float angle = atan2((droplets[i][1] - droplets[n][1]), (droplets[i][0] - droplets[n][0]));
          float distance = (sqrt(pow(droplets[n][0] - droplets[i][0], 2) + pow(droplets[n][1] - droplets[i][1], 2)));
          //if(distance > 100f) continue;
          //float effect = 1.0f / (pow(distance, 2f) * 20 ) * pow(droplets[i][2] * droplets[i][2] + droplets[n][2] * droplets[n][2], 1f);
          float effect = min(1.0f / pow(distance / (pow((droplets[i][2] + droplets[n][2] / 2.0f), 1.1f)) / 0.1f, 2) * 10.0f, 5.0f);
          xVel += cos(angle) * effect;
          yVel += sin(angle) * effect;
        }
      }
    }

    /*float magnitude = sqrt(xVel * xVel + yVel * yVel);
     float dragFactor = pow(magnitude, 0.1f);
     xVel *= dragFactor;
     yVel *= dragFactor;*/

    float angleToCenter = atan2((droplets[i][1] - width / 2f), (droplets[i][0] - height / 2.0f));
    float distanceToCenter = min(1.0f / pow(sqrt(pow(width / 2f - droplets[i][0], 2) + pow(height / 2f - droplets[i][1], 2)), 1.5f) * 200, 1.0f);
    if (frameCount > 200) distanceToCenter = max(1.0f / (sqrt(pow(width / 2f - droplets[i][0], 2) + pow(height / 2f - droplets[i][1], 2))*10.0f), 0.0f) * -3;
    xVel += cos(angleToCenter) * distanceToCenter;
    yVel += sin(angleToCenter) * distanceToCenter;

    droplets[i][0] += xVel;
    droplets[i][1] += yVel;

    float distanceFactor = sqrt(pow(droplets[i][0] - width / 2, 2) + pow(droplets[i][1] - height / 2, 2)) / height * 4;
    fill(210.0f/360.0f*100.0f, lerp(20, 100, distanceFactor), lerp(100, 50, distanceFactor));
    ellipse(droplets[i][0], droplets[i][1], droplets[i][2], droplets[i][2]);
  }

  ellipse(width/2, height/2, 110, 110);

  /*for (int i = 0; i < 30; i++) {
   if (random(0, 1) > pow(frameCount/150f, 0.4f)) {
   float angle = random(0, PI*2);
   droplets[dropletCount][0] = width / 2.0f + cos(angle) * 50f;
   droplets[dropletCount][1] = height / 2.0f + sin(angle) * 50f;
   //droplets[dropletCount][0] = random(-10.0f, 10.0f) + width/2f;
   //droplets[dropletCount][1] = random(-10.0f, 10.0f) + height/2f;
   droplets[dropletCount][2] = frameCount / 40f + 0.3f;
   dropletCount ++;
   }
   }*/

  float particleRadius = frameCount / 5f + 1f;
  if (frameCount < 150) {
    for (float angle = 0; angle < PI * 2; angle += (particleRadius * particleRadius * 5) / centreBlobCircumference * 2.0f * PI) {
      if (random(0, 1) > 0.9f) {
        droplets[dropletCount][0] = width / 2.0f + cos(angle) * centreBlobRadius;
        droplets[dropletCount][1] = height / 2.0f + sin(angle) * centreBlobRadius;
        droplets[dropletCount][2] = particleRadius;
        dropletCount ++;
      }
    }
  }

  if (frameCount%10==0) {
    println(frameCount);
  }

  //saveFrame();
}
