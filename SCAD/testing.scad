tolerance=0.2;
end_height=90;
end_width=40;
wheel_inset=10;
extrusion_width=20;
separation=18;

show_hardware = false;

*ext2040(l=90);
difference() {
  translate([0,5+10,end_height/2])
    cube([end_width + vwheel_r()*2 + wheel_inset,10,end_height], center=true);
  // remove so we can add the mounting pieces later
  translate([end_width/2,21.5,28+separation+extrusion_width])
    rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
  translate([end_width/2,21.5,28])
    rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
  translate([end_width/4,0,0])
    for (i=[5,7]) {
      translate([0,0,i*end_height/12])
      {
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
        color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
      }
    }

  translate([2*end_width/5,0,0])
    for (i=[1,13]) {
      translate([0,0,i*end_height/14]){
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
        color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
        }
    }

  for (j = [0,end_height-20]) {
    for (i = [-1,1]) {
      translate([i*(20+vwheel_r()),0,j+vwheel_r()])
        translate([0,0,M5/2]) // compensating for rotation
        {
          rotate([-90,0,0])#cylinder(d=M5+tolerance, h=20);
          translate([0,15.5-tolerance,0])rotate([-90,0,0])rotate([0,0,90])#cylinder(d=M5nut+tolerance, h=M5nutThickness+tolerance,$fn=6);
        }
    }
  }
}

if (show_hardware) {
#translate([end_width/4,0,0])
  for (i=[5,7]) {
    translate([0,0,i*end_height/12])
      color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
  }

#translate([2*end_width/5,0,0])
  for (i=[1,13]) {
    translate([0,0,i*end_height/14])
      color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
  }
}
translate([end_width/2,21.5,28+separation+extrusion_width])
  rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,1,1], hole=M5);
translate([end_width/2,21.5,28])
  rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,1,1], hole=M5);

use<inc/extrusions.scad>
use<inc/vslot.scad>
use<inc/functions.scad>
include<inc/configuration.scad>
