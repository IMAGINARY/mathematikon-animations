function setup() {
    createCanvas(540, 540);
    strokeWeight(3);
}

function draw() {
    background(240);
    harom(500, 460, 40, 460, 6, (sin(0.0005 * millis() % (2 * PI)) + 1) / 2);
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
