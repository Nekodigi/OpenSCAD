use <util/rand.scad>
use <experimental/circle_packing.scad>

file = "JapanMaple.svg";

h = 3;
rf = 3;
s = 1;
t = 0.5;
size = [150, 150];
min_radius = 1;
point_numbers = 60;
    
points = [
    for(i = [0:point_numbers - 1])
    [rand(-size.x/2, size.x/2), rand(-size.y/2, size.y/2)]
]; 

circles = circle_packing(points, min_radius);

linear_extrude(height = h)
union(){
    difference(){    
        scale(s)
        import(file, center=true);
        for(c = circles) {
            translate(c[0])
                //sphere(c[1], $fn = 48);
            circle(c[1]-t, $fn = 48);
        }
    }
    difference(){
        minkowski(){
            scale(s)
            import(file, center=true);
            circle(rf);
        }
        scale(s)
        import(file, center=true);
    }
}

//linear_extrude(height = h)
        