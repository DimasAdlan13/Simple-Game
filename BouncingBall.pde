//import ddf.minim.*;
//AudioPlayer player;
//Minim minim;//audio context
int level = 0;
color c1 = #00bfff;
color c2 = #138b38;
color c3 = #c61531;
boolean paused = false;
int cheatscore = 0;
int score = cheatscore;
boolean magnet, jetpack;
boolean enablepack = false;
boolean slowed = false;
int a, b, c, d;
int clicktostart = 0;
powerup Drake;
runner greg, charlie;
jumper Stan;
treasure Tim;

void setup() {
  //minim = new Minim(this);
  //player = minim.loadFile("a.mp3", 2048);
  //player.play();
  //player.loop();
  strokeWeight(2);
  size(800, 700);
  background(250);
  frameRate(30);
  greg = new runner(c1, 400, 425, 1, 25);
  charlie = new runner(c2, 400, 600, -2, 30);
  Stan = new jumper(c3, 400, 20, 0, 10);
  Tim = new treasure(color(random(255), random(255), random(255)), random(100, 700), random(150, 300), 20.0);
  Drake = new powerup();
}


void draw() {
   if (clicktostart==0)
      {
      fill(0, 102, 153);
      textSize(70);
      textAlign(CENTER,CENTER);
      text("Click to Start!", 400, 300);
      }
  if (clicktostart==1)
      {
      background(250);
      
      textSize(40);
      text("Click to Continue",400,100);
      
      textSize(20);
      textAlign(CENTER,CENTER);
      fill(c3);
      text("Use 'a' and 'd' to accelerate     left or right", 400, 200);
      ellipse(475,203,10,10);
      
      fill(color(#32b9ff));
      text("Score points by collecting treasure:",400,300);
      ellipse(590,303,20,20);
      fill(0,0,0);
      textSize(20);
      textAlign(CENTER);
      text(("X"), 590,303+7.5);
      
      fill(color(#ff7832));
      text("Bounce off of         to not fall!",400,400);
      ellipse(415,390, 25,25);
      fill(0,0,0);
      textSize(25);
      textAlign(CENTER);
      text("↑",415,398); 
      
      fill(color(#287070));
      text("Collect      for powerups!",400,500);
      ellipse(361,490,25,25);
      fill(255,255,255);
      text("¤",361+0.41,490  +8.5);
      fill(color(#287070));
      textSize(18);
      text("green enables jetpack (WASD), blue slows time, and pink increases size",400,550);
      
      fill(color(#b26e87));
      textSize(25);
      text("press 'p' to pause",400,650);
      
    
      }
  if (clicktostart>=2 && paused==false)
      {
      background(250);
      fill(c1);
      line(0,425,800,425);
      line(0,600,800,600);
      greg.update();
      charlie.update();
      Stan.update(greg,charlie);
      Tim.update(Stan);
      Drake.update();
      fill(0, 102, 153);
      textSize(70);
      textAlign(CENTER,CENTER);
      text(score, 400, 200);
      fill(200, 50, 53);
      int level=(floor(score/5)+1);
      textSize(30);
      textAlign(CENTER,CENTER);
      text(("Level "+str(level)), 400,35);
      
      a=((Drake.sizecheck+60-second())%60);
      if (Stan.size>10)
            {
            fill(Drake.powercolors[1]);
            textSize(40);
            textAlign(CENTER,CENTER);
            text(a, 600,35);
            if (a==0){
            Stan.size=10;
            Stan.Color=#c61531;
            }
        }
        
      b=((Drake.jetcheck+60-second())%60);
      if (enablepack==true)
          {
          fill(Drake.powercolors[0]);
          Stan.Color=Drake.powercolors[0];
          textSize(40);
          textAlign(CENTER,CENTER);
          text(b, 700,35);
           if (b==0)
               {
              enablepack=false;
              Stan.Color=#c61531;
              }
          }
        
      c=((Drake.slowcheck+60-second())%60);
      if (slowed==true)
        {
        fill(Drake.powercolors[2]);
        Stan.Color=Drake.powercolors[2];
        textSize(40);
        textAlign(CENTER,CENTER);
        text(c, 650,35);
        if (c==0)
            {
            slowed=false;
            frameRate(30);
            Stan.Color=#c61531;
            }
        }
        
      d=((Drake.timecheck+60-second())%60);
      if (d==0){
      Drake.active=true; 
      }
      }
}

class runner
    {
      color Color;
      float size,speed,originalspeed;
      float xpos,ypos;
      runner(color c, float x, float y, float s,float s2)
          {
            Color = c;
            xpos= x;
            ypos=y;
            speed=s;
            originalspeed=s;
            size=s2;
 }
          int direction(float x){
          if (x<0){
            return(-1);
          }
          else
            {
            return(1);
            }
          }
          void update()
          {
          //speed up along with score
          speed=(abs(originalspeed)+(log(score+1))/2)*direction(speed);
          if (xpos<0 || xpos>800)
          {
          speed=speed*-1;  
          }
          xpos+=speed;
          fill(Color);
          ellipse(xpos,ypos,(size),(size));
          fill(0,0,0);
          textSize(25);
          textAlign(CENTER);
          text("↑",xpos,ypos+8); 
          }
    }
class treasure
{
      color Color;
      float size;
      float xpos,ypos,vvector,hvector,rvvector,rhvector;
      treasure(color c, float x, float y, float s)
          {
            Color = c;
            xpos= x;
            ypos=y;
            size=s;
            vvector=random(-2,2);
            hvector=random(-5,5);     
          }
          
       void reenterscreen()
       //treasure reenters screen after leaving it
        {
        if (this.xpos>width)
        {
        this.xpos=0;
        }
        if (this.xpos<0){
        this.xpos=width;
        }
        if (this.ypos>height)
        {
        this.ypos=0;
        }
        if (this.ypos<0){
        this.ypos=height;
        }
        }
        
        
      boolean contact(jumper a){
              //x^2 +y^2
            float first = pow((a.xpos-this.xpos),2)+pow((a.ypos-this.ypos),2);
          return(pow(first,0.5)<(this.size+a.size)/1.5);
          }
        
      void update(jumper a)
      {
      reenterscreen();
     //contact with red ball:
     if (contact(a))
      {
       score+=1;
        this.Color=color(random(255),random(255),random(255));
        this.xpos=random(100,700);
        this.ypos=random(100,350);
        vvector=random(-20,20)/10;
        hvector=random(-40,40)/10;
      }
      // random walk
      if ((frameCount%15==0) && score>=10)
      {
      rhvector=random(-pow(score,0.5),pow(score,0.5))/2;
      rvvector=random(-pow(score,0.5),pow(score,0.5))/3;
      }
      //move with score
      if (score>=5)
        {
        this.xpos+=hvector+rhvector;
        this.ypos+=vvector+rvvector;
        }
      fill(this.Color);
      ellipse(this.xpos,this.ypos,this.size,this.size);
      fill(0,0,0);
      textSize(20);
      textAlign(CENTER);
      text(("X"), xpos,ypos+7.5);
    }
    }
void mouseClicked() {
  clicktostart += 1;
  Drake.reset();
}

