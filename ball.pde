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
