
n = 30;
r = 20;
h = 80;

union(){
cylinder(2, r+1, r-2);
for(i = [0: n]){
    rotate([0, 0, i/n*360])
    translate([r, 0, 0])
    rotate([40, 0, -40])
    cube([1,1, h]);
    
    rotate([0, 0, i/n*360])
    translate([r, 0, 0])
    rotate([-40, 0, 40])
    cube([1,1, h]);
}
}


