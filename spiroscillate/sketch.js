// sin(), cos(), spiral, oscillate, sunflower, starfish

const size = 1080;
const strokeWidthFactor = 3.0 / 1080.0; // equals a stroke width of 6 on 1080x1080

const num = 200;
let ang, incr, rad, mult,
    radSpiral, xIn, yIn, x, y;
let c1, c2;

function setup() {
    createCanvas(size, size);
    strokeWeight(strokeWidthFactor * size);
    rad = (width / 2) - 10;
    incr = 4.15741;
    c1 = color(255, 255);
    c2 = color(20, 0);
}

function draw() {
    background(0);

    xIn = width / 2;
    yIn = height / 2;

    for (let i = 1; i < num; i++) {
        ang = i * incr;
        mult = i / float(num);
        radSpiral = mult * rad;
        x = width / 2 + cos(ang) * radSpiral;
        y = height / 2 + sin(ang) * radSpiral;

        stroke(lerpColor(c2, c1, mult));
        line(xIn, yIn, x, y);

        xIn = x;
        yIn = y;
    }
    incr += .00013 * sin(TWO_PI * frameCount / 1500);
}
