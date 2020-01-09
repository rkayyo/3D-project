int lives;
int flakes;
class Snow {
  float x, y, z, vx, vz, vy, t, vx2, vz2;

  Snow() {
flakes=0;
    x=random(lx-400, lx+400);
    y=-300;
    z=random(lz-400, lz+400);
    vx=random(-1, 1);
    vz=random(-1, 1);
    vx=random(-1, 1);
    vz=random(-1, 1);
    vy=random(1, 2);
    lives=1;
    t=0;
  }
  void show() {
    pushMatrix();
    translate(x, y, z);
    fill(255);
    noStroke();
    box(1); 
    popMatrix();
  }
  void act() {
    t++;
    if (t>=2) {
      vx2=random(-0.1, 0.1);
      vz2=random(-0.1, 0.1);
      t=0;
    }
    if (vx>1)vx=1;
    if (vx<-1)vx=-1;
    if (vz>1)vz=1;
    if (vz<-1)vz=-1;
    vx=vx+vx2;
    vz=vz+vz2;
    x=x +vx;
    z=z+vz;
    y=y+vy;
    flakes++;

    if(flakes>=2000){
     lives=0; 
    }
  }
}  
void handleSnow() {
  int i=0;
  while (i<snowList.size()) {
    Snow s = snowList.get(i);

    s.show();

    if (s.y<-26.5) {
      s.act();
      // snows.remove(i);
    } else {

      if (map.get(int(s.x+25)/50, int(s.z+25)/50) == white||s.z<-20||s.x>2475||s.z>2475||s.x<-20) {
        snowList.remove(i);

      }
      if (lives==0){
        snowList.remove(i);
      }
    }




    i++;
  }
}
