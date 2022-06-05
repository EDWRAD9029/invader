int cnt_type(int type,int enchantment){
  int n = enchantment;
  boolean s1 = false;//keep hp
  boolean s2 = false;//attack1
  boolean s3 = false;//attack2
  if(n%2 == 1){
    s1 = true;
    n--;
  }
  n/=2;
  if(n%2 == 1){
    s2 = true;
    n--;
  }
  n/=2;
  if(n%2 == 1){
    s3 = true;
    n--;
  }
  n/=2;
  
  n = 0;
  for(int i = 0 ; i < config_num_enemy; i++){
    if(ene[i].type == type &&ene[i].s_keep_hp==s1&&ene[i].s_attack1==s2&&ene[i].s_attack2==s3){
      n++;
    }
  }
  return n;
}

int cnt_type(int type){
  int n = 0;
  n = cnt_type(type,0);
  return n;
}
