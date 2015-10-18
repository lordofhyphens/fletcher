z_shift=5;
width=42;

difference()
{
  union() {
    translate([0,(60+5)/2,(5+z_shift)/2])roundcube([width,60+5,5+z_shift],center=true);
    translate([0,40+4/2,(20+5+z_shift)/2])cube([width,4,20+5+z_shift],center=true);
  }
  translate([0,20,0])#linear_extrude(height=10)stepper_motor_mount(17);
  translate([0,width/2,5/2+5])#cube([width,width,5],center=true);
  translate([0,35,10+10])
  for (i = [1, -1])
  {
    translate([i*10,0,0])rotate([-90,0,0])#cylinder(d=M5 + 0.2, h=10);
  }
  translate([0,55,0])#cylinder(d=M5 + 0.2, h=10);
}
difference() {
  union() {
    for (i = [1, -1]) {
      hull() {
        translate([i*20,0,0])cylinder(d=M3,h=12);
        translate([i*20,width+4-M3/2,0])cylinder(d=M3,h=30);
      }
    }
    hull() {
      translate([20,10,0])cylinder(d=M3,h=30);
      translate([20,width+4-M3/2,0])cylinder(d=M3,h=30);
    }
  }
  translate([25,20,15])rotate([0,-90,0])#cylinder(d=2.5+0.3,h=7);
  translate([25,20,15+9.5])rotate([0,-90,0])#cylinder(d=2.5+0.3,h=7);
}
include <inc/configuration.scad>
include<inc/metric.scad>;
include<MCAD/nuts_and_bolts.scad>;
include<MCAD/motors.scad>;
use<inc/functions.scad>;
