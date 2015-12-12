include<./configuration.scad>;

carriage_z = separation + 2*extrusion_width + vwheel_r()*2 + 10;
carriage_x = 60;

tuner_overhang = 7;
// diameters
tuner_shaft = 6.1;
tuner_bore = 10;

peg_diameter=2.4;
peg_offset_from_top=2;
peg_offset_from_side=1.35;
peg_separation=7.5;
tuner_depth=13.5;
total_footprint=19.25;
max_thickness = tuner_depth - tuner_overhang;

carriage_y = max_thickness;
module tuner()
{
  difference() {
    hull() {
      cylinder(d=15,h=tuner_overhang);
      translate([0, 1+peg_offset_from_top+peg_diameter/2+tuner_bore/2,tuner_overhang/2])cube([15,peg_diameter,tuner_overhang], center=true);
    }
    cylinder(d=tuner_bore, h=tuner_overhang);
    cylinder(d=peg_diameter,h=tuner_overhang);
    for (i = [1, -1]) 
      translate([i*(peg_diameter/2 + peg_separation/2),3+(tuner_bore/2),0])cylinder(d=peg_diameter,h=tuner_overhang);
  }
  #cylinder(d=tuner_bore, h=tuner_depth);

}
module carriage() 
{
  translate([0,0,carriage_z/2])
  {
    roundcube([carriage_x, carriage_y, carriage_z],center=true);
    for (i = [1, -1])
    {
      for (j = [1, -1])
      {
        translate([i*25, 0, j*((-M5/2)+(separation/2)+(extrusion_width) + vwheel_r())])
          rotate([90,0,0])
          cylinder(d=M5, h=20, center=true);
      }
    }
  }
  translate([5+inner_pulley_channel,-(carriage_y+tuner_overhang),0])
    for (i=[[7,270]]) {
      translate([0,0,i[0]*x_end_height/14]){
        color("blue")
        translate([0,carriage_y/2,0])rotate([-90,i[1],0])tuner();
      }
    }
  translate([-inner_pulley_channel-5,-(carriage_y+tuner_overhang),0])
    for (i=[[7,90]]) {
      translate([0,0,i[0]*x_end_height/14]){
        color("blue")
        translate([0,carriage_y/2,0])rotate([-90,i[1],0])tuner();
      }
    }

}

tolerance=0.3;
mount_type="rework"; // wades, prusa, or rework. Rework needs a compact-version to fit properly.
measured_rail_edge_to_edge=58.82;
bearing_to_vslot=10.10;
fudge_distance=0;
wheel_separation = measured_rail_edge_to_edge+(2*bearing_to_vslot)-fudge_distance;
wheel_od = 25;
extruder_x = 35;
extruder_z = 35;

rework_x_sep = 23;
rework_y_sep = 23;
wades_x_sep = 50;
wades_y_sep = 0;
prusa_x_sep = 30;
prusa_y_sep = 0;

plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = wheel_separation + 20;
plate = [extruder_x + 20, plate_y, 7+10];

translate([-extruder_x/2 -10,-carriage_y/2,-30])
rotate([90,0,0])
  difference() {
    translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      roundcube([extruder_x,extruder_z,plate[2]]);
    translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      translate([-10,-10,5])
      for (j = [1,-1]) // extruder reworking holes
        for (i = [1,-1])
          translate([plate[0]/2 + i*rework_x_sep/2, plate[1]/2 + j*rework_y_sep/2,0])
          {
            translate([0,-21.5,0]) {
              #translate([0,0,5+plate[2]/2])mirror([0,0,1])boltHole(size=4,length=plate[2]+15, $fs=0.1);
            } 
          }

  }
//tuner();
carriage();
// libraries
use<inc/extrusions.scad>
use<inc/vslot.scad>
use<inc/functions.scad>
use<MCAD/motors.scad>

include<MCAD/nuts_and_bolts.scad> // MCAD library
