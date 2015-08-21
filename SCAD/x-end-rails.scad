tolerance=0.2;
belt_space_cutout=8;
module x_idler() {
  difference() {
    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) union() {
        hull() {
          cylinder(r=lm8uu[1]/2 + 3, h = lm8uu[2]*2); // outer
          translate([-((lm8uu[1]/2)+4), -((lm8uu[1]/2)+4),0])
            translate([lm8uu[1]+12,0,0])roundcube([lm8uu[1],lm8uu[1],lm8uu[2]*2]);
        }
      }
      translate([lm8uu[1]+9,0,0])roundcube([18,length_to_hole+20,lm8uu[2]*2]);
      translate([(2*28/3)+shifted_rails,length_to_hole-10,0])roundcube([28,30,outer_height]);
      translate([lm8uu[1]+9,shaft_offset[1]+zRod-3,0])roundcube([38-9,zRodnut+4+6,3+zRodnutThickness]);

    }

    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) 
      {
        cylinder(r=lm8uu[1]/2-tolerance, h=lm8uu[2]*2);
        rotate([0,0,-25])
          translate([0,15/2,outer_height/2])cube([2,15,outer_height], center=true);
        translate([shaft_offset[0], shaft_offset[1], 0]) 
        {
          cylinder(r=zRod/2, h=10);
          translate([0,0,3])cylinder(r=zRodnut/2, h=zRodnutThickness, $fn=6);
        }
      }
      translate([28/2+(2*28/3)+shifted_rails,length_to_hole,0])
        translate([0,0,0])rotate([0,0,90])union() {
          translate([0,0,rail_separation])
          {
            translate([0,0,(20+tolerance)/2])
              rotate([0,90,0])ext2020(l=21, tolerance=tolerance, teeth=[1,0,0,0]);
            translate([9,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
          }
          translate([0,0,(20+tolerance)/2])
            rotate([0,90,0])
            ext2020(l=21, tolerance=tolerance,teeth=[0,0,0,0] );
          translate([9,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
        }

      translate([28/2+(2*28/3)+shifted_rails,0,20+1]) translate([0,0,belt_z_space/2]) rotate([90,0,0])roundcube([belt_space_cutout, belt_z_space,300], center=true);

    }
  }
}
module x_motor() {
  difference() {
    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) union() {
        hull() {
          cylinder(r=lm8uu[1]/2 + 3, h = lm8uu[2]*2); // outer
          translate([-((lm8uu[1]/2)+4), -((lm8uu[1]/2)+4),0])
            translate([lm8uu[1]+12,0,0])roundcube([lm8uu[1],lm8uu[1],lm8uu[2]*2]);
        }
      }
      translate([lm8uu[1]+9,0,0])roundcube([18,length_to_hole+20,lm8uu[2]*2]);
      translate([(2*28/3)+shifted_rails,length_to_hole-10,0])roundcube([28,30,outer_height]);
      translate([lm8uu[1]+9,shaft_offset[1]+zRod-3,0])roundcube([38-9,zRodnut+4+6,3+zRodnutThickness]);

      translate([lm8uu[1]+10,-38-5,0])roundcube([5,45,16]);
      hull() translate([lm8uu[1]+10,0,40])
      {
        rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,-10,5])
          rotate([0,90,0])cylinder(r=3,h=7);
        translate([0,0,5])
          rotate([0,90,0])cylinder(r=3,h=7);
      }

    }

    union() {
      translate([(lm8uu[1]/2)+3, (lm8uu[1]/2)+3,0]) 
      {
        cylinder(r=lm8uu[1]/2-tolerance, h=lm8uu[2]*2);
        rotate([0,0,-25])
          translate([0,15/2,outer_height/2])cube([2,15,outer_height], center=true);
        translate([shaft_offset[0], shaft_offset[1], 0]) 
        {
          cylinder(r=zRod/2, h=10);
          translate([0,0,3])cylinder(r=zRodnut/2, h=zRodnutThickness, $fn=6);
        }
      }
      translate([28/2+(2*28/3)+shifted_rails,length_to_hole,0])
        translate([0,0,0])rotate([0,0,90])union() {
          translate([0,0,rail_separation])
          {
            translate([0,0,(20+tolerance)/2])
              rotate([0,90,0])ext2020(l=21, tolerance=tolerance, teeth=[1,0,0,0]);
            translate([9,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
          }
          translate([0,0,(20+tolerance)/2])
            rotate([0,90,0])
            ext2020(l=21, tolerance=tolerance,teeth=[0,0,0,0] );
          translate([9,15,10])rotate([90,90,0])cylinder(r=M5/2 + tolerance, h = 30);
        }

      translate([28/2+(2*28/3)+shifted_rails,0,20+1]) translate([0,0,belt_z_space/2]) rotate([90,0,0])roundcube([belt_space_cutout, belt_z_space,300], center=true);

     translate([28/2+(2*28/3)+shifted_rails+0,-20,20+1]) translate([-12,0,belt_z_space/2])rotate([0,90,0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);

    }
  }

}
include <inc/configuration.scad>
use <inc/functions.scad>
belt_z_space = 16;
rail_separation = belt_z_space + x_rod_thickness + 2; // minimum space between the top and bottom 
outer_height=rail_separation+20+tolerance-1;

shifted_rails=2;
mirror([0,1,0])x_motor();

use <MCAD/motors.scad>
