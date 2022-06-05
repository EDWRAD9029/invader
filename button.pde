class button{
  boolean pointer;
  int x,y;
  int w,h;
  int type;
  String c;
  int func;
  int time_over;
  int time0 = 60;
  int time_clicked;
  int time_c = 60;
  button(){
    reset();
  }
  
  void reset(){
    set(0,0,0,0,-1,"",-1);
  }
  
  void set(int _x,int _y,int _w,int _h,int _type,String _c,int _func){
    pointer = false;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    type = _type;
    c = _c;
    func = _func;
    time_clicked = 0;
    time_over = 0;
  }
  
  void click(boolean _s_){
    boolean s = _s_;
    if((mousePressed&&time_clicked==0) || s){
      if(func == 1){
        config_mode = 2;
        config_gamemode = 1;
        time.reset();
        hero.set(config_disp_w/2,config_disp_h - 100,config_hero_r,config_hero_hpmax,config_hero_hpmax);
        create_enemy(0,config_num_enemy);
      }else if(func == 2){
        config_mode = 2;
        config_gamemode = 2;
        time.reset();
        hero.set(config_disp_w/2,config_disp_h - 100,config_hero_r,config_hero_hpmax,config_hero_hpmax);
        create_enemy(0,config_num_enemy);
      }else if(func == 3){
        config_mode = 2;
        config_gamemode = 3;
        time.reset();
        hero.set(config_disp_w/2,config_disp_h - 100,config_hero_r,config_hero_hpmax,config_hero_hpmax);
        create_enemy(0,config_num_enemy);
      }else if(func == 4){
        config_mode = 2;
        config_gamemode = 4;
        time.reset();
        hero.set(config_disp_w/2,config_disp_h - 100,config_hero_r,config_hero_hpmax,config_hero_hpmax);
        create_enemy(0,config_num_enemy);
      }else if(func == 11){
        if(config_fps != 60){
          change_fps(config_fps+1);
        }
      }else if(func == 12){
        if(config_fps != 10){
          change_fps(config_fps-1);
        }
      }else if(func == 21){
        if(ps4.IsAvailable()){
          hero.x = config_disp_w/2;
          hero.y = config_disp_h - 100;
          ps4.OnOff = false;
          config_gameControl = "key&mouse";
          button[0][1].x = 100;
          button[0][1].y = 100;
          button[0][2].x = 300;
          button[0][2].y = 100;
          button[0][3].x = 500;
          button[0][3].y = 100;
          button[0][4].x = 700;
          button[0][4].y = 100;
          button[1][1].x = 100;
          button[1][1].y = 300;
          button[1][2].x = 100;
          button[1][2].y = 500;
          button[2][1].x = 300;
          button[2][1].y = 300;
          button[2][2].x = 300;
          button[2][2].y = 500;
          for(int i = 0 ; i < button.length ; i++){
            for(int j = 0 ; j < button[0].length ; j++){
              button[i][j].w = 100;
              button[i][j].h = 100;
            }
          }
        }
      }else if(func == 22){
        ps4.set();
        if(ps4.IsAvailable()){
          config_gameControl = "PS4";
        }
      }else if(func == 31){
        ps4.sensitivityUp();
      }else if(func == 32){
        ps4.sensitivityDown();
      }
      time_clicked = time_c;
    }
  }
  
  void mouseover(boolean _s_){
    boolean s = _s_;
    if(type == 0){
      if(x < mouseX && mouseX < x+w){
        if(y < mouseY && mouseY < y+h){
          if(config_gameControl == "key&mouse"){
            s = true;
            click(false);
          }
        }
      }
    }
    
    if(s){
      time_over += int(60/config_fps);
      if(time_over > time0){
        time_over = time0;
      }
    }else{
      time_over -= int(60/config_fps);
      if(time_over < 0){
        time_over = 0;
      }
    }
    time_clicked -= int(60/config_fps);
    if(time_clicked <= 0){
      time_clicked = 0;
    }
  }
  
  void mouseover(int n,boolean _s_){
    for(int i = 0 ; i < n; i++){
      mouseover(_s_);
    }
  }
  
  void disp(){
    if(type == 0){
      if(!ps4.IsAvailable()){
        mouseover(10,false);
      }else{
        if(pointer){
          mouseover(20,true);
        }else{
          mouseover(10,false);
        }
      }
      float dw = 0.1*w*sqrt(time_over/float(time0));
      float dh = 0.1*h*sqrt(time_over/float(time0));
      stroke(0);
      strokeWeight(1);
      fill(0);
      rect(x-dw,y-dh,w+2*dw,h+2*dh);
      fill(255);
      rect(x,y,w,h);
      fill(0);
      rect(x+w*0.1,y+h*0.1,w*0.8,h*0.8);
      fill(255,0,0);
      int tS = int(h*0.8);
      textSize(tS);
      while(textWidth(c) > w*0.8){
        tS--;
        textSize(tS);
      }
      text(c,x+w*0.1,y+h/2+tS/2);
    }
  }
}
