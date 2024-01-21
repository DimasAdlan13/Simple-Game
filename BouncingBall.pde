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



void mouseClicked() {
  clicktostart += 1;
  Drake.reset();
}
