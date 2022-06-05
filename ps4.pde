class ps4Controller{
  boolean OnOff;
  ControlIO control;
  ControlDevice device;
  ControlSlider slider_R_Horizontal;
  ControlSlider slider_R_Vertical;
  ControlSlider slider_L_Horizontal;
  ControlSlider slider_L_Vertical;
  ControlSlider slider_R2;
  ControlSlider slider_L2;
  ControlButton hat;
  boolean hat_left,hat_right,hat_up,hat_down;
  ControlButton button_square;
  ControlButton button_crossedline;
  ControlButton button_circle;
  ControlButton button_triangle;
  ControlButton button_L1;
  ControlButton button_R1;
  ControlButton button_L2;
  ControlButton button_R2;
  ControlButton button_SHARE;
  ControlButton button_OPTIONS;
  boolean up_p,down_p,left_p,right_p;
  boolean square_p,crossedline_p,circle_p,triangle_p;
  boolean L1_p,L2_p,R1_p,R2_p;
  boolean share_p,options_p;
  
  float sensitivity;
  
  ps4Controller(ControlIO _control){
    control = _control;
    sensitivity = 30;
    set();
  }
  
  boolean IsAvailable(){
    return OnOff;
  }
  
  void pressedUp(){
    if(!up_p){
      //write here
      if(config_mode == 1){
        label.menu_down();
      }
    }
    up_p = true;
  }
  
  void pressedDown(){
    if(!down_p){
      //write here
      if(config_mode == 1){
        label.menu_up();
      }
    }
    down_p = true;
  }
  
  void pressedRight(){
    if(!right_p){
      //write here
      if(config_mode == 1){
        label.sub_up();
      }
    }
    right_p = true;
  }
  
  void pressedLeft(){
    if(!left_p){
      //write here
      if(config_mode == 1){
        label.sub_down();
      }
    }
    left_p = true;
  }
  
  void pressedSquare(){
    if(!square_p){
      //write here
      
    }
    square_p = true;
  }
  
  void pressedCrossedline(){
    if(!crossedline_p){
      //write here
      
    }
    crossedline_p = true;
  }
  
  void pressedCircle(){
    if(!circle_p){
      //write here
      if(config_mode == 1){
        label.clicked();
      }else if(config_mode == 2){
        if(config_gamemode != -1){
          hero.keymouse(true);
        }else{
          config_mode = 1;
        }
        
      }
    }
    circle_p = true;
  }
  
  void pressedTriangle(){
    if(!triangle_p){
      //write here
      
    }
    triangle_p = true;
  }
  
  void pressedL1(){
    if(!L1_p){
      //write here
      
    }
    L1_p = true;
  }
  
  void pressedL2(){
    if(!L2_p){
      //write here
      
    }
    L2_p = true;
  }
  
  void pressedR1(){
    if(!R1_p){
      //write here
      
    }
    R1_p = true;
  }
  
  void pressedR2(){
    if(!R2_p){
      //write here
      
    }
    R2_p = true;
  }
  
  void pressedShare(){
    if(!share_p){
      //write here
      
    }
    share_p = true;
  }
  
  void pressedOptions(){
    if(!options_p){
      //write here
      
    }
    options_p = true;
  }
  
  void sensitivityUp(){
    sensitivity *= 1.1;
    if(50 < sensitivity){
      sensitivity = 50;
    }
  }
  
  void sensitivityDown(){
    sensitivity *= 0.9;
    if(sensitivity < 1){
      sensitivity = 1;
    }
  }
  
  void set(){
    OnOff = false;
    openDevice();
    if(OnOff){
      slider_R_Horizontal = device.getSlider(0);
      slider_R_Vertical = device.getSlider(1);
      slider_L_Horizontal = device.getSlider(2);
      slider_L_Vertical = device.getSlider(3);
      slider_R2 = device.getSlider(4);
      slider_L2 = device.getSlider(5);
      hat = device.getButton(0);
      button_square = device.getButton(1);
      button_crossedline = device.getButton(2);
      button_circle = device.getButton(3);
      button_triangle = device.getButton(4);
      button_L1 = device.getButton(5);
      button_R1 = device.getButton(6);
      button_L2 = device.getButton(7);
      button_R2 = device.getButton(8);
      button_SHARE = device.getButton(9);
      button_OPTIONS = device.getButton(10);
    }
    up_p = false;
    down_p = false;
    left_p = false;
    right_p = false;
    square_p = false;
    crossedline_p = false;
    circle_p = false;
    triangle_p = false;
    L1_p = false;
    L2_p = false;
    R1_p = false;
    R2_p = false;
    share_p = false;
    options_p = false;
  }
  
  void update(){
    if(OnOff){
      if(abs(slider_L_Vertical.getValue()) > 0.01){
        hero.dxForPs4 = slider_L_Vertical.getValue()*(60/config_fps)*sensitivity;
      }
      if(abs(slider_L_Horizontal.getValue()) > 0.01){
        hero.dyForPs4 = slider_L_Horizontal.getValue()*(60/config_fps)*sensitivity;
      }
      byte s = byte(hat.getValue());
      if(s == 0){
        hat_up = false;
        hat_right = false;
        hat_down = false;
        hat_left = false;
      }else if(s == 1){
        hat_up = true;
        hat_right = false;
        hat_down = false;
        hat_left = true;
      }else if(s == 2){
        hat_up = true;
        hat_right = false;
        hat_down = false;
        hat_left = false;
      }else if(s == 3){
        hat_up = true;
        hat_right = true;
        hat_down = false;
        hat_left = false;
      }else if(s == 4){
        hat_up = false;
        hat_right = true;
        hat_down = false;
        hat_left = false;
      }else if(s == 5){
        hat_up = false;
        hat_right = true;
        hat_down = true;
        hat_left = false;
      }else if(s == 6){
        hat_up = false;
        hat_right = false;
        hat_down = true;
        hat_left = false;
      }else if(s == 7){
        hat_up = false;
        hat_right = false;
        hat_down = true;
        hat_left = true;
      }else if(s == 8){
        hat_up = false;
        hat_right = false;
        hat_down = false;
        hat_left = true;
      }
      if(hat_up)pressedUp();else up_p = false;
      if(hat_right)pressedRight();else right_p = false;
      if(hat_down)pressedDown();else down_p = false;
      if(hat_left)pressedLeft();else left_p = false;
      if(button_square.pressed())pressedSquare();else square_p = false;
      if(button_crossedline.pressed())pressedCrossedline();else crossedline_p = false;
      if(button_circle.pressed())pressedCircle();else circle_p = false;
      if(button_triangle.pressed())pressedTriangle();else triangle_p = false;
      if(button_L1.pressed())pressedL1();else L1_p = false;
      if(button_R1.pressed())pressedR1();else R1_p = false;
      if(button_L2.pressed())pressedL2();else L2_p = false;
      if(button_R2.pressed())pressedR2();else R2_p = false;
      if(button_SHARE.pressed())pressedShare();else share_p = false;
      if(button_OPTIONS.pressed())pressedOptions();else options_p = false;
    }
  }
  
  void openDevice(){
    List<ControlDevice> devList = control.getDevices();
  
    int i = 0;
    for (ControlDevice dev : devList) i++;
    String device_type[] = new String[i];
    i = 0;
    for (ControlDevice dev : devList) {
      device = dev;
      device_type[i] = dev.getTypeName();
      i++;
    }
    
    //check type name
    for(i = 0 ; i < device_type.length ; i++){
      device_type[i] = check_device(device_type[i]);
    }
    print(device_type);
    for(i = 0 ; i < device_type.length ; i++){
      if(device_type[i] == "PS4"){
        device = control.getDevice(i);
        OnOff = true;
        break;
      }
    }
  
    device.open();
  }
  
  String check_device(String s){
    //for ps4 controller
    if(s == "Stick"){
      s = control.getDevices().toString();
      if(s.indexOf("Wireless Controller")!=-1 && device.getNumberOfButtons()==15 && device.getNumberOfSliders()==6){
        s = "PS4";
      }else{
        s = "unknown";
      }
    }
    return s;
  }
}
