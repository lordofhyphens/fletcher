use <inc/functions.scad>
use <MCAD/motors.scad>
include<inc/configuration.scad>


tolerance=0.2;
module z_lower(height, panel_height) {
  rod=8;
  length_to_hole=43;
  depth=10;
  tab_length=93;
  fastener_hole=M5; 
  base_length=77-13; 
  z_rod_to_extrusion=length_to_hole-(rod/2)-13;
  base_width=z_rod_to_extrusion+13+25;
  back_wall_y=z_rod_to_extrusion+13+5;

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
module z_upper_motor(height=25, tolerance=0.2)
{
  rod=8;
  length_to_hole=43;
  depth=height-3;
  tab_length=93;
  fastener_hole=M5; 
  base_length=77-13; 
  // length from center of rod to center of extrusion
  z_rod_to_extrusion=length_to_hole-(rod/2)-13;
  base_width=z_rod_to_extrusion+13+25;
  back_wall_y=z_rod_to_extrusion+13+5;
  difference() {
    union() {
      hull() {
        translate([0,z_rod_to_extrusion,height/2])roundcube([26,26,height], r=3,center=true);
        translate([0,z_rod_to_extrusion+26,height/2])roundcube([26,26,height], r=3,center=true);
        cylinder(r=17/2, h= height);
      }
      translate([0,-8,0])roundcube([70,45,3]);
      for (i = [1.5, 45]){ 
        translate([0,i,0])
          hull(){
            width = 2;
            translate([width,-10+width,height-width])rotate([0,90,0])cylinder(r=width,h=width);
            translate([-width+70,-10+width,width])rotate([0,90,0])cylinder(r=width,h=width);
            translate([width,-10+width,width])cube([width*2,width*2,width*2],center=true);
          }
      }
    }
    translate([0,0,height-depth]) cylinder(r=rod/2 + tolerance,h=height);
    cylinder(r=rod/4,h=height);
    translate([0,z_rod_to_extrusion,3])ext2020(l=26, depth=0.75, tolerance=tolerance);
    translate([0,13+3+z_rod_to_extrusion,3+20/2])rotate([-90,0,0])ext2020(l=26, depth=0.75,teeth=[0,0,1,0], tolerance=tolerance);
    for (y = [53, 26]) 
      translate([-20,y,((height-3) / 2)+3])rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=40);

    translate([shaft_offset[0],shaft_offset[1],0])linear_extrude(height=10)stepper_motor_mount(17, mochup=false, tolerance=tolerance);
  }


  
}
module z_upper(height=25, tolerance=0.2) {
  rod=8;
  length_to_hole=43;
  depth=height-3;
  tab_length=93;
  fastener_hole=M5; 
  base_length=77-13; 
  // length from center of rod to center of extrusion
  z_rod_to_extrusion=length_to_hole-(rod/2)-13;
  base_width=z_rod_to_extrusion+13+25;
  back_wall_y=z_rod_to_extrusion+13+5;

  difference() {
    union() {
      hull() {
        translate([0,z_rod_to_extrusion,height/2])roundcube([26,26,height], r=3,center=true);
        translate([0,z_rod_to_extrusion+26,height/2])roundcube([26,26,height], r=3,center=true);
        cylinder(r=17/2, h= height);
      }
    }
    translate([0,0,height-depth]) cylinder(r=rod/2 + tolerance,h=height);
    cylinder(r=rod/4,h=height);
    translate([0,z_rod_to_extrusion,3])ext2020(l=26, depth=0.75, tolerance=tolerance);
    translate([0,13+3+z_rod_to_extrusion,3+20/2])rotate([-90,0,0])ext2020(l=26, depth=0.75,teeth=[0,0,1,0], tolerance=tolerance);
    for (y = [53, 26]) 
      translate([-20,y,((height-3) / 2)+3])rotate([0,90,0])cylinder(r=M5/2 + tolerance, h=40);
  }
}
*translate([0,-100,0]) z_upper(height=23);
*translate([50,-100,0]) z_upper(height=23);
*z_lower(height=54, panel_height=3.17);
*translate([0,150,0])mirror([0,1,0]) z_lower(height=54, panel_height=3.17);
z_upper_motor(height=23);
