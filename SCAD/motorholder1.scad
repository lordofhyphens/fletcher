z_shift=5;
y_tension=5;
width=45+7.5;
difference()
{
  union() {
    translate([0,(y_tension+38+5)/2,(5+z_shift)/2])roundcube([width,y_tension+38+5,5+z_shift],center=true);
    translate([0,y_tension+40+4/2,(20+5+z_shift)/2])cube([width,4,20+5+z_shift],center=true);
  }
  translate([0,20,0])#linear_extrude(height=10)stepper_motor_mount(17, tolerance=0.4, stretch=y_tension);
  translate([0,(y_tension+40)/2,5/2+5])#cube([width,y_tension+40,5],center=true);
  translate([0,35,15])
    for (i = [1, -1])
    {
      translate([i*10,y_tension,0])rotate([-90,0,0])#cylinder(d=M5 + 0.2, h=10);
    }
}
difference() {
  union() {
    for (i = [1, -1]) {
      hull() {
        translate([i*(width-M3)/2,0,0])cylinder(d=M3,h=12);
        translate([i*(width-M3)/2,y_tension+40+4-M3/2,0])cylinder(d=M3,h=30);
      }
    }
  }
}
include <inc/configuration.scad>
include<inc/metric.scad>;
include<MCAD/nuts_and_bolts.scad>;
include<MCAD/motors.scad>;
use<inc/functions.scad>;
