class check{
  boolean time_p_s;
  int time_p;
  int frameCount_p;
  byte fps_p;
  double delay_time;
  check(){
    time_p_s = true;
    update();
    delay_time = 0;
  }
  
  void update(){
    if(time_p_s){
      time_p = millis()+ 1000*second() + 60*1000*minute() + 60*60*1000*hour();
      frameCount_p = frameCount;
      fps_p = config_fps;
      time_p_s = false;
    }
  }
  
  void delay(){
    int time = millis()+ 1000*second() + 60*1000*minute() + 60*60*1000*hour();
    if(abs(time - time_p) < 100000){
      if(config_fps == fps_p){
        double time_f = 1000*(frameCount - frameCount_p)/config_fps;
        double time_d = time - time_p;
        delay_time = (time_d - time_f)/1000;
        delay_time /= (frameCount - frameCount_p);
        time_p_s = true;
      }else{
        delay_time = 0;
      }
    }else{
      delay_time = 0;
    }
    
    textSize(20);
    text("delay:"+delay_time,config_disp_w-textWidth("delay:0.001[sec/frame]"),config_disp_h-30);
    text("[sec/frame]",config_disp_w-textWidth("[sec/frame]"),config_disp_h-30);
  }
  
  void game(){
    if(cnt_type(0) < 10){
      warn(0,cnt_type(0),cnt_type(1),cnt_type(2),cnt_type(3));
    }
    if(check.delay_time < 1.0){
      if(check.delay_time > 0.1){
        warn(1);
      }
    }
    if(hero.Lv > 18000 || hero.score < 0){
      warn(2);
    }
    
    if(config_enemy_hp.length != config_enemy_r.length){
      stop_game(0,config_enemy_hp.length,config_enemy_r.length);
    }else if(config_enemy_hp.length != config_enemy_damage.length){
      stop_game(1,config_enemy_hp.length,config_enemy_damage.length);
    }else if(config_enemy_hp.length != config_enemy_score.length){
      stop_game(2,config_enemy_hp.length,config_enemy_score.length);
    }else if(config_enemy_hp.length != config_enemy_vx_range.length){
      stop_game(3,config_enemy_hp.length,config_enemy_vx_range.length);
    }else if(config_enemy_hp.length != config_enemy_vy_range.length){
      stop_game(4,config_enemy_hp.length,config_enemy_vy_range.length);
    }else if(config_enemy_hp.length != config_enemy_ax_range.length){
      stop_game(5,config_enemy_hp.length,config_enemy_ax_range.length);
    }else if(config_enemy_hp.length != config_enemy_ay_range.length){
      stop_game(6,config_enemy_hp.length,config_enemy_ay_range.length);
    }else if(config_enemy_hp.length != config_enemy_color_fill.length){
      stop_game(7,config_enemy_hp.length,config_enemy_color_fill.length);
    }else if(config_hero_time_attack <= config_hero_attack_keep){
      stop_game(8,config_hero_time_attack,config_hero_attack_keep);
    }
  }
}

void warn(int warn_number,int n1,int n2,int n3,int n4){
   print("-----------------------------------------------------\n");
  if(warn_number == 0){
    print("|      warning:cnt_type(0) = " + n1 + "\n");
    print("|   type(0) = " + n1 + "; type(1) = " + n2 + "; type(2)" + n3 + "; type(3) = " + n4 + ";\n");
  }else if(warn_number == 1){
    print("|      warning:game delay\n");
    print("|         processing failure\n");
  }else if(warn_number == 2){
    print("|      warning:hero.Lv too big\n");
    print("|         Lv_max=18274\n");
  }else{
    print("|      warning:unexpected\n");
  }
  print("-----------------------------------------------------\n");
}

void warn(int warn_number,int n1){
  warn(warn_number,n1,0,0,0);
}

void warn(int warn_number){
  warn(warn_number,0);
}

void stop_game(int error_number,int n1,int n2){
  print("=====================================================\n");
  if(error_number == 0){
    print("|      error:config_enemy_hp.length = " + n1 + ", r.length = " + n2 + "\n");
  }else if(error_number == 1){
    print("|      error:config_enemy_hp.length = " + n1 + ", damage.length = " + n2 + "\n");
  }else if(error_number == 2){
    print("|      error:config_enemy_hp.length = " + n1 + ", score.length = " + n2 + "\n");
  }else if(error_number == 3){
    print("|      error:config_enemy_hp.length = " + n1 + ", vx_range.length = " + n2 + "\n");
  }else if(error_number == 4){
    print("|      error:config_enemy_hp.length = " + n1 + ", vy_range.length = " + n2 + "\n");
  }else if(error_number == 5){
    print("|      error:config_enemy_hp.length = " + n1 + ", ax_range.length = " + n2 + "\n");
  }else if(error_number == 6){
    print("|      error:config_enemy_hp.length = " + n1 + ", ay_range.length = " + n2 + "\n");
  }else if(error_number == 7){
    print("|      error:config_enemy_hp.length = " + n1 + ", color_fill.length = " + n2 + "\n");
  }else if(error_number == 8){
    print("|      error:config_hero_time_attack <= attack_keep\n");
  }else{
    print("|      error:unexpected\n");
  }
  print("=====================================================\n");
  exit();
}

void stop_game(int error_number){
  stop_game(error_number,0,0);
}

class timer{
  int timer;
  timer(int _timer){
    timer = _timer;
  }
  
  void set(int _timer){
    timer = _timer;
  }
  
  void reset(){
    timer = 0;
  }
  
  int get(){
    return timer;
  }
  
  void cnt(){
    timer += 60/config_fps;
  }
}

void change_fps(int fps){
  if(fps > 60){
    fps = 60;
  }
  config_fps = byte(fps);
  frameRate(config_fps);
}
