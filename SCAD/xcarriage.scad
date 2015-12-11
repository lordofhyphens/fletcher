include<./configuration.scad>;

carriage_z = separation + extrusion_width + vwheel_r()*2 + 10;
carriage_x = 50;
carriage_y = 7;
roundcube([carriage_x, carriage_y, carriage_z],center=true);
  for (i = [1, -1])
  {
    for (j = [1, -1])
    {
      translate([i*20, 0, j*((-M5/2)+(separation/2)+(extrusion_width/2) + vwheel_r())])
        rotate([90,0,0])
        cylinder(d=M5, h=20, center=true);
    }
  }
// libraries
use<inc/extrusions.scad>
use<inc/vslot.scad>
use<inc/functions.scad>
use<MCAD/motors.scad>
