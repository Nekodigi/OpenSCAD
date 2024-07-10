r = 50;
n = 3;
repY = 30;
ntwist = 2;
rotStep = -45/repY;

h = 80;
twist = 360/n/repY*ntwist;
nx = 10;
ny = 1;
ns = 10;
thickness = 2;
d = 400;


for(j = [0:repY-1]){
    union(){
    for(i = [1:n]){
        jn = j+1;
        t1 = 360/n*(i-1) + j*twist;
        t2 = 360/n*i     + j*twist;
        v = [r, 0, 0];
        dh = [0,0,h];
        dd = [d, 0, 0];
        sLt = rotateEuler(v, 0, 0, t1)+dd;
        sL = rotateEuler(sLt, 0, rotStep*j, 0);
        sRt = rotateEuler(v, 0, 0, t2)+dd;
        sR = rotateEuler(sRt, 0, rotStep*j, 0);
        eLt = rotateEuler(v, 0, 0, t1+twist)+dd;
        eL = rotateEuler(eLt, 0, rotStep*jn, 0);
        eRt = rotateEuler(v, 0, 0, t2+twist)+dd;
        eR = rotateEuler(eRt, 0, rotStep*jn, 0);
        mesh(sL, sR, eL, eR, nx, ny, thickness);
    }
    }
}


module mesh(startL, startR, endL, endR, nx, ny, thickness = 1){
    union(){
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


function rotateEuler(v, roll, pitch, yaw) = [
    v.x * (cos(pitch) * cos(yaw)) + v.y * (cos(roll) * sin(yaw) - sin(roll) * sin(pitch) * cos(yaw)) +
        v.z * (sin(roll) * sin(yaw) + cos(roll) * sin(pitch) * cos(yaw)),
    
    v.x * (cos(pitch) * sin(yaw)) + v.y * (cos(roll) * cos(yaw) + sin(roll) * sin(pitch) * sin(yaw)) +
        v.z * (sin(roll) * cos(yaw) - cos(roll) * sin(pitch) * sin(yaw)),
    
    -v.x * sin(pitch) + v.y * sin(roll) * cos(pitch) + v.z * cos(roll) * cos(pitch)
];