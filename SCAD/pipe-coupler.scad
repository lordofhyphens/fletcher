$fn=90;


module coupler_half(shaft, rod) {
difference() {
cylinder(d=22, h=40);

for (i = [10, 30]) {
    translate([0,0,i])
    difference() {
        cylinder(d=22, h=15, center=true);
        cylinder(d=20, h=15, center=true);
    }
}

cylinder(d=rod, h=20);
translate([0,0,25])cylinder(d=shaft, h=20);
translate([49.5,0,0])cube([100,100,100], center=true);
}
}

coupler_half(5, 8);
translate([50,0,0])
coupler_half(5, 5);
