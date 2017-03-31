/* @pjs preload="resources/twitter.png,resources/facebook.png,resources/resume.png,resources/linkedin.png,resources/stackoverflow.png,resources/tumblr.png"; */
int num_links = 6;
PImage[] nimg = new PImage[num_links];
float[][] posit = new float[num_links][6];//x,y,speedx,speedy,externaldest,depth
float[][] dest = new float[num_links][2];
float arrivalx, arrivaly;
float speed_scale;
float dest_dist;
int ww = gh;
int desti = 0;
int dt = 0;
float max_scale = 1.125;
int curse = 0;

void setup(){
  nimg[0] = loadImage("resources/resume.png");
  nimg[1] = loadImage("resources/stackoverflow.png");
  nimg[2] = loadImage("resources/github.png");
  nimg[3] = loadImage("resources/soundcloud.png");
  nimg[4] = loadImage("resources/twitter.png");
  nimg[5] = loadImage("resources/facebook.png");

  for(int i = 0; i<num_links;i++){
    posit[i][0] = random(0, ww-58);
    posit[i][1] = random(0, 140);
    posit[i][4] = 0;
    float b = 0;
    b = random(-1,1);
    b = b/abs(b);
    posit[i][5] = b*random(1,max_scale);
    setDestination(0,i);
  }

  size(ww,200);

}

void draw(){
  curse = 0;
  background(61,69,61);

  for(int i = 0; i<num_links;i++){
    arrivalx = abs(dest[i][0]-posit[i][0]);
    arrivaly = abs(dest[i][1]-posit[i][1]);
    image(nimg[i],posit[i][0],posit[i][1],abs(nimg[i].width/posit[i][5]),abs(nimg[i].height/posit[i][5]));

      if(arrivalx < 11 && arrivaly < 11){
        if(posit[i][4] == 0){
          setDestination(0,i);
        } else {
         posit[i][2] = 0;
         posit[i][3] = 0;
        }
      }
      posit[i][0]+=posit[i][2];
      posit[i][1]+=posit[i][3];

    /*Breathing*/
     posit[i][5]+=.0015;
     if(abs(posit[i][5])>max_scale || abs(posit[i][5])<1.0)posit[i][5] = posit[i][5]*-1;
     /*MouseOver*/
     if (mouseX>posit[i][0] && mouseX<(posit[i][0] + abs(nimg[i].width/posit[i][5])) && mouseY>posit[i][1] && mouseY<(posit[i][1] + abs(nimg[i].height/posit[i][5]))){
       curse = 1;
     /*MouseClick*/
        if (mousePressed && (mouseButton == LEFT)) {
          navigate(i);
        }
     }
  }//for

  //Make things look clickable!
   if(curse){cursor(HAND);}else{cursor(ARROW);}

  //Javascript interaction
   dt = int(dst);
   if(desti!=dt){
     setDestination(dt,0);
     desti = dt;
   }
   //Landing pad
   if(desti!=0 && desti!=4){
   noFill();
   stroke(#EFF1EF);
   rect((desti*ww/4.0)-120,100,225,99,10);
   }
}

void setDestination(int s, int i){
 switch(s){
  case 1:
    for(int j = 0; j<3; j++){
      dest[j][0] = ((ww/4.0)-105)+(70*j);
      dest[j][1] = random(120,140);
      dest_dist = dist(dest[i][0],posit[j][0],dest[j][1],posit[j][1]);
      speed_scale = dest_dist/20;
      posit[j][2] = (dest[j][0]-posit[j][0])/speed_scale;
      posit[j][3] = (dest[j][1]-posit[j][1])/speed_scale;
      posit[j][4] = 1;
    }
    posit[3][4] = 0;
    posit[4][4] = 0;
    posit[5][4] = 0;
    break;
  case 2:
    for(int j = 2; j<5; j++){
        dest[j][0] = ((2.0*ww/4.0)-105)+(70*(j-2));
        dest[j][1] = random(130, 140);
        dest_dist = dist(dest[j][0],posit[j][0],dest[j][1],posit[j][1]);
        speed_scale = dest_dist/20;
        posit[j][2] = (dest[j][0]-posit[j][0])/speed_scale;
        posit[j][3] = (dest[j][1]-posit[j][1])/speed_scale;
        posit[j][4] = 2;
    }
    posit[0][4] = 0;
    posit[1][4] = 0;
    posit[5][4] = 0;
    break;
  case 3:
     for(int j = 3; j<6; j++){
        dest[j][0] = ((3.0*ww/4.0)-105)+(70*(j-3));
        dest[j][1] = random(130, 140);
        dest_dist = dist(dest[j][0],posit[j][0],dest[j][1],posit[j][1]);
        speed_scale = dest_dist/20;
        posit[j][2] = (dest[j][0]-posit[j][0])/speed_scale;
        posit[j][3] = (dest[j][1]-posit[j][1])/speed_scale;
        posit[j][4] = 3;
    }
    posit[0][4] = 0;
    posit[1][4] = 0;
    posit[2][4] = 0;
    break;
  case 4:
       for(int j = 0; j<6; j++){
        posit[j][4] = 0;
    }
    break;

  default:
      dest[i][0] = random(0, ww-58);
      dest[i][1] = random(0, 140);
      dest_dist = dist(dest[i][0],posit[i][0],dest[i][1],posit[i][1]);
      speed_scale = random(dest_dist,2*dest_dist);
      posit[i][2] = (dest[i][0]-posit[i][0])/speed_scale;
      posit[i][3] = (dest[i][1]-posit[i][1])/speed_scale;
      posit[i][4] = 0;
    break;
 }
}



