w = 50;
nx = 10;
ny = 20;
up = [0,0,w];
down = [0,0,-w];

TR = [w/2, w/2, 0];
DR = [w/2, -w/2, 0];
DL = [-w/2, -w/2, 0];
TL = [-w/2, w/2, 0];

rectLoop = [TR, DR, DL, TL];

//mesh(TR+down, DR+down, DR+up, DL+up, n);

union(){
for(i = [0:3]){
    mesh(rectLoop[i]+down, rectLoop[(i+1)%4]+down, rectLoop[(i+1)%4]+up, rectLoop[(i+2)%4]+up, nx, ny);
}
}


/*for(i = [0:n]){
    x = i/n*w - w/2;
    pairLine([x,w/2,0], [-w/2,x,50]);
    pairLine([-w/2,x,0], [-x,-w/2,50]);
    pairLine([-x,-w/2,0], [w/2,-x,50]);
    pairLine([w/2,-x,0], [x,w/2,50]);
    //line([x,w/2,0], [-w/2,x,50]);
    //line([x,w/2,0], [-w/2,x,50]);
}*/


module mesh(startL, startR, endL, endR, nx, ny, thickness = 1){
    for(i = [0:nx]){
        x = i/nx;
        start = startL*x + startR*(1-x);
        end = endL*x + endR*(1-x);
        line(start, end, thickness);
    }
    for(i = [0:ny]){
        x = i/ny;
        L = startL*x + endL*(1-x);
        R = startR*x + endR*(1-x);
        line(L, R, thickness);
    }
}

module pairLine(start, end, thickness = 1){
    line(start, end, thickness);
    cstart = [start[0], start[1], end[2]];
    cend = [end[0], end[1], start[2]];
    line(cstart, cend, thickness);
}

module line(start, end, thickness = 1) {
    hull() {
        translate(start) sphere(thickness);
        translate(end) sphere(thickness);
    }
}

