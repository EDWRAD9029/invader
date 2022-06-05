void create_enemy(int type,int n,int enchantment){
  int num_0 = cnt_type(0);
  int num_type = cnt_type(type,enchantment);
  boolean s1 = false;//keep hp
  boolean s2 = false;//attack1
  boolean s3 = false;//attack2
  int A = enchantment;
  if(A%2 == 1){
    s1 = true;
    A--;
  }
  A/=2;
  if(A%2 == 1){
    s2 = true;
    A--;
  }
  A/=2;
  if(A%2 == 1){
    s3 = true;
    A--;
  }
  A/=2;
  
  while(num_0 > 0){
    if(num_type < n){
      for(int i = 0 ; i < config_num_enemy; i++){
        if(ene[i].type == 0){
          ene[i].reset(type,1);
          ene[i].s_keep_hp = s1;
          ene[i].s_attack1 = s2;
          ene[i].s_attack2 = s3;
          num_0--;
          num_type++;
          i = config_num_enemy;
        }
      }
    }else if(num_type > n){
      for(int i = 0 ; i < config_num_enemy; i++){
        if(ene[i].type == type){
          ene[i].reset(0);
          ene[i].s_keep_hp = false;
          ene[i].s_attack1 = false;
          ene[i].s_attack2 = false;
          num_type--;
          i = config_num_enemy;
        }
      }
    }else{
      num_0 = -1;
    }
  }
  
  if(type == 0){
    int a = n - cnt_type(0);
    for(int i = 0; i < config_num_enemy ; i++){
      if(ene[i].type != 0){
        ene[i].reset(0);
        ene[i].s_keep_hp = false;
        ene[i].s_attack1 = false;
        ene[i].s_attack2 = false;
        a--;
      }
      if(a == 0){
        i = config_num_enemy;
      }
    }
  }
}

void create_enemy(int type,int n){
  create_enemy(type,n,0);
}
