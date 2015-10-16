z_shift=5;
y_tension=15;
width=42;
difference()
{
  union() {
    translate([0,(y_tension+60+5)/2,(5+z_shift)/2])roundcube([width,y_tension+60+5,5+z_shift],center=true);
    translate([0,y_tension+40+4/2,(20+5+z_shift)/2])cube([width,4,20+5+z_shift],center=true);
  }
  translate([0,20,0])#linear_extrude(height=10)stepper_motor_mount(17, tolerance=0.4, stretch=y_tension);
  translate([0,(y_tension+43)/2,5/2+5])#cube([width,y_tension+37,5],center=true);
  translate([0,(y_tension+40)/2,5/2+7])#cube([width,y_tension+40,5],center=true);
  translate([0,35,10+10])
  for (i = [1, -1])
  {
    translate([i*10,y_tension,0])rotate([-90,0,0])#cylinder(d=M5 + 0.2, h=10);
  }
  translate([0,55+y_tension,0])#cylinder(d=M5 + 0.2, h=10);
  translate([0,1,0])
  for (i = [1, -1]) {
    translate([i*15.5,-2,M3-1])rotate([-90,0,0])#cylinder(d=M3 + 0.2, h=10);
    hull() {
      translate([i*15.5,2,M3-1])rotate([-90,0,0])#cylinder(d=M3nut + 0.2, h=M3nutThickness+3, $fn=6);
      translate([i*15.5,2,M3-4])rotate([-90,0,0])#cylinder(d=M3nut + 0.2, h=M3nutThickness+3, $fn=6);
    }
  }
}
difference() {
  union() {
    for (i = [1, -1]) {
      hull() {
        translate([i*20,0,0])cylinder(d=M3,h=12);
        translate([i*20,y_tension+40+4-M3/2,0])cylinder(d=M3,h=30);
      }
    }
  }
}
include <inc/configuration.scad>
include<inc/metric.scad>;
include<MCAD/nuts_and_bolts.scad>;
include<MCAD/motors.scad>;
use<inc/functions.scad>;
