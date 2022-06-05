boolean check_collision(float x1,float y1,float r1,float x2,float y2,float r2){
  if(sqrt(sq(x1-x2) + sq(y1-y2)) < r1 + r2){
    return true;
  }else{
    return false;
  }
}
