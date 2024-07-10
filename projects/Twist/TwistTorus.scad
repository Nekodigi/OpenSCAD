//MORPH
function circleVec(theta) = [cos(theta), sin(theta)];
function sampleCircleMorph(n, fac, theta) = let(angle = 360/n,
mod = theta % angle / angle,
posSV = circleVec(floor(theta/angle)*angle),
posEV = circleVec(ceil(theta/angle)*angle)
) circleVec(theta)*fac + 
    (posSV*(1-mod) + posEV*mod)*(1-fac);

function circleMorph(n, r, fac, res) = [for(i=[0:res-1]) sampleCircleMorph(n, fac, i/res*360)*r];
    

//ARRAY
function cat(L1, L2) = [for (i=[0:len(L1)+len(L2)-1]) 
                        i < len(L1)? L1[i] : L2[i-len(L1)]] ;
function setZ(vs, z) = [for(i=[0:len(vs)-1])[vs[i][0],vs[i][1],z]];
module patch(p1, p2){
    lp = len(p1);
    sideFaces = [for(i=[0:len(p1)-1])[(i+1)%lp, i, 
        i+lp, (i+1)%lp+lp]];
    downFaces = [for(i=[0:lp/2-2])[i,i+1,lp-2-i,lp-1-i]];
    topFaces = [for(i=[0:lp/2-2])[lp+i+1,lp+i,lp+lp-1-i,lp+lp-2-i]];
    
    polyhedron(cat(p1,p2), cat(sideFaces,cat(downFaces, topFaces)));
}

//ROTATE
function rotateEuler(v, roll, pitch, yaw) = [
    v.x * (cos(pitch) * cos(yaw)) + v.y * (cos(roll) * sin(yaw) - sin(roll) * sin(pitch) * cos(yaw)) +
        v.z * (sin(roll) * sin(yaw) + cos(roll) * sin(pitch) * cos(yaw)),
    
    v.x * (cos(pitch) * sin(yaw)) + v.y * (cos(roll) * cos(yaw) + sin(roll) * sin(pitch) * sin(yaw)) +
        v.z * (sin(roll) * cos(yaw) - cos(roll) * sin(pitch) * sin(yaw)),
    
    -v.x * sin(pitch) + v.y * sin(roll) * cos(pitch) + v.z * cos(roll) * cos(pitch)
];
function rotateEulerVs(vs, roll, pitch, yaw) = [for(i=[0:len(vs)-1])rotateEuler(vs[i], roll, pitch, yaw)];


n = 10;
h = 2;
twist = 10;
union(){
for(i=[0:n-1])patch(rotateEulerVs(setZ(circleMorph(3, 10, i/10, 60), i*h), 0, 0, i*twist), 
    
rotateEulerVs(setZ(circleMorph(3, 10, (i+1)/10, 60), (i+1)*h), 0, 0, (i+1)*twist));
}
//for(i=[0:10])translate([0,0,i*2])rotate([0,0,i*5])scale(1-i/30)polygon(circleMorph(3, 10, i/10, 60));
//for(i=[0:10])translate([0,0,i*2+20])rotate([0,0,i*5])scale(0.7+i/30)polygon(circleMorph(5, 10, 1-i/10, 60));