include <configuration.scad>
include <inc/metric.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>
use <inc/functions.scad>

// 48mm separation, center to center
rail_separation = 48;
bracket_width = 28;

difference() {
  union() {
    // positive, brackets 
    translate([23.5,38,0.45]) 
      translate([10,20,10])rotate([90,0,0])
          scale([bracket_width/20,1.05,1.2])ext2020(l=20, teeth=[0,0,0,0]);
    translate([23.5,38,rail_separation-2])  
      translate([10,20,10])rotate([90,0,0])
          scale([bracket_width/20,1.05,1.2])ext2020(l=20, teeth=[0,0,0,0]);

  translate([38,0,0])cube([5.7,40,60]); // thicken up the idler wall to make it easier to print
    // positive, the original idler block
    import("src/X_Axis_Idler_Block_-_1x.stl");
  linear_extrude(height=18)
    projection(cut=true)translate([0,0,-14])
    import("src/X_Axis_Idler_Block_-_1x.stl");
  translate([0,0,41])linear_extrude(height=18)
    projection(cut=true)translate([0,0,-14])
    import("src/X_Axis_Idler_Block_-_1x.stl");

  }
  translate([23.5,38,0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[0,0,0,0]);
  translate([23.5,38,rail_separation+0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[0,0,0,1]);
  translate([23.5,38,-5+0.45]) 
    translate([10,20,10])rotate([90,0,0])
    translate([0,0,-3])ext2020(l=20, teeth=[0,0,0,1]);
  translate([23.5,38,rail_separation+0.45]) 
    translate([-10,10,10])rotate([90,0,90])
    cylinder(r=m5_diameter/2 + 0.1, h=50, $fs=0.1);
  translate([23.5,38,0.45]) 
    translate([-10,10,10])rotate([90,0,90])
    cylinder(r=m5_diameter/2 + 0.1, h=40, $fs=0.1);

  // prusa-style idler
  translate([48.5,45,0])rotate([0,0,270]) {
    translate([0,-50,21])cube([18,50,18]);
    translate([37,5,30]) rotate([90,0,0])cylinder(r=m4_diameter/2,h=30);
    color("blue")translate([-5,-20.5,21])cube([50,11,18]); translate([0,0,42])cube([100,100,8]);
  }
}


// support pillars, cut these off
translate([.75,.75,0]) {
  difference() {
    union() {
      translate([9.5,14,10]) translate([10.45,20.75,10])cylinder(r=1.5, h=35, $fn=60);
      translate([22+2+11.5,14,10]) translate([10,20.75,10])cylinder(r=1.5, h=35, $fn=60);
      translate([9.5,36,10]) translate([10.45,19.75,10])cylinder(r=1.5, h=35,$fn=60);
      translate([22+2+11.5,36,10]) translate([10,19.75,10])cylinder(r=1.5, h=35,$fn=60);
    }
    translate([9.5,14,10]) translate([10.45,20.75,10])cylinder(r=1.25, h=35, $fn=60);
    translate([22+2+11.5,14,10]) translate([10,20.75,10])cylinder(r=1.25, h=35, $fn=60);
    translate([9.5,36,10]) translate([10.45,19.75,10])cylinder(r=1.25, h=35,$fn=60);
    translate([22+2+11.5,36,10]) translate([10,19.75,10])cylinder(r=1.25, h=35,$fn=60);
  }
}

// spacer cube
translate([11.5,14,10]) translate([10,20,30])cube([24,24,8.0]);

