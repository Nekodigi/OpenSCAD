include <math.scad>
include <array.scad>


module patch(p1, p2){
    lp = len(p1);
    sideFaces = [for(i=[0:len(p1)-1])[next(i, lp), i, 
        i+lp, next(i, lp)+lp]];
    downFaces = [for(i=[0:lp-1])[i,next(i, lp),lp*2]];
    topFaces = [for(i=[0:lp-1])[next(i, lp)+lp,i+lp,lp*2+1]];
    
    polyhedron(concat(p1,p2,[avg(p1),avg(p2)]), concat(sideFaces,downFaces,topFaces));
}
module Npatch(ps){
    lp = len(ps[0]);
    sideFacesOrig = [for(i=[0:lp-1])[next(i, lp), i, 
        i+lp, next(i, lp)+lp]];
    sideFaces = catVs([for(i=[0:len(ps)-2])addVs(sideFacesOrig, lp*i)]);
    downFaces = [for(i=[0:lp-1])[i,next(i, lp),lp*len(ps)]];
    topFaces = addVs([for(i=[0:lp-1])[next(i, lp),i,lp+1]], lp*(len(ps)-1));
    
    polyhedron(concat(catVs(ps), [avg(ps[0]),avg(ps[len(ps)-1])]), concat(sideFaces, downFaces, topFaces));
}

module NpatchWF(ps, thickness=1){
    for(P=ps)Nline(P, thickness, true);
    for(P=transpose(ps))Nline(P, thickness);
}

module patchShell(p1, p2, p3, p4){
    lp = len(p1);
    sf1 = [for(i=[0:len(p1)-2])[i, next(i, lp), next(i, lp)+lp*2, 
        i+lp*2]];
    sf2 = addVs(reverseVs(sf1), lp);
    echo(sf1);
    echo(reverseVs(sf1));
    downFaces = [for(i=[0:lp-1])[next(i,lp), i,i+lp, next(i,lp)+lp]];//[for(i=[0:lp-1])[i,next(i, lp),lp*2]];
    topFaces = addVs(reverseVs(downFaces), lp*2);//[for(i=[0:lp-1])[next(i, lp)+lp,i+lp,lp*2+1]];
    
    polyhedron(concat(p1,p2,p3,p4), concat(sf1,sf2,downFaces,topFaces));
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

module Nline(V, thickness = 1, loop=false) {
    union(){
    for(i=[0:len(V)-(loop?1:2)]){
        hull() {
            translate(V[i]) cube(thickness);
            translate(V[(i+1)%len(V)]) cube(thickness);
        }
    }
    }
}

module line(start, end, thickness = 1) {
    hull() {
        translate(start) cube(thickness);
        translate(end) cube(thickness);
    }
}

include <morph.scad>

module rim(r){
    difference(){
        offset(r)children();
        children();
    }
}

//Npatch([setZ(circleMorph(3, 10, 0, 3), 0), setZ(circleMorph(3, 12, 0, 3), 10), setZ(circleMorph(3, 10, 0, 3), 20), setZ(circleMorph(3, 12, 0, 3), 30)]);