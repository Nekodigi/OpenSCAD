function catVs(vs) = [for(j=[0:len(vs)-1])
    for(i=[0:len(vs[j])-1])vs[j][i] ];
function setZ(vs, z) = [for(i=[0:len(vs)-1])[vs[i][0],vs[i][1],z]];
function rmvZ(vs) = [for(i=[0:len(vs)-1])[vs[i][0],vs[i][1]]];
function slice(v,s,e) = [for(i=[s:e])v[i]];
function sum(v) = [for(p=v) 1]*v;
function avg(v) = sum(v)  / len(v);
function add(v,x) = [for(i=[0:len(v)-1])(v[i]+x)];
function addVs(vs,x) = [for(j=[0:len(vs)-1])
    [for(i=[0:len(vs[j])-1])vs[j][i]+x]];
function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];
function reverseVs(list) = [for(j=[0:len(list)-1])
    [for (i = [len(list[j])-1:-1:0]) list[j][i]]];
function transpose(m) = // m is any rectangular matrix of objects
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
   