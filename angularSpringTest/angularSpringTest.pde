/*
https://github.com/gcorallo/ProcessingExperiments2016
 3D angular spring test.
 
 Modified Euler Integration from 2d angular spring, Golan Levin: 
 http://www.openprocessing.org/sketch/25874
 
 -----
 press spacebar for random Ang displace.
 */


int nRows=30;
int nCols=30;
int nParts = nRows*nCols;
//spring system:
Part[] parts = new Part[nParts];

//Simple attractor.
Attract atr=new Attract();

void setup() {
  size(960, 540, P3D);

  for (int i=0; i<nParts; i++) {
    parts[i]=new Part();
    parts[i].orig=new PVector(random(-200, 200), random(-200, 200), 0);
  }
  rectMode(CENTER);
}



void draw() {

  background(0);
  lights();

  pushMatrix();
  translate(width/2, height/2, 0);

  rotateX(-2*PI/3);
  for (int i=0; i<nParts; i++) {

    //aux: force vector.
    PVector aux = new PVector(parts[i].actual.x-atr.pos.x, 
      parts[i].actual.y-atr.pos.y, 
      parts[i].actual.z-atr.pos.z);   

    aux.normalize();
    float d =parts[i].actual.dist(atr.pos);

    if (d<180) {
      parts[i].active=true;


      //cartesian to spherical.
      float tR = sqrt((aux.x*aux.x)+(aux.y*aux.y)+(aux.z*aux.z));
      float tTheta = acos(aux.z/tR);
      float tPhi = atan(aux.y/aux.z);

      float attenuation =0.15;

      //Angle displacements in spherical coordinartes:
      parts[i].thetaD= tTheta*attenuation;
      parts[i].phiD=tPhi*attenuation;

      //display force vector (inverted in z.)
      aux.normalize();
      aux.mult(30);
      stroke(0, 200, 0);
      line(parts[i].actual.x, parts[i].actual.y, parts[i].actual.z, 
        +parts[i].actual.x+aux.x, parts[i].actual.y+ aux.y, parts[i].actual.z-aux.z);
    } else {
      parts[i].active=false;
    }
    parts[i].update();
  } 

  atr.update();

  popMatrix();
}

void keyPressed() {
  if (key==' ') {

    for (int i=0; i<nParts; i++) {
      parts[i].thetaD= random(-PI/4, PI/4);
      ;
      parts[i].phiD= random(-PI/4, PI/4);
    }
  }
}