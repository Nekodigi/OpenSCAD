r = 50;
n = 5;
repY = 20;
ntwist = 5;

h = 8;
twist = 360/n/repY*ntwist;
nx = 10;
ny = 2;
ns = 10;

for(j = [1:repY]){
    translate([0, 0, h*(j-1)])
    rotate([0, 0, twist*(j-1)])
    for(i = [1:n]){
        t1 = 360/n*(i-1);
        t2 = 360/n*i;
        rs = (0.7+ 0.4*sin((j-1)*ns*1.9))*r;
        re = (0.7+ 0.4*sin(j*ns*1.9))*r;
        sL = [cos(t1)*rs, sin(t1)*rs, 0];
        sR = [cos(t2)*rs, sin(t2)*rs, 0];
        eL = [cos(t1+twist)*re, sin(t1+twist)*re, h];
        eR = [cos(t2+twist)*re, sin(t2+twist)*re, h];
        mesh(sL, sR, eL, eR, nx, ny);
    }
}


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
        translate(start) cube(thickness);
        translate(end) cube(thickness);
    }
}