/* Experimental probe configuration for lift. Current hope is for a cherrymx switch, could probably work with a reed switch. */

// hole for probe - 7mm 

// square probe:
// lip: 1.5mm
//

angle=40;
module probe2(shadow=true)
{
  difference()
  {
    cylinder(d=15, h=15);
    translate([0,0,3])cylinder(d=10.4, h=20, $fn=6);
    cylinder(d=7, h=20);
  }
 
}

translate([70,0,0])
{
  translate([20,0,0])difference()
  {
    union() {
      cylinder(d=7, h=5, $fn=90);
      translate([0,0,3/2])cube([11,2,3], center=true);
      rotate([0,0,angle])translate([0,0,3/2])cube([11,2,3], center=true);
    }
    cylinder(d=3.1, h=5);
  }
  difference() {
    cylinder(d=15, h=15, $fn=90);
    translate([0,0,3])
    {
      translate([0,0,15/2])cube([11.2,2.4,15], center=true);
      rotate([0,0,angle])translate([0,0,15/2])cube([11.2,2.4,15], center=true);
    }
    rotate([0,0,90])
    translate([0,0,0])
    {
      translate([0,0,15/2])cube([11.2,2.4,15], center=true);
      rotate([0,0,angle])translate([0,0,15/2])cube([11.2,2.4,15], center=true);
    }
    cylinder(d=7.2, h=20, $fn=90);
    #translate([0,0,10])
      cylinder(d=9.4,2, h=20, $fn=90);
  }
}

module probe(shadow = true, key=[2,9,3], pos = [0])
{
    difference() {
        union() {
            cube([7,7,7], center=true);
            for (i = pos)
            {
                translate([i*key[0],0,2])cube(key, center=true);
            }
        }
        if (!shadow)
            cylinder(d=5, h=10, center=true);
    }
}
translate([0,0,-1.5])difference(){
cube([10,10,7], center=true);
scale([1.1,1.1,1.1])probe(true, [2,9,7], pos=[1,-1]);
rotate([0,0,90])probe(true, [7,9,12], pos=[0]);
}

difference(){
cube([12,12,10], center=true);
cube([10,10,10], center=true);
}

translate([50,0,0])mirror([0,0,1])probe2(false, [2,9,3], pos=[1,-1]);
