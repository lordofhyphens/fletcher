/* Experimental corexz, based on drawings by Nick Seward.
 * Built around 2040 extrusion for Z axis and Tslot for XY frame.
 * Written by Joseph Lenox
*/

tolerance=0.2;
end_height=90;
end_width=40;
wheel_inset=10;
extrusion_width=20;
separation=18;
distance_from_2040=4;
m5_screw_length=30;
lower_z_height=30;

show_hardware = true;

inner_pulley_channel = 1.5*end_width/5;
center_pulley_channel = -0.5*end_width/4;
outer_pulley_channel = -2*end_width/5;
crossing_pulley_channel = 3*end_width/5;

ext2040(l=500);
translate([30 + distance_from_2040, 250,5+20])
    rotate([90,0,0])ext2020(l=500, teeth=[1,1,1,1]);
translate([0,distance_from_2040,end_height+10])x_end();
z_lower();

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
                translate([35, i, -25])
                #cylinder(d=M5+tolerance, h=20);
            }
            translate([0,0,-lower_z_height/2]) {

                translate([outer_pulley_channel,0,0])
                    for (i=[3]) {
                        translate([0,0,i*end_height/14])
                        {
                            color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
                            color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
                        }
                    }
                translate([center_pulley_channel,0,0])
                    for (i=[5]) {
                        translate([0,0,i*end_height/12])
                        {
                            color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
                            color("blue")translate([0,5,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=5+M3nutThickness+tolerance,$fn=6);
                        }
                    }

                translate([inner_pulley_channel,0,0])
                    for (i=[3]) {
                        translate([0,0,i*end_height/14]){
                            color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
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
            translate([0,0,i*end_height/12])
                color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
        }

        // inner pulley
#translate([inner_pulley_channel,distance_from_2040,0])
        for (i=[3]) {
            translate([0,0,i*end_height/14])
                color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
        }
    }
    // outer pulley
#translate([outer_pulley_channel,distance_from_2040,0])
    for (i=[3]) {
        translate([0,0,i*end_height/14])
            color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
    }

}
module x_end() {
    difference() {
        translate([0,5+10,end_height/2])
            cube([end_width + vwheel_r()*2 + wheel_inset,10,end_height], center=true);
        // remove so we can add the mounting pieces later
        translate([end_width/2,21.5,28+separation+extrusion_width])
            rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
        translate([end_width/2,21.5,28])
            rotate([0,90,0])ext2020(l=30, teeth=[1,1,1,1]);
        translate([center_pulley_channel,0,0])
            for (i=[5,7]) {
                translate([0,0,i*end_height/12])
                {
                    color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=false);
                    color("blue")translate([0,10,0])rotate([-90,0,0])cylinder(d=M3nut+tolerance, h=M3nutThickness+tolerance,$fn=6);
                }
            }

        translate([inner_pulley_channel,0,0])
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
                        translate([0,-(distance_from_2040+5),0])
                            rotate([-90,0,0])#cylinder(d=M5+tolerance, h=m5_screw_length);
                        translate([0,15.5-tolerance,0])rotate([-90,0,0])rotate([0,0,90])#cylinder(d=M5nut+tolerance, h=M5nutThickness+tolerance,$fn=6);
                    }
            }
        }
    }
    if (show_hardware) {
        // (optionally) show external hardware bolted onto this
        // V wheels
        for (j = [0,end_height-20]) {
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
            translate([0,0,i*end_height/12])
                color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
        }
        // inner pulley
#translate([inner_pulley_channel,0,0])
        for (i=[1,13]) {
            translate([0,0,i*end_height/14])
                color("blue")translate([0,23,0])rotate([-90,0,0])vbearing(bearing=true);
        }
    }
    translate([end_width/2,21.5,28+separation+extrusion_width])
        rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,1,1], hole=M5);
    translate([end_width/2,21.5,28])
        rotate([0,90,0])inv_ext2020(l=30, teeth=[1,1,1,1], hole=M5);
}

// libraries
use<inc/extrusions.scad>
use<inc/vslot.scad>
use<inc/functions.scad>
include<inc/configuration.scad>
