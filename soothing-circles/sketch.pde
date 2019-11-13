int n, s, f1, f2, f3;

void setup() { 
    initSize();
    background(20);
    smooth();
    noFill();
    stroke(255);
    strokeWeight(3);
    
    n = 500;   //number of ellipse per circle
    m = 10;    //magnitude of waves
    f1 = 2000; //f general
    f2 = 2;    //f of rotation
    f3 = 5;    //f of waves
}

void draw() {
    background(20);
    float t = millis()/f1;

    translate(width/2, height/2);
    scale(min(width, height) / 512.0);

    paintCircle(t, 0);
    paintCircle(t, PI);
}

void paintCircle(float t, int o) {
    beginShape();
    for(int i = 0; i <= n; i++) {
        float p = (i/n)*TWO_PI;
        
        int x = sin(p+t) * (200+sin((t*f2+p)*f3+o)*m*(1-sin(p)));
        int y = cos(p+t) * (200+sin((t*f2+p)*f3+o)*m*(1-sin(p)));
    
        vertex(x, y);
    }
    endShape();
}

void initSize() {
    const urlSearchParams = new URLSearchParams(window.location.search);
    int w, h;
    if( urlSearchParams.has("width") ) {
        w = Number.parseInt(urlSearchParams.get("width"));
    } else {
        w = 512;
    }
    if( urlSearchParams.has("height") ) {
        h = Number.parseInt(urlSearchParams.get("height"));
    } else {
        h = 512;
    }
    size(w,h);
}
