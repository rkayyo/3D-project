//keyboard interaction
boolean up, down, left, right,space;

//World manipulation
int bs = 100;

//camera variables
float lx = 2500, ly = height/2 - bs/2, lz = 2500;
PVector direction = new PVector(0, -10);
PVector strafeDir = new PVector(10, 0);
float headAngle = 0;


//color pallette
color black = #000000;
color white = #FFFFFF;

PImage map;

//textures
PImage qblock, dT, dS, dB;

ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
ArrayList<Snow> snowList = new ArrayList<Snow>();


void setup() {
  size(800, 600, P3D);

  //load textures
  qblock = loadImage("qblock.png");
  dT     = loadImage("dirt_top.png");
  dS     = loadImage("dirt_side.jpg");
  dB     = loadImage("dirt_bottom.jpg");
  textureMode(NORMAL);

  //load map
  map         = loadImage("map.png");
}

void draw() {
  
  background(0);

  camera(lx,ly,lz,   direction.x+lx, ly+0, direction.y+lz,   0, 1, 0); 
  direction.rotate(headAngle);
  headAngle = -(pmouseX - mouseX) * 0.01;
  //headAngle = headAngle + 0.01;

  strafeDir = direction.copy();
  strafeDir.rotate(PI/2);

  if (up) {   
    lx = lx + direction.x;
    lz = lz + direction.y;
  }
  if (down) {
    lz = lz - 10;
  }
  if (left) {
    lx = lx - strafeDir.x;
    lz = lz - strafeDir.y;
  }
  if (right) { 
    lx = lx + strafeDir.x;
    lz = lz + strafeDir.y;
  }
  if (space){
    bulletList.add(new Bullet(lx,ly,lz,direction.x,direction.y));
    
  }
  
  for(int i = 0; i < bulletList.size(); i++){
    Bullet bullet = bulletList.get(i);
    bullet.show();
    bullet.act();
  }
  
  for(int j =0; j < snowList.size(); j++){
    Snow snow = snowList.get(j);
    snow.show();
    snow.act();
  }
  int x=0;
while(x<=3){
snowList.add(new Snow());
x++;
}
  
  
  //direction.rotate(-(pmouseX - mouseX) * 0.01);

  drawMap();
  drawFloor();  

}

void drawFloor() {
  int x = 0;
  int y = 0 + bs/2;
  stroke(100);
  strokeWeight(1);
  while (x < map.width*bs) {
    line(x, y, 0, x, y, map.height*bs);
    x = x + bs;
  }

  int z = 0;
  while (z < map.height*bs) {
    line(0, y, z, map.width*bs, y, z);
    z = z + bs;
  }

  noStroke();
}



void drawMap() {
  int mapX = 0, mapY = 0;
  int worldX = 0, worldZ = 0;

  while ( mapY < map.height ) {
    //read in a pixel
    color pixel = map.get(mapX, mapY);

    worldX = mapX * bs;
    worldZ = mapY * bs;

    if (pixel == black) {
      texturedBox(dT, dS, dB, worldX, 0, worldZ, bs/2);
    }


    mapX++;
    if (mapX > map.width) {
      mapX = 0; //go back to the start of the row
      mapY++;   //go down to the next row
    }
  }
}

void texturedBox(PImage top, PImage side, PImage bottom, float x, float y, float z, float size) {
  pushMatrix();
  translate(x, y, z);
  scale(size);

  //rotateX(rotx);
  //rotateY(roty);

  beginShape(QUADS);
  noStroke();
  texture(side);

  // +Z Front Face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z Back Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // +X Side Face
  vertex(1, -1, 1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(1, 1, 1, 0, 1);

  // -X Side Face
  vertex(-1, -1, 1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(bottom);

  // +Y Bottom Face
  vertex(-1, 1, -1, 0, 0);
  vertex( 1, 1, -1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(top);

  // -Y Top Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  endShape();

  popMatrix();
}

void keyPressed() {
  if (key == 'w' ||  key == 'W')    up = true;
  if (key == 's' || key == 'S')  down = true;
  if (key == 'a' || key == 'A')  left = true;
  if (key == 'd' || key == 'D') right = true;
  if (key == ' ') space = true;
  
}

void keyReleased() {
  if (key == 'w' ||  key == 'W')  up = false;
  if (key == 's' || key == 'S')  down = false;
  if (key == 'a' || key == 'A')  left = false;
  if (key == 'd' || key == 'D') right = false;
  if (key == ' ') space = false;
}

void mouseDragged() {
  
  
//  rotx = rotx + (pmouseY - mouseY) * 0.01;
//  roty = roty - (pmouseX - mouseX) * 0.01;
}
