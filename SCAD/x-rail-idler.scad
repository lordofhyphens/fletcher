include <configuration.scad>
include <inc/metric.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>
use <inc/functions.scad>


difference() {
  import("src/X_Axis_Idler_Block_-_1x.stl");
  translate([0,0,10])cube([100,100,8]);
  // prusa-style idler
translate([48.5,45,0])rotate([0,0,270]) {
  translate([0,-50,21])cube([18,50,18]);
  translate([37,-5,30]) rotate([90,0,0])cylinder(r=m4_diameter/2,h=20);
  color("blue")translate([-5,-20.5,21])cube([50,11,18]); translate([0,0,42])cube([100,100,8]);
}


}
linear_extrude(height=18)
projection(cut=true)translate([0,0,-14])
  import("src/X_Axis_Idler_Block_-_1x.stl");

translate([0,0,41])linear_extrude(height=18)
projection(cut=true)translate([0,0,-14])
  import("src/X_Axis_Idler_Block_-_1x.stl");

// support pillars, cut these off
translate([11.5,40,10]) translate([10,20,10])cube([2,2,20]);
translate([22+11.5,40,10]) translate([10,20,10])cube([2,2,20]);
translate([11.5,24,10]) translate([10,20,10])cube([2,2,20]);
translate([22+11.5,24,10]) translate([10,20,10])cube([2,2,20]);

translate([23.5,42,0]) 
{ 
  translate([10,20,10])rotate([90,0,0])
    difference()
    {
    scale([1.2,1.05,1.2])ext2020(l=15, teeth=[0,0,0,0]);
    translate([0,0,-3])ext2020(l=20, teeth=[1,1,0,1]);
    }
}


translate([23.5,42,40]) { 
  translate([10,20,10])rotate([90,0,0])
    difference()
    {
    scale([1.2,1.05,1.2])ext2020(l=15, teeth=[0,0,0,0]);
    translate([0,0,-3])ext2020(l=20, teeth=[1,1,0,1]);
    }
}
