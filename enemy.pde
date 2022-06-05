class enemy{
  byte type;//0:wait 1:bullet 2:enemy1 3:enemy2
  float x,y;
  float vx,vy;
  float ax,ay;
  int hp,hp_max;
  float s_time1;
  float s_time2;
  float s_time3;
  
  boolean s_keep_hp;
  boolean s_attack1;
  boolean s_attack2;
  
  enemy(int _type){
    s_keep_hp = false;
    s_attack1 = false;
    s_attack2 = false;
    reset(_type);
  }
  
  void reset(int _type){
    reset(_type,0);
  }
  
  void reset(int _type,int s){
    type = byte(_type);
    x = random(0,config_disp_w);
    y = -config_enemy_r[type];
    if(s == 0){
      if(type == 1){
        type = 0;
      }
    }
    hp_max = config_enemy_hp[type];
    hp = hp_max;
    vx = random(config_enemy_vx_range[type][0],config_enemy_vx_range[type][1]);
    vy = random(config_enemy_vy_range[type][0],config_enemy_vy_range[type][1]);
    ax = random(config_enemy_ax_range[type][0],config_enemy_ax_range[type][1]);
    ay = random(config_enemy_ay_range[type][0],config_enemy_ay_range[type][1]);
    
    s_time1 = random(config_enemy_attack_time[0][0],config_enemy_attack_time[0][1]);
    s_time2 = random(config_enemy_attack_time[1][0],config_enemy_attack_time[1][1]);
    s_time3 = random(config_enemy_attack_time[2][0],config_enemy_attack_time[2][1]);
  }
  
  void calc_xy(){
    //collision
    float r = config_enemy_r[type];
    vx += ax/config_fps;
    vy += ay/config_fps;
    
    if(x+vx/config_fps < -r){
      reset(type);
    }else if(config_disp_w+r < x+vx/config_fps){
      reset(type);
    }else{
      x += vx/config_fps;
    }
    
    if(config_disp_h+r < y+vy/config_fps){
      reset(type);
    }else if(y+vy/config_fps < -r){
      reset(type);
    }else{
      y += vy/config_fps;
    }
    
    //special
    if(s_keep_hp){
      s_time1 -= 60/config_fps;
    }
    if(s_attack1){
      s_time2 -= 60/config_fps;
    }
    if(s_attack2){
      s_time3 -= 60/config_fps;
    }
    
    if(s_time1 <= 0){
      s_keep_hp = false;
    }
    if(s_time2 <= 0){
      s_time2 = random(config_enemy_attack_time[1][0],config_enemy_attack_time[1][1]);
      attack(0,15);
    }
    if(s_time3 <= 0){
      s_time3 = random(config_enemy_attack_time[2][0],config_enemy_attack_time[2][1]);
      attack(1,1);
    }
  }
  
  void attack(int attack_type,int _n){
    int n = _n;
    if(attack_type == 0){
      for(int i = 0 ; i < config_num_enemy; i++){
        if(ene[i].type == 0){
          ene[i].reset(1,1);
          ene[i].x = x;
          ene[i].y = y;
          n--;
        }
        if(n == 0){
          i = config_num_enemy;
        }
      }
    }else if(attack_type == 1){
      for(int i = 0 ; i < config_num_enemy; i++){
        if(ene[i].type == 0){
          ene[i].reset(1,1);
          ene[i].x = x;
          ene[i].y = y;
          float A = sqrt(sq(hero.x-x)+sq(hero.y-y));
          ene[i].vx = 200*(hero.x-x)/A;
          ene[i].vy = 200*(hero.y-y)/A;
          n--;
        }
        if(n == 0){
          i = config_num_enemy;
        }
      }
    }
  }
  
  void disp(){
    if(s_keep_hp){
      stroke(0,255,0);
      strokeWeight(4);
    }else{
      stroke(255);
      strokeWeight(1);
    }
    fill(config_enemy_color_fill[type]);
    ellipse(x,y,config_enemy_r[type]*2,config_enemy_r[type]*2);
  }
}
