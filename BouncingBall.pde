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
  // ... (Isi bagian ini sesuai dengan kondisi)
}

void mouseClicked() {
  clicktostart += 1;
  Drake.reset();
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

