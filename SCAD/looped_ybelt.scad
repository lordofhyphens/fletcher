padding=18;
top_width=14.2;
module beltloop()
{
  hull() {
  translate([top_width-(2.5+3.2+1.8),2.5,0])
    cylinder(r=2.5,h=6.2,$fn=60);
  translate([top_width-(0.2+3.2+1.8),8,0])
    cylinder(r=.2,h=6.2,$fn=60);
  }
  hull() {
  translate([top_width-(2.5+3.2+1.8),22.5,0])
    cylinder(r=2.5,h=6.2,$fn=60);
  translate([top_width-(0.2+3.2+1.8),17,0])
    cylinder(r=.2,h=6.2,$fn=60);
  }
  hull() {
  translate([top_width-(0.2+3.2+1.8),12,0])
    cylinder(r=.2,h=6.2,$fn=60);
  translate([top_width-(6+2.2+1.8),8,0])
    cylinder(r=.2,h=6.2,$fn=60);
  translate([top_width-(0.2+3.2+1.8),14,0])
    cylinder(r=.2,h=6.2,$fn=60);
  translate([top_width-(6+2.2+1.8),18,0])
    cylinder(r=.2,h=6.2,$fn=60);
  }

  translate([top_width-3.2,0,0])
    cube([3.2,25,6.2]);
}
difference() {
  union() {
    cube([20,60,padding]);
    translate([20-top_width,12.63,padding+16.9])beltloop();
  }
  translate([20/2,4.4+3/2, 0])cylinder(r=3/2 + 0.1, h=padding);
  translate([20/2,60-(4.4+3/2), 0])cylinder(r=3/2 + 0.1, h=padding);
}

difference() {
  hull() {
    translate([20-top_width,12.63-3,padding+16.8])cube([top_width,25+6,.1]);
    translate([0,12.63-3,padding])cube([20,25+6,.1]);
  }
  for ( i = [12.63-3, 12.63 + 25 + 3])
  hull() {
    translate([0,i,padding+3])rotate([0,90,0])cylinder(r=3, h=20,$fn=60);
    translate([0,i,padding+3+40])rotate([0,90,0])cylinder(r=3, h=20,$fn=60);
  }
}
difference() {
  translate([20,12.63,0]) 
  {
    hull() {
      translate([0,0,33.8])cube([19,4,3.1]);
      translate([0,0,padding])cube([5,4,0.1]);
    }
      translate([0,0,0])cube([5,4,padding]);
  }
  hull() {
    translate([0,0,33.8+3])
      translate([23,12.63,0]) 
      rotate([-90,0,0])cylinder(r=3,h=25, $fn=60);
    translate([0,0,33.8+3])
      translate([20+19,12.63,0]) 
      rotate([-90,0,0])cylinder(r=3,h=25, $fn=60);
  }
}
