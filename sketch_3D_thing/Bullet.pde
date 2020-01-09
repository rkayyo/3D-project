class Bullet{
  int size;
  float vx,vz;
  PVector location;
  PVector velocity;
  public Bullet(float _x, float _y, float _z, float _vx, float _vz ){
    location = new PVector(_x,_y,_z);
    velocity = new PVector(_vx,_vz);
    
    
    
  }
  
  void act(){
    location.x = location.x + velocity.x;
    location.z = location.z + velocity.y;
    
  }
  
  void show(){
    pushMatrix();
    translate(location.x,location.y,location.z);
    fill(#FF0000);
    box(15);
    popMatrix();
    
    
      
      
      
      
    
    
    
    
  }
  
  
  
}
