void disp_score(int score){
  fill(0,120);
  rect(-1,-1,config_disp_w+2,config_disp_h+2);
  stroke(255);
  strokeWeight(1);
  fill(0);
  rect(0,config_disp_h/2-50,config_disp_w,70);
  fill(255);
  textSize(50);
  text("score:"+score,config_disp_w/2-textWidth("score:"),config_disp_h/2);
  config_gamemode = -1;
  textSize(50);
  if(config_gameControl == "key&mouse"){
    text("Press 'Q'key",0,config_disp_h-50);
  }else if(config_gameControl == "PS4"){
    text("Press 'O'button",0,config_disp_h-50);
  }
}

int calc_score(){
  int score = 0;
  score += hero.score*100;
  //score += time.timer;
  return score;
}
