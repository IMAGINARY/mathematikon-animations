// sin(), cos(), spiral, oscillate, sunflower, starfish

const num = 200;
let ang, incr, rad, mult,
    radSpiral, xIn, yIn, x, y;
let c1, c2;

function setup() {
    createCanvas(550, 550);
    rad = (width / 2) - 10;
    incr = 4.15741;
    c1 = color(0);
    c2 = color(225, 0);
}

function draw() {
    background(225);

    xIn = width / 2;
    yIn = height / 2;

    for (let i = 1; i < num; i++) {
        ang = i * incr;
        mult = i / float(num);
        radSpiral = mult * rad;
        x = width / 2 + cos(ang) * radSpiral;
        y = height / 2 + sin(ang) * radSpiral;

        stroke(lerpColor(c2, c1, mult));
        strokeWeight(.5);
        line(xIn, yIn, x, y);

        xIn = x;
        yIn = y;
    }
    incr += .00013 * sin(TWO_PI * frameCount / 1500);
}
