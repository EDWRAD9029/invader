//control gamepad
import org.gamecontrolplus.*;
import java.util.List;
ps4Controller ps4;
int pointer_ps4;
ControlIO control;

//main
String config_gameControl = "";
int config_disp_w,config_disp_h;
byte config_fps = 60;
byte config_mode;
byte config_gamemode;
timer time;
hero hero;
int config_num_enemy = 5000;
enemy[] ene = new enemy[config_num_enemy];
check check = new check();

label label;
button[][] button = new button[4][5];

int config_hero_hpmax = 100;
int config_hero_r = 10;
int config_hero_attack = 50;
int config_hero_cureauto_time = 60*1;
int config_hero_cureauto_amount = 1;
int config_hero_time_attack = 50;
int config_hero_attack_keep = 5;
int[] config_enemy_hp =           {0,    1,        5,         50      ,100     };
int[] config_enemy_r =            {0,    10,       20,        50      ,50      };
int[] config_enemy_damage =       {0,    1,        5,         10      ,10      };
int[] config_enemy_score =        {0,    0,        1,         10      ,20      };
int[][] config_enemy_vx_range =   {{0,0},{-70,70}, {-50,50},  {-10,10},{-10,10}};
int[][] config_enemy_vy_range =   {{0,0},{30,70},  {20,50},   {5,10}  ,{5,10}  };
int[][] config_enemy_ax_range =   {{0,0},{0,0},    {-5,5},    {0,0}   ,{0,0}   };
int[][] config_enemy_ay_range =   {{0,0},{0,0},    {0,50},    {0,0}   ,{0,0}   };
color[] config_enemy_color_fill = {color(0),color(255,0,0),color(0,120,120),color(0),color(0)};

int[][] config_enemy_attack_time = {{100000,100000},{60*1,60*10},{10,10}};

void setup(){
  //main
  config_disp_w = displayWidth;
  config_disp_h = displayHeight;
  size(displayWidth,displayHeight);
  surface.setLocation(0,0);
  change_fps(60);
  config_mode = 1;
  config_gamemode = 1;
  
  time = new timer(0);
  hero = new hero(config_disp_w/2,config_disp_h-config_hero_r,config_hero_r);
  for(int i = 0; i < ene.length; i++){
    ene[i] = new enemy(0);
  }
  check.game();
  for(int i = 0 ; i < button.length ; i++){
    for(int j = 0 ; j < button[0].length ; j++){
      button[i][j] = new button();
    }
  }
  button[0][0].set(100,100,100,100,0,"GAME MODE",0);
  button[0][1].set(100,100,100,100,0,"EASY",1);
  button[0][2].set(300,100,100,100,0,"NORMAL",2);
  button[0][3].set(500,100,100,100,0,"HARD",3);
  button[0][4].set(700,100,100,100,0,"HELL",4);
  button[1][0].set(100,100,100,100,0,"FPS",0);
  button[1][1].set(100,300,100,100,0,"FPS UP",11);
  button[1][2].set(100,500,100,100,0,"FPS DOWN",12);
  button[2][0].set(100,100,100,100,0,"GAMEPAD",0);
  button[2][1].set(100,100,100,100,0,"mouse&key",21);
  button[2][2].set(100,100,100,100,0,"PS4",22);
  button[3][0].set(100,100,100,100,0,"Sensitivity",0);
  button[3][1].set(100,100,100,100,0,"UP",31);
  button[3][2].set(100,100,100,100,0,"DOWN",32);
  label = new label(0,button);
  
  //gamepad
  control = ControlIO.getInstance(this);
  ps4 = new ps4Controller(control);
  if(ps4.IsAvailable()){
    pointer_ps4 = 0;
    config_gameControl = "PS4";
    hero.x = config_disp_w/2;
    hero.y = config_disp_h - 100;
  }else{
    config_gameControl = "key&mouse";
  }
}

void draw(){
  //ps4
  ps4.update();
  
  //main
  //==========================================================
  //menu
  //==========================================================
  if(config_mode == 1){
    if(ps4.IsAvailable() && config_gameControl == "PS4"){
      //for ps4
      create_enemy(2,4);
      create_enemy(3,2,1);
      create_enemy(3,1,6);
      background(255);
      hero.update();
      for(int i = 0 ; i < ene.length ; i++){
        ene[i].calc_xy();
        ene[i].disp();
      }
      label.disp();
    }else{
      //for key&mouse
      create_enemy(2,4);
      create_enemy(3,2,1);
      create_enemy(3,1,6);
      background(255);
      hero.update();
      for(int i = 0 ; i < ene.length ; i++){
        ene[i].calc_xy();
        ene[i].disp();
      }
      textSize(50);
      fill(0);
      text("FPS:"+config_fps,10,60);
      button[0][1].disp();
      button[0][2].disp();
      button[0][3].disp();
      button[0][4].disp();
      button[1][1].disp();
      button[1][2].disp();
      button[2][1].disp();
      button[2][2].disp();
      fill(0);
      textSize(20);
      text("FPS:"+config_fps,config_disp_w-300,config_disp_h-30);
      text("GAME CONTROL:"+config_gameControl,config_disp_w-300,config_disp_h-50);
    }
  //==========================================================
  //game mode
  //==========================================================
  }else if(config_mode == 2){
    if(config_gamemode != -1){
      set_enemy();
      time.cnt();
      
      //calc
      if(config_gamemode < 5){
        hero.cure_auto();
      }
      hero.update();
      for(int i = 0; i < ene.length; i++){
        if(ene[i].type != 0){
          ene[i].calc_xy();
          if(check_collision(hero.x,hero.y,hero.r,ene[i].x,ene[i].y,config_enemy_r[ene[i].type])){
            hero.hp_down(config_enemy_damage[ene[i].type]);
            ene[i].reset(ene[i].type);
          }
        }
      }
      
      hero.keymouse(false);
      hero.calc_Lv();
      
      //disp
      background(255);
      for(int i = 0; i < ene.length; i++){
        ene[i].disp();
      }
      hero.disp_attack();
      hero.disp();
      hero.disp_hp();
      hero.disp_Lv();
      if(hero.hp == 0){
        disp_score(calc_score());
      }
      
      //dedug
      check.game();
      check.delay();
      check.update();
      print("delay=" + check.delay_time + "[sec/frame];hero.score="+ hero.score + "\n");
    }else{
      //game over
      if(keyPressed && config_gameControl == "key&mouse"){
        if(key == 'q' || key == 'Q'){
          config_mode = 1;
        }
      }
    }
  }else{
    
  }
}
