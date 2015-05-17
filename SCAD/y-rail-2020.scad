use <inc/functions.scad>


module tsection() {
  rotate([90,0,0]){
    ext2020(l=40);
    translate([15,0,-20])cylinder(r=2.6,h=70,$fn=30);
    }
  rotate([90,0,0])
  { translate([-10,-10,-5])cube([20.01,20,60]);ext2020(l=40); }
  translate([10,-(40/2),0])rotate([90,0,90])ext2020(l=40);
  translate([0,-(60/2),0])cylinder(r=2.6,h=20,$fn=30);
  translate([0,-(20/2),0])cylinder(r=2.6,h=20,$fn=30);
}

module yrail_mount() {
difference(){
translate([0,0,10-15])cube([30,40,4+15]);
translate([10,40,0])tsection();
}
}

translate([0,0,30])mirror([1,0,1])yrail_mount();
