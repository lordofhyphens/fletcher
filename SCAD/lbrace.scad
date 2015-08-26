include <inc/configuration.scad>
include <inc/metric.scad>
include <inc/functions.scad>

difference() {
  hull() {
    translate([0,10,20])cube([20,10,40],center=true);
    translate([10,0,10])rotate([0,90,0])
    translate([0,10,20])cube([20,10,40],center=true);
  }
  scale([1.01,1.01,1.01])ext2020(40);
  translate([30,5,30])cube([40,10,20], center=true);
  for (i = [5, 30]) {
    translate([0,0,m5_diameter/2+i])rotate([-90,0,0])cylinder(r=m5_diameter/2,h=20);
  }

  translate([10,0,10])rotate([0,90,0])
  {
    scale([1.01,1.01,1.01])ext2020(40);
    for (i = [5, 30]) {
      translate([0,0,m5_diameter/2+i])rotate([-90,0,0])cylinder(r=m5_diameter/2,h=20);
    }
  }
}
