void new_curve(){
  newButton.setVisible(false);
  pointNumField.setVisible(true);
  pointNumField.setFocus(true);
}

void number_of_points(String value){
  int pointNum = isPosInteger(value);
  if (pointNum>0){
    bezierCurve = new BezierCurve(pointNum);
  }
  pointNumField.setFocus(false);
  pointNumField.setVisible(false);
  newButton.setVisible(true);
}

int isPosInteger(String s) {
  try {
    int parsed = Integer.parseInt(s);
    if(parsed>0)
    return parsed;
    else
    return 0;
  } catch (NumberFormatException e) {
    return 0;
  }
}

void mousePressed()
{
  if(mouseButton == LEFT){
    if(bezierCurve != null){
      bezierCurve.addPoint(mouseX,mouseY);
    }
  }
}
