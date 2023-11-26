float bezierStep = 0.001f;
BezierCurve bezierCurve;
int pointEdited;

void setup(){
  size(900,700);
  background(210);
  stroke(0);
  gui();
  noFill();
}

void draw(){
  background(210);
  if(bezierCurve!=null){
    bezierCurve.update();
    bezierCurve.display();
  }
}
