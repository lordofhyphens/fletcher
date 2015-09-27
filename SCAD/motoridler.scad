use <inc/functions.scad>
include <inc/configuration.scad>
use<MCAD/motors.scad>
difference() {
  union() {
    translate([16+35,0,15])roundcube([60,60,50], center=true);
  translate([0,0,-10]) 
    translate([0,0,2.5])roundcube([50,50,5], center=true);
  }
  scale([1,1,1.5]) {
  translate([45,35,10])rotate([90,90,0]) ext2020(l=70, teeth=[0,0,0,0]);
  translate([65,35,10])rotate([90,90,0]) ext2020(l=70, teeth=[0,0,0,0]);
  translate([45,35,10])rotate([90,90,0]) ext2020(l=70, teeth=[0,0,0,0]);
  translate([40,35,10])rotate([90,90,0]) ext2020(l=70, teeth=[0,0,0,0]);
  }
  translate([16+35,0,0])cube([42,65,30], center=true);
  translate([40,0,0])
    hull(){
      translate([0,-15,0])cylinder(r=M5/2, h=200);
      translate([30,-15,0])cylinder(r=M5/2, h=200);
    }
  translate([40,0,0])
    hull(){
      translate([0,15,0])cylinder(r=M5/2, h=200);
      translate([30,15,0])cylinder(r=M5/2, h=200);
    }
  translate([0,0,-10]) {
  linear_extrude(h=20)stepper_motor_mount(17);
  }
  translate([70,0,15])
    rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=30);
  translate([73,0,15])
    rotate([0,90,0])cylinder(r=M5nut/2 + tolerance, h=M5nutThickness, $fn=6);
}
translate([0,0,-10])
for (i = [25, -25])
  hull() {
    translate([20,i,27])
      rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=5);
    translate([-22,i,0])
      cylinder(r=M5/2 + tolerance, h=5);
    translate([20,i,0])
      cylinder(r=M5/2 + tolerance, h=5);
  }
