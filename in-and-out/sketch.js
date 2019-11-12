const width = 1080;
const height = 1080;
const sideLengthFactor = 0.9; // with respect to min(width, height)
const loopDuration = 10000;
const strokeWidthFactor = 5.0 / 1080.0; // equals a stroke width of 6 on 1080x1080

const sideLength = Math.min(width, height) * sideLengthFactor;

function setup() {
    createCanvas(width, height);
    stroke(255);
    strokeWeight(Math.min(width, height) * strokeWidthFactor);
}

function draw() {
    background(0);
    const cx = width / 2.0;
    const cy = height / 2.0;
    const triangleHeight = sideLength * sqrt(3.0) / 2.0;
    harom(
        cx + sideLength / 2.0, cy + triangleHeight / 2.0,
        cx - sideLength / 2.0, cy + triangleHeight / 2.0,
        6,
        (sin(((PI) * millis() / loopDuration) % (2 * PI)) + 1) / 2
    );
}

function harom(ax, ay, bx, by, level, ratio) {
    if (level !== 0) {
        const vx = bx - ax;
        const vy = by - ay;
        const nx = cos(PI / 3) * vx - sin(PI / 3) * vy;
        const ny = sin(PI / 3) * vx + cos(PI / 3) * vy;
        const cx = ax + nx;
        const cy = ay + ny;
        line(ax, ay, bx, by);
        line(ax, ay, cx, cy);
        line(cx, cy, bx, by);
        harom(
            ax * ratio + cx * (1 - ratio),
            ay * ratio + cy * (1 - ratio),
            ax * (1 - ratio) + bx * ratio,
            ay * (1 - ratio) + by * ratio,
            level - 1,
            ratio
        );
    }
}
