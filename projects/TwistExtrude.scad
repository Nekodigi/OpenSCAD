w = 30;
n = 5;
t = 2;
s = 2;


union(){
linear_extrude(height = 50, center = false, convexity = 10, twist = 90, $fn = 100, scale=s)
union(){
    for(i = [0:1/n:1]){
        translate([i*w-w/2, w/2])
        square(t, center=true);
        translate([w/2, i*w-w/2])
        square(t, center=true);
        translate([i*w-w/2, -w/2])
        square(t, center=true);
        translate([-w/2, i*w-w/2])
        square(t, center=true);
    }
}
cube([w+t, w+t, 2], center=true);

difference(){
    translate([0,0,50])
    cube([w*s + t*s, w*s + t*s, 2], center=true);
    translate([0,0,50])
    cube([w*s - t*s, w*s - t*s, 3], center=true);
}
}