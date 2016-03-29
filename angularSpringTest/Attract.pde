class Attract{
  PVector pos;
  PVector vel;
  Attract(){
    pos = new PVector(-350,0,-150);
    vel = new PVector(2,0,0);
  }

  void update(){
    if(pos.x>300){
      pos.x=-350;
    }
    pos.add(vel);
    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    noStroke();
    fill(200,0,0,200);
    sphere(20);
    popMatrix();
  }
  

}