n = 16;
n2 = 11;
nh = 50;
step = 360;
r = 50;
variance = 5;
h = 50;

for(j=[0:1/nh:1]){
    points1 = [for(theta=[0:360/step:360])
        let(
            r_ = (r+variance*interpolation(sin(theta*n), sin(theta*n2), j)),
            x=r_*cos(theta),
            y=r_*sin(theta)
    )
    [x,y]];
    translate([0, 0, j*h])
    linear_extrude(h/nh)
    polygon(points=points1);
}

function interpolation(a, b, fac) = a*(1-fac)+b*fac;

//function mult(vec, mult) = [for(x=mult)x*mult];
