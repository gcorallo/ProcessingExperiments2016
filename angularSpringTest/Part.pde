class Part {
  PVector restPos;
  PVector orig;
  PVector pos;
  PVector actual;
  float theta=PI/2;
  float phi=-0;
  float r=100;

  float damp = 0.95;
  float k = 0.1;
  float mass = 1.0;
  float thetaRest=0; 
  float thetaD=0;
  float phiD=0;
  float thetaVel=0;
  float phiVel=0;
  float thetaForce;
  float phiForce;
  float thetaAccel;
  float phiAccel;

  boolean active=false;

  Part() {


    pos= new PVector(0, 0, 0);
    actual= new PVector(0, 0, 0);
  }

  void update() {
    thetaForce = 0 - k*thetaD;
    thetaAccel = thetaForce/mass;

    phiForce = 0 - k*phiD;
    phiAccel = phiForce/mass;

    thetaVel += thetaAccel;
    phiVel += phiAccel;
    thetaVel *= damp;
    phiVel *= damp;

    thetaD += thetaVel;
    phiD += phiVel;

    //spherical to cartesian conversion
    pos.x=r*sin(theta+thetaD)*cos(phi+phiD); 
    pos.y=r*sin(theta+thetaD)*sin(phi+phiD);
    pos.z=r*cos(theta+thetaD);


    pushMatrix();
    translate(orig.x, orig.y, orig.z);

    //small hack:
    rotateY(PI/2);

    fill(255);
    stroke(255, 150);
    line(0, 0, 0, pos.x, pos.y, pos.z);

    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(PI/2);

    if (active) {
      fill(230, 230, 0);
    } else {
      fill(200);
    }
    rect(0, 0, 15, 15);
    popMatrix();
    popMatrix();



    //small hack again.   
    PVector aux1 = new PVector(0, 0, 0);
    aux1.z = pos.z*cos(PI/2) - pos.x*sin(PI/2);
    aux1.x = pos.z*sin(PI/2) - pos.x*cos(PI/2);
    aux1.y = pos.y;

    //absolute position.
    actual.set(orig.x + aux1.x, orig.y + aux1.y, orig.z + aux1.z);
  }
}