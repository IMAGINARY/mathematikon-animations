float t;
float angle =0;
int NUM_LINES = 380;
float v1 =0.4;
float v2;
boolean increment = false;
float fator =0.00001;

void setup(){
background(20);
size(1080,1080);
initV1();
smooth(2);
}

void draw(){
  background(0);
  angle+= 0.01;
  stroke(255,200);

  translate(width/2, height/2);
  scale(min(width,height)/500.0);
 rotate(sin(angle));
  
  for(int i=1; i < NUM_LINES; i++){
     strokeWeight(4);
  point(x(t+i), y(t+i));
    point(x2(t+i), y2(t+i));
    
    strokeWeight(1.2);
    
    
    
    line(x(t+i),y(t+i),x2(t+i),y2(t+i));}
  
  t += 0.005;
 
 if(increment)    v1+=fator;
  
}

void initV1() {
    const urlSearchParams = new URLSearchParams(window.location.search);
    if(urlSearchParams.has("v1")) {
        setV1(Number.parseFloat(urlSearchParams.get("v1")));
    } else {
        randomizeV1();
    }
}

void setV1(float new_v1) {
    v1 = new_v1;
    console.log("v1:", v1);
}

void randomizeV1() {
    setV1(random(0.4)+0.2);
}

void mousePressed() {
    randomizeV1();
}


void keyReleased(){

increment = false;
}


void keyPressed() {


  if(key == ' '){
      randomizeV1();
  }

  
  
    if (keyCode == LEFT) {
increment = true;
         fator = -0.00001;
    } else if (keyCode == RIGHT) {
increment = true;
      fator = 0.00001;
    } 
    
     if (keyCode == UP) {

         NUM_LINES+=1;
         println("Lines: "+NUM_LINES);
    } else if (keyCode == DOWN) {

      NUM_LINES-=1;
			println("Lines: "+NUM_LINES);
    }  
     
     
     
     
}



float x(float t){

return sin(t/10)*100 + cos(t/v1)*100;
}


float y(float t){

return cos(t/10)*100 + sin(t/v1)*100;
}





float x2(float t){

return sin(t/10)*10 + cos(t/v1)*100;
}


float y2(float t){

return cos(t/10)*10 + sin(t/v1)*100;
}
