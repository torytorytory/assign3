//You should implement your assign2 here.
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
final int E1 = 10;
final int E2 = 11;
final int E3 = 12;

PImage Hp;
PImage Enemyship;
PImage Fightership;
PImage bg1;
PImage bg2;
PImage treasure;
PImage start1;
PImage start2;
PImage end1;
PImage end2;


int x, y, bx;
int randomP,HP_num;
int gameState;
int enemyState;
int space=10;

float EnemyshipX,EnemyshipY;
float FightershipX,FightershipY;
float treasureX,treasureY;
float speed = 10;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

boolean onetime= false;


void setup(){
  size(640,480);
  x =0;
  bx=0;
  y = 200;
  HP_num=20;
  randomP=floor(random(100));  
  start2= loadImage("img/start1.png");
  start1= loadImage("img/start2.png");
  end1= loadImage("img/end1.png");
  end2= loadImage("img/end2.png");
  Fightership= loadImage("img/fighter.png");
  Enemyship = loadImage("img/enemy.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  treasure= loadImage("img/treasure.png");
  Hp = loadImage("img/hp.png");
  EnemyshipY=floor(random(Enemyship.height,height-Enemyship.height));
  gameState = GAME_START;
  FightershipX=640-Fightership.width-10;
  FightershipY=480/2;
  enemyState=E1;
}

void draw(){
  background(255);
  
  switch (gameState){
    case GAME_START:
    image(start1,0,0);
      if ((mouseX > 200 && mouseX < 460) && (mouseY > 375 && mouseY < 420)){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(start2,0,0);        
        }
      }   
    break;
    
    case GAME_RUN:

      fill(255,0,0);
      image(bg1,((bx+640)%1280-640),0);
      image(bg2,bx%1280-640,0);
      
      switch (enemyState)
      {
        case E1:

        EnemyshipX=x%(640+5*(Enemyship.width+space))-Enemyship.width;
         for (int i=0;i<5;i++){
             image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY);
          }
        if (EnemyshipX>=((640+5*(Enemyship.width+space))-1-Enemyship.width))
          onetime=true;
          
        if (EnemyshipX==919)
        {
         EnemyshipY=floor(random(Enemyship.height/2,height-Enemyship.height*5));
         enemyState=E2;
         x=0;
        } 
        
        break;
        
        case E2:
          EnemyshipX=x%(640+5*(Enemyship.width+space))-Enemyship.width;
            for (int i=0;i<5;i++){
             image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY+i*Enemyship.height);
            }
         if (EnemyshipX==919)
         {
          EnemyshipY=floor(random(Enemyship.height*2,height-Enemyship.height*3));
          enemyState=E3;
          x=0;
         }             
            
        break;
        
        case E3:
          EnemyshipX=x%(640+5*(Enemyship.width+space))-Enemyship.width;
            for (int i=0;i<5;i++){
             if (i<=2)
             {
              image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY+i*Enemyship.height);
              image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY-i*Enemyship.height);
             }
             else
             {
              image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY+(4-i)*Enemyship.height);
              image(Enemyship,EnemyshipX-i*(Enemyship.width+space),EnemyshipY-(4-i)*Enemyship.height);               
             }
          }
          
         if (EnemyshipX==919)
         {
          EnemyshipY=floor(random(0,height-Enemyship.height));
          enemyState=E1;
         }             

        
        break;
      }
      
/*      
       EnemyshipX=x%(640+Enemyship.width-1)-Enemyship.width;
           if (EnemyshipX==-(Enemyship.width))
         EnemyshipY=floor(random(Enemyship.height/2,height-Enemyship.height/2));
        image(Enemyship,EnemyshipX,EnemyshipY);
*/ 
      
      
      image(Fightership,FightershipX,FightershipY);
       treasureX=(640-treasure.width)*randomP/100;
       treasureY=(480-treasure.height)*randomP/100;
      image(treasure,treasureX,treasureY);
      colorMode(RGB);
      rect(5, 0, (Hp.width-10)*HP_num/100, Hp.height*0.7);
      fill(255,0,0);
      image(Hp,0,0);
      x+=5;
      bx++;
      
      if (((EnemyshipX+Enemyship.width>=FightershipX) && (EnemyshipX+Enemyship.width<=(FightershipX+Fightership.width))) || ((EnemyshipX>=FightershipX) && (EnemyshipX<=(FightershipX+Fightership.width))))
       if (((EnemyshipY+Enemyship.height>=FightershipY) && (EnemyshipY+Enemyship.height<=(FightershipY+Fightership.height))) || ((EnemyshipY>=FightershipY) && (EnemyshipY<=(FightershipY+Fightership.height))))
        {
         // HP_num-=20;
         // x=0;         
        }

      if (((treasureX+treasure.width>=FightershipX) && (treasureX+treasure.width<=(FightershipX+Fightership.width))) || ((treasureX>=FightershipX) && (treasureX<=(FightershipX+Fightership.width))))
       if (((treasureY+treasure.height>=FightershipY) && (treasureY+treasure.height<=(FightershipY+Fightership.height))) || ((treasureY>=FightershipY) && (treasureY<=(FightershipY+Fightership.height))))
        {
          HP_num+=10;
          if (HP_num>=100)
           HP_num=100;
           randomP=floor(random(100));
        }
    /*   
       if (EnemyshipY>FightershipY)
         EnemyshipY-=2;
       else
         EnemyshipY+=2;
    */     
      if (upPressed == true)
        FightershipY-=speed;
      if (FightershipY<=0)
        FightershipY=0;

      if (downPressed == true)
        FightershipY+=speed;
      if (FightershipY>(480-Fightership.height))
        FightershipY=480-Fightership.height;
        

      if (leftPressed == true)
        FightershipX-=speed;
      if (FightershipX<0)
        FightershipX=0;        

      if (rightPressed == true)
        FightershipX+=speed;
      if (FightershipX>(640-Fightership.width))
        FightershipX=640-Fightership.width;
         
      if (HP_num<=0)
         gameState = GAME_LOSE;
      
    break;
     
    case GAME_LOSE:
    image(end1,0,0);
      if ((mouseX > 200 && mouseX < 436) && (mouseY > 305 && mouseY < 349)){
        if (mousePressed){
          // click
          EnemyshipY=randomP*640/100;
          gameState = GAME_START;
          FightershipX=640-Fightership.width-10;
          FightershipY=480/2;
          x=0;
          HP_num=20;
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(end2,0,0);        
        }
      }
    
    break;
  }
  
  
}


void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
