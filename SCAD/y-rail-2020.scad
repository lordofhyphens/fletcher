use <inc/functions.scad>


// produce the bracket itself.
// bracket height shifts the bracket placement up/down. The default should
// raise the bed high enough to not be a problem
translate([0,0,30])mirror([1,0,1])yrail_mount(mount_thickness = 18, bracket_height = 5);

module tsection(bracket_height) {
  rotate([90,0,0]){
    ext2020(l=40);
  }
  translate([0,0,0])rotate([90,0,0])
  { translate([-10,-10,-5])cube([20.01,20,60]);ext2020(l=40); }
  translate([10,-(40/2),bracket_height])rotate([90,0,90])ext2020(l=40,teeth=[1,1,1,0]);
  translate([0,-(60/2),0])cylinder(r=2.6,h=20,$fn=30);
  translate([0,-(20/2),0])cylinder(r=2.6,h=20,$fn=30);
}

module yrail_mount(mount_thickness = 18, bracket_height = 5) {
  difference(){
    translate([0,0,10-14])cube([30,40,4+mount_thickness]);
    translate([10,40,0])tsection(bracket_height);
  }
}


