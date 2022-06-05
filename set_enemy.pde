void set_enemy(){
  if(config_gamemode == 1){
    create_enemy(2,20);
    if(hero.Lv%5 == 0){
      create_enemy(3,(hero.Lv-hero.Lv%5)/5,2);
    }
    if(hero.Lv%10 == 0){
      create_enemy(3,(hero.Lv-hero.Lv%10)/10,3);
    }
    if(hero.Lv%15 == 0){
      create_enemy(3,(hero.Lv-hero.Lv%15)/15,4);
    }
  }else if(config_gamemode == 2){
    create_enemy(2,10);
    create_enemy(3,2,2);
    if(hero.Lv%5 == 0){
      create_enemy(3,(hero.Lv-hero.Lv%5)/5,3);
    }
    if(hero.Lv%10 == 0){
      create_enemy(3,(hero.Lv-hero.Lv%10)/10,6);
    }
  }else if(config_gamemode == 3){
    create_enemy(3,2,7);
    create_enemy(2,30);
    if(hero.Lv%5 == 0){
      create_enemy(4,(hero.Lv-hero.Lv%5)/5,7);
    }
    if(hero.Lv%6 == 0){
      create_enemy(4,(hero.Lv-hero.Lv%6)/6,6);
    }
  }else if(config_gamemode == 4){
    create_enemy(3,2,7);
    create_enemy(2,30,6);
    if(hero.Lv%5 == 0){
      create_enemy(4,(hero.Lv-hero.Lv%5)/5,7);
    }
    if(hero.Lv%6 == 0){
      create_enemy(4,(hero.Lv-hero.Lv%6)/6,6);
    }
  }
}
