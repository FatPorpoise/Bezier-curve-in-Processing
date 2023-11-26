class BezierCurve{
  int leadPointNum, currentPoint;
  float[][] leadPoints;
  ArrayList<float[]> curvePoints;
  float[] lastPoint;
  boolean editable;
  int[] binomialTable;
  BezierCurve(int _leadPointNum){
    curvePoints = new ArrayList<float[]>();
    leadPointNum = _leadPointNum;
    leadPoints = new float[_leadPointNum][2];
    currentPoint = 0;
    lastPoint = new float[2];
    editable = false;
  }
  BezierCurve(float[][] _leadPoints){
    leadPoints = _leadPoints;
    leadPointNum = leadPoints.length;
    currentPoint = leadPointNum;
    editable = true;
    calcPoints();
  }
  boolean addPoint(float x, float y){
    if(currentPoint>=leadPointNum)
      return false;
    if(currentPoint==0){
      leadPoints[0][0] = x;
      leadPoints[0][1] = y;
    }
    else if(currentPoint==1){
      lastPoint[0] = x;
      lastPoint[1] = y;
      leadPoints[1][0] = x;
      leadPoints[1][1] = y;
    }else{
      leadPoints[currentPoint-1][0]=x;
      leadPoints[currentPoint-1][1]=y;
      leadPoints[currentPoint][0]=lastPoint[0];
      leadPoints[currentPoint][1]=lastPoint[1];
    }
    currentPoint++;
    if(currentPoint>2)
      calcPoints();
    return true;
  }
  void calcPoints(){
    curvePoints = new ArrayList<float[]>();
    curvePoints.add(leadPoints[0]);
    for(float t = 0; t<1.0; t+=bezierStep){
      float x = 0, y = 0;
      for(int k = 0; k < currentPoint;k++){
        
        float multiplier = BinomialCoefficient.get(currentPoint-1, k)*pow(1-t,currentPoint-1-k)*pow(t,k);
        x += multiplier*leadPoints[k][0];
        y += multiplier*leadPoints[k][1];
      }
      curvePoints.add(new float[]{x,y});
    }
    curvePoints.add(leadPoints[currentPoint-1]);
  }
  void display(){
    for (int i=0;i<currentPoint;i++){
      circle(leadPoints[i][0],leadPoints[i][1],10);
    }
    beginShape();
    for(float[] point : curvePoints)
    vertex(point[0], point[1]);
    endShape();
  }
  void update(){
    if(mousePressed==true){
      boolean changeOccured = false;
      for (int i=0;i<currentPoint;i++){
        if(abs(pmouseX-leadPoints[i][0])*abs(pmouseX-leadPoints[i][0])+abs(pmouseY-leadPoints[i][1])*abs(pmouseY-leadPoints[i][1])<=100){
          leadPoints[i][0] = mouseX;
          leadPoints[i][1] = mouseY;
          changeOccured = true;
          break;
        }
      }
      if(changeOccured && currentPoint>2)
          calcPoints();
    }
  }
}
