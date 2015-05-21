include<inc/metric.scad>
include<MCAD/nuts_and_bolts.scad> // MCAD library
use<Belt_Generator.scad> // https://www.youmagine.com/designs/parametric-timing-belt-generator

translate([plate[0]/2-extruder_x/2,plate[1]/2,7])
  difference()
  {
    translate([0,-4,0])cube([extruder_x, 10,7]);
    mirror([0,1,0])belting(print_layout="straight", tooth_profile="GT2_2mm", belt_length=extruder_x);
    translate([0,0,3])mirror([0,1,0])belting(print_layout="straight", tooth_profile="GT2_2mm", belt_length=extruder_x);
    translate([extruder_x/2 - 3,-4,0])cube([6, 4,7]);
  }

standoff = true;
rail_separation = 48;
rail_size = 20;
wheel_offset = 20;
wheel_od = 25;

extruder_x = 35;
extruder_z = 52;

mount_x_sep = 23;
mount_y_sep = 23;
plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = (rail_size + rail_separation + wheel_offset * 2 + 15 > extruder_z ? rail_size+ rail_separation + wheel_offset * 2 + 15 : extruder_z);
plate = [extruder_x + 20, plate_y, 7];

difference() {
  union() {
    cube(plate);
    if (standoff) {
      translate([0,0,-7])
      translate([plate[0]/2 - extruder_x/2, plate[1]/2 - extruder_z/2,0])
      cube([extruder_x,extruder_z,plate[2]+7]);
    }
  }
  { // holes for v wheel mounting
    translate([plate[0]/2, plate[1] -(2*wheel_offset+rail_separation+3+rail_size),,0])
    { 
      cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
        nutHole(size=5);
      }
    translate([0,plate[1] - wheel_offset, 0]) 
    {
      translate([plate[0]/2 - (2+ wheel_od/2), 0,0])
      {
        cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
        nutHole(size=5);
      }
      translate([plate[0]/2 + 2+wheel_od/2,0,0])
      {
        cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
        nutHole(size=5);
      }
    }
  }
  translate([0,21.5,0])

  for (j = [1,-1]) // extruder mounting holes
    for (i = [1,-1])
      translate([plate[0]/2 + i*mount_x_sep/2, plate[1]/2 + j*mount_y_sep/2,0])
      {
        if (standoff)
        {
          translate([0,-21.5,0]) {
          translate([0,0,3.8])mirror([0,0,1])boltHole(size=4,length=15, $fs=0.1);
          }
        } else 
        {
          cylinder(r=m4_diameter/2 + 0.1, h=plate[2], $fs=0.1);
          translate([0,0,3.8])mirror([0,0,1])boltHole(size=4,length=7);
        }
      }
}
