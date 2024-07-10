include <array.scad>

function pos2M(pos) = posSca2M(pos, [1,1,1]);
function sca2M(scale) = posSca2M([0,0,0], scale);

function posSca2M(pos, scale) = 
[
 [scale.x, 0, 0, 0],
 [0, scale.y, 0, 0],
 [0, 0, scale.z, 0],
 [pos.x, pos.y, pos.z, 1]
];

function rot2M(angles) = let(
    cz = cos(angles.z),
    sz = sin(angles.z),
    cy = cos(angles.y),
    sy = sin(angles.y),
    cx = cos(angles.x),
    sx = sin(angles.x),
    m11 = cz * cy,
    m12 = -sz * cx + cz * sy * sx,
    m13 = sz * sx + cz * sy * cx,
    m21 = sz * cy,
    m22 = cz * cx + sz * sy * sx,
    m23 = -cz * sx + sz * sy * cx,
    m31 = -sy,
    m32 = cy * sx,
    m33 = cy * cx
) [
    [m11, m12, m13, 0],
    [m21, m22, m23, 0],
    [m31, m32, m33, 0],
    [0, 0, 0, 1]
];

function transformV(v, pos, rot, scale) = slice(concat(v,[1])*sca2M(scale)*rot2M(rot)*pos2M(pos), 0,2);

function rotateV(v, angle) = slice(rot2M(angle)*concat(v,[1]), 0,2);

function rotateVs(vs, angle) = [for(i=[0:len(vs)-1])rotateV(vs[i], angle)];
    
function transformVs(vs, pos, rot, scale) = [for(i=[0:len(vs)-1])transformV(vs[i], pos, rot, scale)];
    

    
//echo([1,1,1,1][[0:1]]);
echo(transformV([0,1,0], [1, 1, 1], [45,0,0], [1,1,1]));
echo([1,1,1,1]*pos2M([10, 10, 1]));
/*function rotateEuler(v, x, y, z) = let(cx = cos(x), sx = sin(x), cy = cos(y), sy = sin(y), cz = cos(z), sz = sin(z))
[
    v[0] * (cy * cz) + v[1] * (-cy * sz) + v[2] * sy,
    v[0] * (cx * sz + sx * sy * cz) + v[1] * (cx * cz - sx * sy * sz) + v[2] * -sx * cy,
    v[0] * (sx * sz - cx * sy * cz) + v[1] * (sx * cz + cx * sy * sz) + v[2] * cx * cy
];
*/