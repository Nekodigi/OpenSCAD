function circleVec(theta) = [cos(theta), sin(theta)];
function sampleCircleMorph(n, fac, theta) = let(angle = 360/n,
mod = theta % angle / angle,
posSV = circleVec(floor(theta/angle)*angle),
posEV = circleVec(ceil(theta/angle)*angle)
) circleVec(theta)*fac + 
    (posSV*(1-mod) + posEV*mod)*(1-fac);

function circleMorph(n, r, fac, res) = [for(i=[0:res-1]) sampleCircleMorph(n, fac, i/res*360)*r];
    