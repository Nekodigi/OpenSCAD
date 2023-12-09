
use <noise/nz_perlin2.scad>
use <surface/sf_thicken.scad>


n = 100;
s = 100;
ns = 0.02;
h = 50;
thickness = 3;


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

ripples();
module ripples() {

    sf = [
        for(i = [0:n])
        [
            for(j = [0:n])
            let(
                x = i/n*s,
                y = j/n*s,
                n = nz_perlin2(x*ns, y*ns, 0)*h
            )
            [x, y, n]
        ]
    ];

    sf_thicken(sf, thickness);
}