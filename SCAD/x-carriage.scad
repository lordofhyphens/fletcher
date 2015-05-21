include<inc/metric.scad>
include<MCAD/nuts_and_bolts.scad> // MCAD library


rail_separation = 48;
wheel_offset = 20;
wheel_od = 25;

extruder_x = 35;
extruder_z = 52;

mount_x_sep = 23;
mount_y_sep = 23;
plate_x = (wheel_od*2 + 4 > extruder_x ? wheel_od*2 + 4 : extruder_x);
plate_y = (rail_separation + wheel_offset * 2 + 15 > extruder_z ? rail_separation + wheel_offset * 2 + 15 : extruder_z);
plate = [extruder_x + 20, plate_y, 7];

difference() {
  cube(plate);
  { // holes for v wheel mounting
  translate([plate[0]/2,plate[1] - wheel_offset,0])
    { 
      cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
        nutHole(size=5);
      }
  translate([plate[0]/2 - (2+ wheel_od/2),plate[1] - (2*wheel_offset+rail_separation),0])
    {
      cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
      nutHole(size=5);
    }
  translate([plate[0]/2 + 2+wheel_od/2,plate[1] -(2*wheel_offset+rail_separation),0])
    {
     cylinder(r=m5_diameter/2 + 0.1, h=plate[2],  $fs=0.1);
      nutHole(size=5);
    }
  }
  for (j = [1,-1]) // extruder mounting holes
    for (i = [1,-1])
      translate([plate[0]/2 + i*mount_x_sep/2, plate[1]/2 + j*mount_y_sep/2,0])
      {
        cylinder(r=m4_diameter/2 + 0.1, h=plate[2], $fs=0.1);
        nutHole(size=4);
      }

}
