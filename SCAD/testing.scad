/* Experimental corexz, based on drawings by Nick Seward.
 * Built around 2040 extrusion for Z axis and Tslot for XY frame.
 * Written by Joseph Lenox
*/
include<./configuration.scad>

// z tower
module printer_half() {
ext2040(l=bed_z);
translate([(20+distance_from_2040),0,bed_z-extrusion_width/2])
      rotate([0,90,0])ext2020(l=bed_x + 50, teeth=[1,1,1,1]);
translate([30 + distance_from_2040, 250,5+20])
      rotate([90,0,0])ext2020(l=bed_z, teeth=[1,1,1,1]);
  translate([0,distance_from_2040,x_end_height+10])x_end();


  z_lower();
translate([0,0,bed_z-extrusion_width]) z_upper(show_hardware);
}

translate([90,0,0])z_upper(show_hardware=false);
translate([-90,0,0])x_end(show_hardware=false);
z_lower(show_hardware=false);
*x_end(show_hardware=false);
*translate([x_end_width/2,21.5,28+separation/2+extrusion_width/2])
  translate([200,distance_from_2040+10+5,x_end_height/2+10])carriage();
*printer_half();
*translate([400,0,0])mirror([1,0,0]) printer_half();
module z_upper(show_hardware = false)
{
  translate([outer_pulley_channel,0,0])
    for (i=[3]) {
      translate([0,0,i*x_end_height/14])
      {
        translate([-(vv623[1]-pulley[1])/2,7,30])
        {
          difference() {
            translate([0,3,-2])
              roundcube([40,10,45], center=true);
            translate([0,-3,0])
            rotate([-90,0,0])linear_extrude(l=1)stepper_motor_mount(17, mochup=true);
          }
        }
      }
    }
  difference()
  {
  translate([18/2,0,upper_z_height/2])
    roundcube([80,40,upper_z_height], center=true);

  translate([crossing_pulley_channel,0,0])
    for (i=[3]) {
      translate([0,0,i*x_end_height/12])
      {
          color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
          color("blue")translate([0,5,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=5+M3nutThickness+tolerance,$fn=6);
        }
      }
    translate([center_pulley_channel,0,0])
      for (i=[3]) {
        translate([0,0,i*x_end_height/12])
        {
          color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
          color("blue")translate([0,5,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=5+M3nutThickness+tolerance,$fn=6);
        }
      }
    #translate([0,0,-(bed_z-(upper_z_height-10))])ext2040(l=bed_z, teeth=[1,1,0,0,0,0]);
    #translate([(20+distance_from_2040),0,extrusion_width/2])
    rotate([0,90,0])ext2020(l=bed_x + 50, teeth=[0,0,1,0]);
    for (i = [35, 10, -10])
    translate([i,30,10])rotate([90,0,0])#cylinder(d=M5+tolerance, h=60);
  }
  if (show_hardware) {
    // (optionally) show external hardware bolted onto this

    // center pulleys
#translate([center_pulley_channel,0,0])
    for (i=[3]) {
      translate([0,0,i*x_end_height/12])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }
    // inner pulley
#translate([crossing_pulley_channel,0,0])
    for (i=[3]) {
      translate([0,0,i*x_end_height/14])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }
  }
}

module z_lower() {
  translate([0,0,lower_z_height/2]) {
    difference() {
      union(){
        hull() {
          translate([0,0,7.5])
            roundcube([50,49,lower_z_height+15], center=true);
          roundcube([50,49,lower_z_height], center=true);
          translate([20,0,0])
            roundcube([42+distance_from_2040,40,lower_z_height], center=true);
        }
        translate([30+(distance_from_2040/2),2.5,0])
          roundcube([20+distance_from_2040,85,lower_z_height], center=true);
      }
      translate([30 + distance_from_2040, 250,5+5])
        #rotate([90,90,0])ext2040(l=500, teeth=[0,0,1,0,0,0]);
        #ext2040(l=500);
        translate([0,0,-20])#ext2020(l=20, teeth=[0,0,0,0]);
      for (i = [35, -30]) {
        translate([10, i, 0])
          rotate([0,90,0])#cylinder(d=M5+tolerance, h=20);
      }
      for (i = [0, 35, -30]) {
        translate([34, i, -25])
          #cylinder(d=M5+tolerance, h=20);
      }
      translate([0,0,-lower_z_height/2]) {

        translate([outer_pulley_channel,0,0])
          for (i=[3]) {
            translate([0,0,i*x_end_height/14])
            {
              #color("blue")translate([0,8,0])rotate([-90,0,0])cylinder(d=M3+tolerance, h=20);
              color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
            }
          }
        translate([center_pulley_channel,0,0])
          for (i=[5]) {
            translate([0,0,i*x_end_height/12])
            {
              #color("blue")translate([0,8,0])rotate([-90,0,0])cylinder(d=M3+tolerance, h=20);
              color("blue")translate([0,5,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=5+M3nutThickness+tolerance,$fn=6);
            }
          }

        translate([inner_pulley_channel,0,0])
          for (i=[3]) {
            translate([0,0,i*x_end_height/14]){
              #color("blue")translate([0,8,0])rotate([-90,0,0])cylinder(d=M3+tolerance, h=20);
              color("blue")translate([0,5,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=5+M3nutThickness+tolerance,$fn=6);
            }
          }
      }
    }

  }

  //bearings
  if (show_hardware) {
    // final pulley
    #translate([center_pulley_channel,distance_from_2040,0])
    for (i=[5]) {
      translate([0,0,i*x_end_height/12])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }

    // inner pulley
    #translate([inner_pulley_channel,distance_from_2040,0])
    for (i=[3]) {
      translate([0,0,i*x_end_height/14])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }
  // outer pulley
    #translate([outer_pulley_channel,distance_from_2040,0])
      for (i=[3]) {
        translate([0,0,i*x_end_height/14])
          color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
      }
  }

}
module x_end() {
  difference() {
    translate([0,5+10,x_end_height/2])
      cube([x_end_width + vwheel_r()*2 + wheel_inset,10,x_end_height], center=true);
    // remove so we can add the mounting pieces later
    translate([x_end_width/2,21.5,28+separation+extrusion_width])
      rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
    translate([x_end_width/2,21.5,28])
      rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
    translate([center_pulley_channel,0,0])
      for (i=[5,7]) {
        translate([0,0,i*x_end_height/12])
        {
          color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
          color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
        }
      }

    translate([inner_pulley_channel,0,0])
      for (i=[1,13]) {
        translate([0,0,i*x_end_height/14]){
          color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
          color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
        }
      }

    for (j = [0,x_end_height-20]) {
      for (i = [-1,1]) {
        translate([i*(20+vwheel_r()),0,j+vwheel_r()])
          translate([0,0,M5/2]) // compensating for rotation
          {
            translate([0,-(distance_from_2040+5),0])
              rotate([-90,0,0])#cylinder(d=M5+tolerance, h=m5_screw_length);
            translate([0,15.5-tolerance,0])rotate([-90,0,0])rotate([0,0,90])#cylinder(d=M5nut+tolerance, h=M5nutThickness+tolerance,$fn=6);
          }
      }
    }

    // because of the way the piece goes together, need to punch holes in it
    // twice. This makes sure the hole goes into the main block.
    translate([x_end_width/2,22.5,28])
      translate([17.5,20,0])
      {
        rotate([90,0,0])#cylinder(d=M5, h=40);
        translate([0, 0, separation+extrusion_width])
          rotate([90,0,0])#cylinder(d=M5, h=40);
      }

  }

  if (show_hardware) {

    translate([x_end_width/2,21.5,28+separation+extrusion_width])
      rotate([0,90,0])ext2020(l=300, teeth=[1,1,1,1], hole=M5, support=[1,0], tolerance=0.4);
    translate([x_end_width/2,21.5,28])
      rotate([0,90,0])ext2020(l=300, teeth=[1,1,1,1], hole=M5,support=[1,0]);
      // (optionally) show external hardware bolted onto this
    // V wheels
    for (j = [0,x_end_height-20]) {
      for (i = [-1,1]) {
        translate([i*(20+vwheel_r()),0,j+vwheel_r()])
          translate([0,0,M5/2]) // compensating for rotation
          {
            translate([0,-(distance_from_2040+5),0])
              rotate([-90,0,0])#cylinder(d=M5+tolerance, h=m5_screw_length);
            translate([0,-(distance_from_2040+5),0])
              rotate([-90,0,0])vwheel()
              translate([0,15.5-tolerance,0])rotate([-90,0,0])rotate([0,0,90])#cylinder(d=M5nut+tolerance, h=M5nutThickness+tolerance,$fn=6);
          }
      }
    }

    // center pulleys
#translate([center_pulley_channel,0,0])
    for (i=[5,7]) {
      translate([0,0,i*x_end_height/12])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }
    // inner pulley
#translate([inner_pulley_channel,0,0])
    for (i=[1,13]) {
      translate([0,0,i*x_end_height/14])
        color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }
  }
  // put in the 2020 bracket holders
  difference() 
  {
    union() {
      translate([x_end_width/2,22.5,28+separation+extrusion_width])
      {
        rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,0,1], hole=M5, thick=5);
      }
      translate([x_end_width/2,22.5,28])
        rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,0,1], hole=M5, thick=5);
    }

    // this removes the top wall of the brackets, turns out they don't appear to be necessary.

    translate([x_end_width/2,22.5,28])
      translate([-20,15,-18])
      rotate([90,0,0])
      #cube([60,70,5]);

    // because of the way the piece goes together, need to punch holes in it
    // twice. this part can probably be fixed in the inv_2020 piece instead.

    translate([x_end_width/2,22.5,28])
      translate([17.5,20,0])
      {
        rotate([90,0,0])#cylinder(d=M5, h=40);
        translate([0, 0, separation+extrusion_width])
          rotate([90,0,0])#cylinder(d=M5, h=40);
      }
  }

}

// libraries
use<./xcarriage.scad>
use<inc/extrusions.scad>
use<inc/vslot.scad>
use<inc/functions.scad>
use<MCAD/motors.scad>
