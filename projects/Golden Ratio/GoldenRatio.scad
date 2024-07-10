
r = 0.04;
d = 30;
n = 400;
ga = (1+sqrt(5))/2;
off = 0;
echo(ga);

for(i = [0 : n]){
    a = (i+off) * ga* 360;
    rotate([0, 0, a])
    translate([a/1000, 0, 0])
    sphere(r*sqrt(a), $fn=6);
}

