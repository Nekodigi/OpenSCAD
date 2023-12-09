r = 50;

delta = 0.001;
PI = 3.141592;
res = 300;
w = 360/res;
echo(w);

function index(i, j) = i + j * res;
function superShape(theta, a=1, b=1, m=7, n1=0.2, n2=1.7, n3=1.7) = pow(pow(abs(1/a*cos(m*theta/4)), n2) + pow(abs(1/b*sin(m*theta/4)), n3), -1/n1);

function x(theta, phi) = superShape(theta)*cos(theta)*superShape(phi)*cos(phi);
function y(theta, phi) = superShape(theta)*sin(theta)*superShape(phi)*cos(phi);
function z(phi) = superShape(phi)*sin(phi);
points=[
    for(phi = [-90:w:90+w-delta])
        for(theta = [-180:w:180+w-delta])
            [x(theta, phi)*r, y(theta, phi)*r, z(phi)*r]
  ];
        
faces=[
    for(phi = [0:res/2])
        for(theta = [0:res])
            [index(theta, phi), index(theta, phi+1), index(theta+1, phi+1), index(theta+1, phi)]  
  ];


polyhedron(points=points, faces=faces);
        