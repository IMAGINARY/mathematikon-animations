/*
  based on: https://observablehq.com/@rreusser/instanced-webgl-circles
*/
// 设置一些常量
final int MAX_CIRCLE_CNT = 2500, MIN_CIRCLE_CNT = 100,
    MAX_VERTEX_CNT = 30, MIN_VERTEX_CNT = 3;

final float SCALE = 450;
final int LOOPFRAMES = 60 * 20 * 4; // should be multiple of 4

// 设置两个全局变量
// 画面中圆的个数，以及构成圆的顶点的个数
int circleCnt, vertexCnt;
void setup() {
    size(1080, 1080);
    frameRate(60);
    strokeWeight(2);
}

void draw() {
    background(0);
    translate(width / 2, height / 2);

    //updateCntByMouse();
    updateCntByFrameCount();

    // 渲染每一个圆
    for (int ci = 0; ci < circleCnt; ci++) {
        float time = float(frameCount) / 75;
        float thetaC = map(ci, 0, circleCnt, 0, TAU);

        // 获得每一个圆的圆心、半径、颜色
        PVector circleCenter = getCenterByTheta(thetaC, time, SCALE);
        float circleSize = getSizeByTheta(thetaC, time, SCALE);
        color c = getColorByTheta(thetaC, time);

        // 绘制每一圆的所有顶点

        stroke(c);
        noFill();
        beginShape();
        for (int vi = 0; vi < vertexCnt; vi++) {
            float thetaV = map(vi, 0, vertexCnt, 0, TAU);
            float x = circleCenter.x + cos(thetaV) * circleSize;
            float y = circleCenter.y + sin(thetaV) * circleSize;
            vertex(x, y);
        }
        endShape(CLOSE);
    }
}

void updateCntByMouse() {
    float xoffset = abs(mouseX - width / 2), yoffset = abs(mouseY - height / 2);
    circleCnt = int(map(xoffset, 0, width / 2, MAX_CIRCLE_CNT, MIN_CIRCLE_CNT));
    vertexCnt = int(map(yoffset, 0, height / 2, MAX_VERTEX_CNT, MIN_VERTEX_CNT));
}

void updateCntByFrameCount() {
    int frameInLoop = frameCount % LOOPFRAMES;
    int framesInPhase = int(LOOPFRAMES / 4);
    int phase = int(frameInLoop / framesInPhase); // 0-3
    int frameInPhase = frameInLoop % framesInPhase;

    if(phase == 0) {
        circleCnt = MAX_CIRCLE_CNT;
        vertexCnt = int(map(frameInPhase, 0, framesInPhase - 1, MAX_VERTEX_CNT, MIN_VERTEX_CNT));
    } else if(phase == 1) {
        circleCnt = int(map(frameInPhase, 0, framesInPhase - 1, MAX_CIRCLE_CNT, MIN_CIRCLE_CNT));;
        vertexCnt = MIN_VERTEX_CNT;
    } else if(phase == 2) {
        circleCnt = MIN_CIRCLE_CNT;
        vertexCnt = int(map(frameInPhase, 0, framesInPhase - 1, MIN_VERTEX_CNT, MAX_VERTEX_CNT));
    } else if(phase == 3) {
        circleCnt = int(map(frameInPhase, 0, framesInPhase - 1, MIN_CIRCLE_CNT, MAX_CIRCLE_CNT));;
        vertexCnt = MAX_VERTEX_CNT;
    }

    console.log("Phase=", phase, ", circleCnt=", circleCnt, ", vertexCnt=", vertexCnt);
}

PVector getCenterByTheta(float theta, float time, float scale) {
    PVector direction = new PVector(cos(theta), sin(theta));
    float distance = 0.6 + 0.2 * cos(theta * 6.0 + cos(theta * 8.0 + time));
    PVector circleCenter =PVector.mult(direction, distance * scale);
    return circleCenter;
}

float getSizeByTheta(float theta, float time, float scale) {
    float offset = 0.2 + 0.12 * cos(theta * 9.0 - time * 2.0);
    flaot circleSize = scale * offset;
    return circleSize;
}

color getColorByTheta(float theta, float time) {
    float th = 8.0 * theta + time * 2.0;
    float r = 0.6 + 0.4 * cos(th),
        g = 0.6 + 0.4 * cos(th - PI / 3),
        b = 0.6 + 0.4 * cos(th - PI * 2.0 / 3.0),
        alpha = map(circleCnt, MIN_CIRCLE_CNT, MAX_CIRCLE_CNT, 150, 30);
    return color(r * 255, g * 255, b * 255, alpha);
}
