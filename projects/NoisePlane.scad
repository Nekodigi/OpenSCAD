
use <noise/nz_perlin2.scad>
use <surface/sf_thicken.scad>


n = 50;
s = 100;
ns = 0.03;
h = 20;
thickness = 1;


/*for(i = [0:n]){
    for(j = [0:n]){
        translate([i,j,0]);
        x = i/n*s;
        y = j/n*s;
        v = nz_perlin2(x, y, 0);
        translate([i, j, 0])
        cube([1,1,(v+1)*5]);
        
    }
}*/

for(i = [0:n]){
    x = i/n*s;
    translate([0,0,x])
    linear_extrude(thickness)
    sinex(x*ns);
    
    
    translate([x,0,0])
    rotate([0, -90, 0])
    linear_extrude(thickness)
    siney(x*ns);
}

module sinex(offset) {
    points = [for(j = [0:n])
            let(
                x = 0,
                y = j/n*s,
                n = nz_perlin2(offset, y*ns, 0)*h+h
            )
            [y, n]];
    revPoly = reverse(offset(points, [offset, thickness]));
    points1 = concat(points, revPoly);
    //echo(points);
    polygon(points=points1);
}

module siney(offset) {
    points = [for(j = [0:n])
            let(
                x = 0,
                y = j/n*s,
                n = nz_perlin2(y*ns, offset, 0)*h+h
            )
            [y, n]];
    revPoly = reverse(offset(points, [offset, thickness]));
    points1 = concat(points, revPoly);
    //echo(points);
    polygon(points=points1);
}


//echo(offset([[10, 20], [20, 30]], [1, 0]));

function offset(vecs, off) = [for(vec=vecs)vec+off];
    
function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];

