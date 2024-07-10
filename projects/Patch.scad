include <libs/morph.scad>
    

function cat(L1, L2) = [for (i=[0:len(L1)+len(L2)-1]) 
                        i < len(L1)? L1[i] : L2[i-len(L1)]] ;
function setZ(vs, z) = [for(i=[0:len(vs)-1])[vs[i][0],vs[i][1],z]];

//assume len p1 and p2 are same
//len(p1) = 8+2n
module patch(p1, p2){
    lp = len(p1);
    p1avg = [for(p=p1) 1]*p1  / len(p1);
    p2avg = [for(p=p2) 1]*p2  / len(p2);
    sideFaces = [for(i=[0:len(p1)-1])[(i+1)%lp, i, 
        i+lp, (i+1)%lp+lp]];
    downFaces = [for(i=[0:lp-1])[i,(i+1)%lp,lp*2]];
    topFaces = [for(i=[0:lp-1])[(i+1)%lp+lp,i+lp,lp*2+1]];
    
    polyhedron(cat(cat(p1,p2),[p1avg,p2avg]), cat(sideFaces,cat(downFaces,topFaces)));
}

module patchShell(p1, p2, p3, p4){
    lp = len(p1);
    p1avg = [for(p=p1) 1]*p1  / len(p1);
    p2avg = [for(p=p2) 1]*p2  / len(p2);
    sideFaces = [for(i=[0:len(p1)-1])[(i+1)%lp, i, 
        i+lp, (i+1)%lp+lp]];
    downFaces = [for(i=[0:lp-1])[i,(i+1)%lp,lp*2]];
    topFaces = [for(i=[0:lp-1])[(i+1)%lp+lp,i+lp,lp*2+1]];
    
    polyhedron(cat(cat(p1,p2),[p1avg,p2avg]), cat(sideFaces,cat(downFaces,topFaces)));
}

//echo(setZ(circleMorph(3, 10, 1, 6), 10));
//echo(circleMorph(3, 10, 0, 6));
//polygon(circleMorph(3, 10, 1, 6));
//patch(setZ(circleMorph(3, 10, -0.5, 60), 0),setZ(circleMorph(3, 10, 2, 60), 100));