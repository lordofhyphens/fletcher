include <inc/configuration.scad>
use <inc/functions.scad>
module beltloop(belt_gap=1.8, wall_thick=3.2,circle_rad = 2.5, belt_width=6.2, top_width=13, top_length=25)
{
  hull() {
  translate([top_width-(circle_rad+wall_thick+belt_gap),circle_rad,0])
    cylinder(r=circle_rad,h=6.2,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),8,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }
  hull() {
  translate([top_width-(circle_rad+wall_thick+belt_gap),20+circle_rad,0])
    cylinder(r=circle_rad,h=6.2,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),17,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }
  hull() {
  translate([top_width-(0.2+wall_thick+belt_gap),12,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(6+2.2+belt_gap),8,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(0.2+wall_thick+belt_gap),14,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  translate([top_width-(6+2.2+belt_gap),18,0])
    cylinder(r=.2,h=belt_width,$fn=60);
  }

  translate([top_width-wall_thick,0,0])
    cube([wall_thick,top_length,belt_width]);
}
mount_type="rework"; // wades, prusa, or rework. Rework needs a compact-version to fit properly.
measured_rail_edge_to_edge=58.82;
bearing_to_vslot=10.10;
wheel_separation = measured_rail_edge_to_edge+(2*bearing_to_vslot);
echo(bearing_to_vslot);
//wheel_separation = rail_separation+(2*bearing_to_vslot)+x_rod_thickness;
distance_to_belt_center = 13;
union() {
  translate([0,0,(belt_z_space-3/2)-3])roundcube([extruder_x, belt_z_space-4,belt_z_space-3], center=true);
  translate([-25/2,-7,(belt_z_space)+2])rotate([0,0,-90])mirror([1,0,0])beltloop(top_width=13, top_length=25);
}

standoff = (mount_type == "rework" ? true : false); // standoff shouldn't be necessary for wades or prusa-type
rail_size = 20;
wheel_offset = 20;
wheel_od = 25;

extruder_x = 35;
extruder_z = 52;

rework_x_sep = 23;
rework_y_sep = 23;
wades_x_sep = 50;
wades_y_sep = 0;
prusa_x_sep = 30;
prusa_y_sep = 0;

plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = wheel_separation + 20;
plate = [extruder_x + 20, plate_y, 7];

if (standoff) 
  translate([plate[0]*2,0,0])
  difference() {
      translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      roundcube([extruder_x,extruder_z,7]);
      translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      translate([-10,-10,5])
        for (j = [1,-1]) // extruder reworking holes
          for (i = [1,-1])
            translate([plate[0]/2 + i*rework_x_sep/2, plate[1]/2 + j*rework_y_sep/2,0])
            {
              translate([0,-21.5,0]) {
                translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
              } 
            }

  }
difference() {
    translate([0,0,plate[2]/2])roundcube(plate, center=true);
    translate([0,0,0])
    { // holes for v wheel mounting
    for (i = [1 , -1])
      color("blue")translate([0,i*wheel_separation/2, 0]) 
      {
        translate([-plate[0]/2 + M5nut, 0,0])
        {
          cylinder(r=M5/2 + tolerance, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
        translate([plate[0]/2 - M5nut,0,0])
        {
          cylinder(r=M5/2 + tolerance, h=plate[2],  $fs=0.1);
          nutHole(size=5);
        }
      }
    }
  if (mount_type == "rework")
  {
    translate([0,-25,0])
      for (j = [1,-1]) // extruder reworking holes
        for (i = [1,-1])
          translate([i*rework_x_sep/2, j*rework_y_sep/2,0])
              translate([0,0,3.8])mirror([0,0,1])boltHole(size=4,length=7);
  }
  else if (mount_type == "prusa")
  {
    translate([0,-17.5,0])
    for (j = [1,-1]) // extruder prusaing holes
      for (i = [1,-1])
        translate([plate[0]/2 + i*prusa_x_sep/2, plate[1]/2 + j*prusa_y_sep/2,0])
        {
          if (standoff)
          {
            translate([0,-21.5,0]) {
              translate([0,0,5])mirror([0,0,1])boltHole(size=3,length=15, $fs=0.1);
            }
          } 
          else  
          {
            translate([0,0,5])mirror([0,0,1])boltHole(size=3,length=17);
          }
        }
  }
  else if (mount_type == "wades")
  { 
    translate([0,-17.5,0])
    for (j = [1,-1]) // extruder wadesing holes
      for (i = [1,-1])
        translate([plate[0]/2 + i*wades_x_sep/2, plate[1]/2 + j*wades_y_sep/2,0])
        {
          if (standoff)
          {
            translate([0,-21.5,0]) {
              translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
            }
          } 
          else  
          {
            translate([0,0,5])mirror([0,0,1])boltHole(size=4,length=7);
          }
        }
  }
  else { }
}

include<inc/metric.scad>
include<MCAD/nuts_and_bolts.scad> // MCAD library
