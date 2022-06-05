class label{
  int menu_pointer;
  int sub_pointer;
  button[][] button;
  
  label(int _menu_pointer,button[][] _button){
    set(_menu_pointer,_button);
  }
  
  void set(int _menu_pointer,button[][] _button){
    sub_pointer = 1;
    menu_pointer = _menu_pointer;
    button = _button;
  }
  
  void menu_up(){
    if(menu_pointer < button.length-1){
      menu_pointer++;
    }
    if(sub_pointer > 2){
      sub_pointer = 2;
      
    }
  }
  
  void menu_down(){
    if(0 < menu_pointer){
      menu_pointer--;
    }
  }
  
  void sub_up(){
    if(menu_pointer == 0){
      if(sub_pointer < 4)sub_pointer++;
    }else if(menu_pointer == 1){
      if(sub_pointer < 2)sub_pointer++;
    }else if(menu_pointer == 2){
      if(sub_pointer < 2)sub_pointer++;
    }else if(menu_pointer == 3){
      if(sub_pointer < 2)sub_pointer++;
    }
  }
  
  void sub_down(){
    if(1 < sub_pointer){
      sub_pointer--;
    }
  }
  
  void clicked(){
    button[menu_pointer][sub_pointer].click(true);
  }
  
  void correct_wh(){
    for(int i = 0 ; i < button.length ; i++){
      for(int j = 0 ; j < button[0].length ; j++){
        if(menu_pointer == i){
          button[i][j].w = 100;
          button[i][j].h = 100;
        }else if(abs(menu_pointer - i) == 1){
          button[i][j].w = 80;
          button[i][j].h = 80;
        }else if(abs(menu_pointer - i) == 2){
          button[i][j].w = 50;
          button[i][j].h = 50;
        }
      }
    }
  }
  
  void correct_xy(){
    for(int i = 0 ; i < button.length ; i++){
      for(int j = 0 ; j < button[0].length ; j++){
        button[i][j].x = 200*(j+1);
        button[i][0].x = 100;
        //button[i][j].y = config_disp_h/2-50 + 200*(i-menu_pointer);
        if(menu_pointer == i){
          button[i][j].y = config_disp_h/2-50 + 200*(i-menu_pointer);
        }else if(abs(menu_pointer - i) == 1){
          button[i][j].y = config_disp_h/2-50 + 180*(i-menu_pointer);
        }else if(abs(menu_pointer - i) == 2){
          button[i][j].y = config_disp_h/2-50 + 150*(i-menu_pointer);
        }else{
          button[i][j].y = -150;
        }
      }
    }
  }
  
  void disp(){
    for(int i = 0 ; i < button.length ; i++){
      for(int j = 0 ; j < button[0].length ; j++){
        button[i][j].pointer = false;
      }
    }
    correct_wh();
    correct_xy();
    fill(0,120);
    rect(0,0,300,config_disp_h);
    for(int i = 0 ; i < button.length ; i++){
      for(int j = 0 ; j < button[0].length ; j++){
        if(menu_pointer==i && sub_pointer==j){
          button[i][j].pointer = true;
        }
      }
      if(menu_pointer == i){
        button[i][0].pointer = true;
      }
    }
    
    for(int i = 0 ; i < button.length ; i++){
      for(int j = 0 ; j < button[0].length ; j++){
        button[i][j].disp();
      }
    }
    
    fill(0);
    textSize(20);
    text("FPS:"+config_fps,config_disp_w-300,config_disp_h-30);
    text("GAME CONTROL:"+config_gameControl,config_disp_w-300,config_disp_h-50);
    text("SENSITIVITY:"+ps4.sensitivity,config_disp_w-300,config_disp_h-70);
  }
}
