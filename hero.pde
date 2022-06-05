class hero{
  int Lv;
  int hp,hp_max;
  float x,y;
  float dxForPs4,dyForPs4;
  float r;
  int score;
  boolean s_attack;
  int time_attack;
  float time_cure;
  hero(float _x,float _y,float _r){
    set(_x,_y,_r,100,100);
  }
  
  void set(float _x,float _y,float _r,int _hp,int _hp_max){
    Lv = 1;
    x = _x;
    y = _y;
    r = _r;
    hp = _hp;
    hp_max = _hp_max;
    score = 0;
    s_attack = true;
    time_attack = 10;
    time_cure = config_hero_cureauto_time;
    dxForPs4 = 0;
    dyForPs4 = 0;
  }
  
  void update(){
    if(config_gameControl == "key&mouse"){
      x = mouseX;
      y = mouseY;
      if(y < config_disp_h/4){
        y = config_disp_h/4;
      }
    }else if(config_gameControl == "PS4"){
      x += dxForPs4;
      if(x < 0){
        x = 0;
      }
      if(config_disp_w < x){
        x = config_disp_w;
      }
      dxForPs4 = 0;
      y += dyForPs4;
      if(y < config_disp_h/4){
        y = config_disp_h/4;;
      }
      if(config_disp_h < y){
        y = config_disp_h;
      }
      dyForPs4 = 0;
    }
  }
  
  void cure_auto(){
    if(config_gamemode != -1){
      if(hp != hp_max){
        time_cure -= config_hero_cureauto_time / config_fps;
      }else{
        time_cure = config_hero_cureauto_time;
      }
      
      if(time_cure <= 0){
        hp_up(config_hero_cureauto_amount);
        time_cure = config_hero_cureauto_time;
      }
    }
  }
  
  void calc_Lv(){
    if(score >= Lv*Lv){
      Lv++;
    }
  }
  
  void disp_Lv(){
    fill(255);
    textSize(20);
    text("Lv."+Lv,52,52);
    fill(0);
    textSize(20);
    text("Lv."+Lv,50,50);
  }
  
  void keymouse(boolean _s){
    //attack
    boolean _s_ = _s;
    boolean sForPs4 = true;;
    if(config_gameControl == "PS4"){
      if(_s_ == false)sForPs4 = false;
    }
    if(s_attack && sForPs4){
      if(keyPressed || _s_){
        if(key == 'A' || key == 'a' || _s_){
          for(int i = 0 ; i < config_num_enemy; i++){
            if((x-config_enemy_r[ene[i].type] < ene[i].x)&&(ene[i].x < x+config_enemy_r[ene[i].type])){
              if(ene[i].y < y){
                if(ene[i].s_keep_hp == false){
                  ene[i].hp -= config_hero_attack;
                }
                if(ene[i].hp <= 0){
                  score += config_enemy_score[ene[i].type];
                  ene[i].reset(ene[i].type);
                }
              }
            }
          }
          s_attack = false;
          time_attack = -config_hero_attack_keep;
        }
      }
    }else{
      if(time_attack > 0){
        time_attack -= int(60/config_fps);
        if(time_attack <= 0){
          s_attack = true;
          time_attack = 0;
        }
      }else{
        time_attack += int(60/config_fps);
        if(time_attack >= 0){
          time_attack = config_hero_time_attack - config_hero_attack_keep;
        }
      }
    }
  }
  
  void hp_up(int d){
    hp += d;
    if(hp_max < hp){
      hp = hp_max;
    }
  }
  
  void hp_down(int d){
    hp -= d;
    if(hp < 0){
      hp = 0;
    }
  }
  
  void disp(){
    fill(0);
    ellipse(x,y,r*2,r*2);
  }
  
  void disp_attack(){
    if(time_attack < 0){
      fill(120,20,200);
      stroke(120,20,200);
      strokeWeight(5);
      line(x,0,x,y);
    }
  }
  
  void disp_hp(){
    strokeWeight(1);
    stroke(255);
    fill(255,0,0);
    rect(5,5,hp_max*5,20);
    stroke(255);
    fill(0,255,0);
    rect(5,5,hp*5,20);
    
    stroke(0);
    strokeWeight(5);
    if(map(score,sq(Lv-1),sq(Lv),5,hp_max*5+5) < hp_max*5+5){
      line(5,25,map(score,sq(Lv-1),sq(Lv),5,hp_max*5+5),25);
    }else{
      line(5,25,hp_max*5+5,25);
    }
  }
}
