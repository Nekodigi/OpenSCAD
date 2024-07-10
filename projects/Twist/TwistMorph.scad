function circleVec(theta) = [cos(theta), sin(theta)];
function sampleCircleMorph(n, fac, theta) = let(angle = 360/n,
mod = theta % angle / angle,
posSV = circleVec(floor(theta/angle)*angle),
posEV = circleVec(ceil(theta/angle)*angle)
) circleVec(theta)*fac + 
    (posSV*(1-mod) + posEV*mod)*(1-fac);

function circleMorph(n, r, fac, res) = [for(i=[0:res-1]) sampleCircleMorph(n, fac, i/res*360)*r];
    
for(i=[0:10])translate([0,0,i*2])rotate([0,0,i*5])scale(1-i/30)polygon(circleMorph(3, 10, i/10, 60));
    
for(i=[0:10])translate([0,0,i*2+20])rotate([0,0,i*5])scale(0.7+i/30)polygon(circleMorph(5, 10, 1-i/10, 60));