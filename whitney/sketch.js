const width = 1080;
const height = 1080;
const dotDiameter = 20;
const wheelDiameter = 900;
const numCircles = 24;
const lineWidth = 4;
const turnaroundDuration = 2500; // milliseconds the outermost dot needs to complete one turn

let alpha = 0.0;

function setup() {
    createCanvas(width, height);
    stroke(255);
}

function draw() {
    background(0);

    const radians = (millis() / turnaroundDuration) * 2.0 * PI;
    const points = [];
    for (let i = 0; i < numCircles; ++i) {
        const x = width / 2 + ((i + 1) / numCircles) * wheelDiameter / 2 * cos(radians * (i / numCircles));
        const y = height / 2 - ((i + 1) / numCircles) * wheelDiameter / 2 * sin(radians * (i / numCircles));
        points.push({x: x, y: y});
    }

    strokeWeight(lineWidth);
    for (let i = 1; i < numCircles; ++i) {
        line(points[i - 1].x, points[i - 1].y, points[i].x, points[i].y);
    }

    strokeWeight(0);
    for (let p of points) {
        ellipse(p.x, p.y, dotDiameter);
    }
}
