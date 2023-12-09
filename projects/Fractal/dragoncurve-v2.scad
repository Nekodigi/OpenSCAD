//https://www.printables.com/model/255883-parametric-dragon-curve
// Line thickness (percentage)
thick = 100; // [1:100]
// Order
order = 15; // [1:15]
// Final width
finwidth = 150;
// Extrusion thickness
depth = 3; // [0:10]
// Smoothness
$fn = 16; // [4:Ultra-Rough, 16:Rough, 32:Fine, 64:Ultra-Fine]

baselen = 100 + 0; // Hidden from customizer
oost = 1/sqrt(2); // one over square root 2, calculate it once here so we can save time in the loop

module dragon(order) {
	if(order>0) {
		union(){
			scale([oost,oost])
				rotate([0,0,225])
					translate([-baselen,0])
						dragon(order-1);
			scale([oost,oost])
				rotate([0,0,315])
					translate([-baselen,0])
						dragon(order-1);
		};
	}
	else {
		union() {
			hull(){
				translate([0,baselen])
					square(thick);
				translate([0,0])
					square(thick);
			};
			hull(){
				translate([0,0])
					square(thick);
				translate([baselen,0])
					square(thick);
			};
		};
	}		
}

linear_extrude(depth)
	resize([finwidth,0], auto=true)
		dragon(order-1); // zero indexed
