$fn=90;

difference() {
cylinder(d=22, h=40);

for (i = [10, 30]) {
    translate([0,0,i])
    difference() {
        cylinder(d=22, h=15, center=true);
        cylinder(d=20, h=15, center=true);
    }
}

cylinder(d=8, h=20);
translate([0,0,25])cylinder(d=5, h=20);
translate([49.5,0,0])cube([100,100,100], center=true);
}
