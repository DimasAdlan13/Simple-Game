
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

class runner {
    color Color;  // Mendeklarasikan variabel warna
    float size, speed, originalspeed;  // Mendeklarasikan variabel ukuran, kecepatan, dan kecepatan awal
    float xpos, ypos;  // Mendeklarasikan variabel posisi x dan y

    runner(color c, float x, float y, float s, float s2) {
        // Konstruktor untuk menginisialisasi objek runner
        Color = c;
        xpos = x;
        ypos = y;
        speed = s;
        originalspeed = s;
        size = s2;
    }

    int direction(float x) {
        // Fungsi untuk menentukan arah berdasarkan nilai x
        if (x < 0) {
            return(-1);  // Mengembalikan -1 jika x negatif
        } else {
            return(1);   // Mengembalikan 1 jika x tidak negatif
        }
    }

    void update() {
        // Fungsi untuk memperbarui keadaan objek
        // Perhitungan kecepatan baru berdasarkan rumus tertentu
        speed = (abs(originalspeed) + (log(score + 1)) / 2) * direction(speed);

        // Mengubah arah kecepatan jika objek melewati batas layar
        if (xpos < 0 || xpos > 800) {
            speed = speed * -1;
        }

        // Mengupdate posisi objek
        xpos += speed;

        // Menggambar elips berwarna dengan posisi dan ukuran yang sesuai
        fill(Color);
        ellipse(xpos, ypos, size, size);

        // Menambahkan teks panah di atas objek
        fill(0, 0, 0);
        textSize(25);
        textAlign(CENTER);
        text("↑", xpos, ypos + 8);
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
(Penjelasan Kode)
  1.class treasure: Mendefinisikan kelas bernama treasure.
  2.Variabel Anggota (color Color, float size, float xpos, dst): Mendefinisikan variabel anggota kelas yang akan digunakan 
  untuk menyimpan warna, ukuran, dan posisi objek harta karun (treasure).
  3.Konstruktor (treasure(color c, float x, float y, float s) { ... }): Merupakan metode khusus yang dipanggil saat 
  objek dari kelas treasure dibuat. Konstruktor ini digunakan untuk menginisialisasi nilai awal dari objek harta karun 
  berdasarkan parameter yang diberikan.
    -color c: Parameter untuk warna harta karun.
    -float x: Parameter untuk posisi horizontal harta karun (xpos).
    -float y: Parameter untuk posisi vertikal harta karun (ypos).
    -float s: Parameter untuk ukuran harta karun (size).
  4.Inisialisasi Vektor (vvector dan hvector): Menginisialisasi vektor vertikal (vvector) dan vektor horizontal (hvector) 
  dengan nilai acak. 

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
(Penjelasan Kode)
  1.void reenterscreen(): Ini adalah deklarasi metode tanpa nilai kembali (void). Metode ini tidak mengembalikan nilai,
  tetapi bertanggung jawab untuk memastikan bahwa objek harta karun tetap di dalam layar permainan.
  2.Komentar (// treasure reenters screen after leaving it): Komentar ini memberikan deskripsi singkat tentang tujuan 
  dari metode tersebut.
  3.Pengecekan Batas Layar:
    -Jika nilai xpos (posisi horizontal objek harta karun) melebihi lebar layar (width), maka xpos diatur kembali menjadi 0, 
    sehingga objek akan muncul di sebelah kiri layar.
    -Jika xpos kurang dari 0, maka xpos diatur kembali menjadi width, sehingga objek akan muncul di sebelah kanan layar.
    -Jika ypos (posisi vertikal objek harta karun) melebihi tinggi layar (height), maka ypos diatur kembali menjadi 0,
    sehingga objek akan muncul di bagian atas layar.
    -Jika ypos kurang dari 0, maka ypos diatur kembali menjadi height, sehingga objek akan muncul di bagian bawah layar.
        
      boolean contact(jumper a){
              //x^2 +y^2
            float first = pow((a.xpos-this.xpos),2)+pow((a.ypos-this.ypos),2);
          return(pow(first,0.5)<(this.size+a.size)/1.5);
          }
(Penjelasan Kode)
  1.float first = pow((a.xpos - this.xpos), 2) + pow((a.ypos - this.ypos), 2);: Menghitung jarak kuadrat antara pusat objek 
  jumper dan objek treasure menggunakan formula jarak Euclidean.
  2.return pow(first, 0.5) < (this.size + a.size) / 1.5;: Mengembalikan true jika jarak antara pusat kedua objek kurang dari 
  separuh dari jumlah ukuran objek treasure dan jumper. Dengan kata lain, ini menandakan bahwa kedua objek bersentuhan.
       
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
(Penjelasan Kode)
  1.reenterscreen(): Memanggil metode reenterscreen() untuk memastikan bahwa objek treasure tetap berada dalam layar
    permainan.
  2.Kontrol Tabrakan (contact(a))
    Jika terjadi kontak antara objek treasure dan objek jumper (diidentifikasi oleh metode contact(a) yang mengembalikan 
    true), maka:
    -score += 1;: Menambahkan skor.
    -this.Color = color(random(255), random(255), random(255));: Mengatur warna objek treasure menjadi warna acak baru.
    -this.xpos = random(100, 700);: Mengatur posisi horizontal objek treasure ke lokasi acak di dalam layar.
    -this.ypos = random(100, 350);: Mengatur posisi vertikal objek treasure ke lokasi acak di dalam layar.
    -vvector = random(-20, 20) / 10; dan hvector = random(-40, 40) / 10;: Mengatur vektor gerak objek treasure dengan 
    nilai acak baru.

      // random walk
      if ((frameCount%15==0) && score>=10)
      {
      rhvector=random(-pow(score,0.5),pow(score,0.5))/2;
      rvvector=random(-pow(score,0.5),pow(score,0.5))/3;
      }
(Penjelasan Kode)
  1.Setiap 15 frame dan ketika skor (score) sudah mencapai atau melebihi 10, maka objek treasure akan melakukan gerakan acak.
  2.rhvector dan rvvector adalah vektor gerakan acak untuk komponen horizontal dan vertikal.
  3.random(-pow(score, 0.5), pow(score, 0.5)) memberikan nilai acak antara negatif akar kuadrat skor dan akar kuadrat skor.
  4.Ini menciptakan gerakan acak yang lebih dramatis seiring pertambahan skor.

      //move with score
      if (score>=5)
        {
        this.xpos+=hvector+rhvector;
        this.ypos+=vvector+rvvector;
        }
(Penjelasan Kode)
  1.Jika skor (score) mencapai atau melebihi 5, maka objek treasure akan bergerak.
  2.hvector dan vvector adalah vektor gerakan asli yang diinisialisasi pada saat pembuatan objek treasure.
  3.rhvector dan rvvector (jika kondisi sebelumnya terpenuhi) akan ditambahkan ke vektor gerakan asli untuk menciptakan
    pergerakan yang lebih kompleks.

      fill(this.Color);
      ellipse(this.xpos,this.ypos,this.size,this.size);
      fill(0,0,0);
      textSize(20);
      textAlign(CENTER);
      text(("X"), xpos,ypos+7.5);
    }
    }
(Penjelasan Kode)
  1.Menampilkan objek treasure sebagai lingkaran dengan warna sesuai Color dan ukuran sesuai size.
  2.Menampilkan teks "X" di atas lingkaran sebagai penanda.
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
void mouseClicked() {
  clicktostart += 1;
  Drake.reset();
}


