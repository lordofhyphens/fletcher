use <inc/functions.scad>
use <MCAD/motors.scad>
include<inc/configuration.scad>

module roundcube(dims, r = 3, center = false)
{
  hull() {
    if (center)
    {
      translate([r -dims[0]/2,r - dims[1]/2,-dims[2]/2]) cylinder(r=r, h=dims[2], $fn=60);
      translate([r -dims[0]/2,(dims[1]/2)-(r),-dims[2]/2]) cylinder(r=r, h=dims[2], $fn=60);
      translate([dims[0]/2-(r),(dims[1]/2)-(r),-dims[2]/2]) cylinder(r=r, h=dims[2], $fn=60);
      translate([dims[0]/2-(r),r - (dims[1]/2),-dims[2]/2]) cylinder(r=r, h=dims[2], $fn=60);

    } else {
      translate([r,r,0]) cylinder(r=r, h=dims[2], $fn=60);
      translate([r,dims[1]-(r),0]) cylinder(r=r, h=dims[2], $fn=60);
      translate([dims[0]-(r),dims[1]-(r),0]) cylinder(r=r, h=dims[2], $fn=60);
      translate([dims[0]-(r),r,0]) cylinder(r=r, h=dims[2], $fn=60);
    }
  }
}
tolerance=0.2;
rod=8;
length_to_hole=43;
depth=10;
panel_height=3.17;
tab_length=93;
height=54;
fastener_hole=M5; 
base_length=77-13; 
z_rod_to_extrusion=length_to_hole-(rod/2)-13;
base_width=z_rod_to_extrusion+13+25;
back_wall_y=z_rod_to_extrusion+13+5;
module z_lower() {
  difference() {
    union() {
      hull() {
        translate([0,z_rod_to_extrusion,height/2])roundcube([26,26,height], r=3,center=true);
        cylinder(r=17/2, h= height);
      }
      translate([-29,z_rod_to_extrusion+13,0])roundcube([tab_length, 30, panel_height]);
      hull() {
        translate([0,-17/2,0])roundcube([base_length, base_width, panel_height]);
        hull() {
          translate([0,z_rod_to_extrusion,panel_height/2])roundcube([26,26,panel_height], center=true);
          cylinder(r=17/2, h=panel_height);
        }
      }
      hull() {
        translate([-13+4,back_wall_y,height-3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
        translate([13-3,back_wall_y,height-3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
        translate([-13-13,back_wall_y,3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
        translate([-13-13,back_wall_y,height/2-3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
        translate([base_length-3,back_wall_y,3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
        translate([base_length-3,back_wall_y,height/2 - 3])
          rotate([90,0,0])cylinder(r=3,h=thickness);
      }
      hull() {
        translate([base_length,back_wall_y-3,height/2 -3])
          rotate([00,-90,0])cylinder(r=3,h=thickness);
        translate([base_length,back_wall_y-3,3])
          rotate([00,-90,0])cylinder(r=3,h=thickness);
        translate([base_length,-3, 3])
          rotate([00,-90,0])cylinder(r=3,h=thickness);
      }


    }
    // subtractions
    translate([0,0,height-depth]) cylinder(r=rod/2 + tolerance,h=height);
    cylinder(r=rod/4,h=height);
    translate([shaft_offset[0],shaft_offset[1],0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);
    translate([0,z_rod_to_extrusion,panel_height]) ext2020(l=height,depth=0.75, tolerance=tolerance);
    translate([0,z_rod_to_extrusion,panel_height]) cube([7,7,height],center=true);

    union() {
      translate([55,back_wall_y+10,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);
      translate([25,back_wall_y+10,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);
      translate([-15,back_wall_y+10,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);

      translate([50,back_wall_y,panel_height])
        translate([0,0,10])rotate([90,0,0]) cylinder(r=fastener_hole/2 + tolerance, h=10);
      translate([25,back_wall_y,panel_height])
        translate([0,0,10])rotate([90,0,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);
      translate([-20,back_wall_y,panel_height])
        translate([0,0,10])rotate([90,0,0]) cylinder(r=fastener_hole/2+ tolerance, h=10);
    }
  }

}
z_lower();
translate[150,0,0])mirror([0,1,0]) z_lower();
