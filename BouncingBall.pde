class jumper
      {
      color Color;
      boolean bounced;
      int size;
      float xpos,ypos,acceleration,vspeed,hspeed; 
      jumper(color c,int x, int y, float s, int s2)
          {
            Color = c;
            xpos= x;
            ypos=y;
            vspeed=s;
            hspeed=0;
            size=s2;
            acceleration=0.07;
          }
      
      //float a,float b, float c, float d,float e, float f
      boolean dist(runner a){
                //x^2 +y^2
              float first = pow((a.xpos-this.xpos),2)+pow((a.ypos-this.ypos),2);
            return(pow(first,0.5)<(this.size+a.size)/(1.5));
            }
      
      void reset(runner a, runner b){
        // if Stan hits the bottom of the screen
          this.xpos=400;
          this.ypos=20;
          this.vspeed=0;
          this.hspeed=0;
          score=cheatscore;
          this.size=10;
          a.speed=a.originalspeed;
          b.speed=b.originalspeed;
          a.xpos=400;
          frameRate(30);
          b.xpos=400;
          Stan.Color=c3;
          enablepack=false;
          slowed=false;
          Tim.xpos=random(200,600);
          Tim.ypos=random(100,400);
          }
      
      void update(runner a, runner b)
          {
            //case of Stan hitting Greg or Charlie
          if ((this.dist(a) ||  (this.dist(b))) && vspeed>0)
              {
              acceleration=-4;
              a.Color=color(random(255),random(255),random(255));
              b.Color=color(random(255),random(255),random(255));
              //bounce effect
              if (vspeed>0){
              vspeed=-0.5*vspeed;}
              }
          /////
          else
              {
              acceleration=0.09;
              }
          //vertical speed limiter
          if (pow(vspeed,2)<pow(12,2))
              {
              vspeed+=acceleration;
              }
          else
              {
               vspeed=12; 
              }
          ypos+=vspeed;
          //bounce off walls
          if (xpos>800){
            hspeed=-0.7*hspeed;
            xpos=800;}
          if (xpos<0){
            hspeed=-0.7*hspeed;
            xpos=0;}
          //bounce off top of screen
          if (ypos<0){
            vspeed=-0.5*vspeed;
            ypos=0;}
          if (ypos>height){
          score=0;
          this.reset(greg,charlie);
          }
          
          xpos+=hspeed;
          fill(Color);
          ellipse(xpos,ypos,size,size);
          }
      } 
      
      
void keyPressed()
    {
      if (key=='a'){
        if (Stan.hspeed>-30){
        Stan.hspeed+=-2;}}
      if (key==('d')){
        if (Stan.hspeed<30){
        Stan.hspeed+=2;}}
      if (key==('r')){
        Stan.reset(greg,charlie);}
      if (key==('w') && enablepack==true)
          {
            if (Stan.vspeed>0)
            {
            Stan.vspeed=Stan.vspeed*0.5; 
            }
          Stan.vspeed+=(-2); 
          }
    if (key==('s') && enablepack==true)
          {
            if (Stan.vspeed<0)
            {
            Stan.vspeed=Stan.vspeed*0.5; 
            }
          Stan.vspeed+=(2); 
          }
    if (key==('m'))
        {
        score+=5; 
        }
    if (key==('p'))
        {
        if (paused==false){paused=true;}
        else{paused=false;}
        }
    }

class powerup
{
    String type;
    color mycolor;
    boolean active;
    float size,speed,duration,time,xpos,ypos;
    int magnettime,jettime,sizetime,slowtime;
    int sizecheck,magnetcheck,jetcheck,slowcheck,timecheck;
    String [] powers={"jet pack","size +","slowmo","magnet"};
    color [] powercolors={#00ff66,#ff00ff,#006666};
     //ideas: magnet, jet pack, size increase, slowmo
    
    powerup()
            {
            active=false;
            speed=2;
            timecheck=0;
            //time to next spawn
            randomtime();
            xpos=0;
            ypos=300;
            size=25;
            type=randompower();
            }
        
        void randomtime()
            {
              time=second();
              timecheck=(second()+5+int(random(5,15)));
              //timecheck=(second()+3);
            }
        
        String randompower()
            {
            //int a=2;
            int a=int(random(0,3));
            mycolor=powercolors[a];
            return(powers[a]);
            }
        
        boolean contact(jumper a){
                  //x^2 +y^2
                float first = pow((a.xpos-this.xpos),2)+pow((a.ypos-this.ypos),2);
              return(pow(first,0.5)<(this.size+a.size)/1.5);
              }
              
        void reset()
              {
              active=false;
              xpos=floor(random(0,2))*800;
              if (xpos>400){
               speed=-1*random(1,3); 
              }
              else{
              speed=random(1,3); 
              }
              type=randompower();
              ypos=random(50,500);
              randomtime();  
              }
              
        void update()
          {              
            //once activated:
            if (active==true)
            {
              
              //applies effect if it touches Stan
              if (contact(Stan))
                  {
                    //size + powerup
                  if (type=="size +")
                      {
                      Stan.size=35;
                      sizetime=second();
                      sizecheck=sizetime+20;
                      Stan.Color=(#ff00ff);
                      if (sizecheck>59)
                        {
                          sizecheck=sizecheck-60;
                        }
                      }
                  if (type=="jet pack")
                      {
                      enablepack=true;
                      jettime=second();
                      jetcheck=jettime+15;
                      if (jetcheck>59)
                        {
                          jetcheck=jetcheck-60;
                        }
                      }
                  if (type=="slowmo")
                      {
                      frameRate(15);
                      slowed=true;
                      slowtime=second();
                      slowcheck=slowtime+15;
                      if (slowcheck>59)
                        {
                          slowcheck=slowcheck-60;
                        }
                      }
                  reset();
                  }
              
              //resets with randomness if powerup leaves screen
              if (xpos>width || xpos<0)
                  {
                  reset();
                  }
                
              if (active==true)
                  {
                  //flies across screen
                  xpos+=speed;
                  //rect(xpos,ypos,size,size);
                  fill(mycolor);
                  ellipse(xpos,ypos,size,size);
                  if (type=="jet pack"){
                    fill(0,0,0);}
                  else{
                  fill(255,255,255);}
                  textSize(20);
                  textAlign(CENTER);
                  text("¤",xpos+0.6,ypos+7.5);
                  //textSize(20);
                 // textAlign(CENTER);
                  //text((type), xpos,ypos-20);
                  }                    
              }
          }
}

void mouseClicked()
  {
  clicktostart+=1;
  Drake.reset();
  }
