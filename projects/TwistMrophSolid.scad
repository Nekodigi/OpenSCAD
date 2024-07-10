include <libs/array.scad>
include <libs/morph.scad>
include <libs/geom.scad>
include <libs/rotate.scad>
    
//mesh can be rim and n patch.
//rim -> minkowski
//openscad have multmatrix.
    

//translate([0,0,i*2])rotate([0,0,i*5])scale(1-i/30)

nh=30;
tnh=20;

h = 5;
facOff = 0;
n = 5;
twist = 360/n/nh;
res = 50;
r = 40;
th = 2;



//NpatchWF([for(i=[0:nh])let(fac=(nh-i)/tnh)rotateVs(setZ(circleMorph(n, r*(0.3+fac*0.5), 1-fac, res), i*h), [0,0,i*twist])], 1);
//translate([0,0,nh*h])
NpatchWF([for(i=[0:nh])let(
    fac=(-i)/tnh, 
    vs=circleMorph(4, r*(0.3-fac*0.5), 1+fac+facOff, res),
    tsf = transformVs(setZ(vs, 0), [0,pow(i/3, 2),i*h], [i/nh*90,0,i*twist], [1,1,1])
)
tsf ], 1);
//problematic of hull!
/*difference(){
for(i=[0:nh]){
    hull(){//i*h
    translate([0,0,i*h])linear_extrude(0.1)offset(3)polygon(rmvZ(rotateVs(setZ(circleMorph(n, r, i/tnh+facOff, res), 0), [0,0,i*twist])));

    translate([0,0,(i+1)*h])linear_extrude(0.1)offset(3)polygon(rmvZ(rotateVs(setZ(circleMorph(n, r, (i+1)/tnh+facOff, res), 0), [0,0,(i+1)*twist])));
    }
}
for(i=[0:nh]){
    hull(){//i*h
    translate([0,0,i*h])linear_extrude(0.1)polygon(rmvZ(rotateVs(setZ(circleMorph(n, r, i/tnh+facOff, res), 0), [0,0,i*twist])));

    translate([0,0,(i+1)*h])linear_extrude(0.1)polygon(rmvZ(rotateVs(setZ(circleMorph(n, r, (i+1)/tnh+facOff, res), 0), [0,0,(i+1)*twist])));
    }
}
}*/
    
/*for(i=[0:10])translate([0,0,i*2+20])rotate([0,0,i*5])scale(0.7+i/30)polygon(circleMorph(5, 10, 1-i/10, 60));*/

// Example usage
original_vector = [1, 1, 0];
//line([0,0,0], rotateEuler(original_vector, 0, 0, 4)*10);
//polygon(rmvZ(rotateEulerVs(setZ(circleMorph(3, 10, 0.3, 12), 0), 0, 0, 20)));
//echo(rmvZ(rotateEulerVs(setZ(circleMorph(3, 10, 0, 12), 0), 0, 0, 0)));


module line(start, end, thickness = 1) {
    hull() {
        translate(start) cube(thickness);
        translate(end) cube(thickness);
    }
}

// Output the result
//echo(rotated_vector);