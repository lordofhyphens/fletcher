use<inc/functions.scad>


module panel_bracket(stock=8, holder=3, thick=15, offset=70, bolt=false) 
{
  difference() {
    cube([40,offset+20+stock+holder*2,thick]); // basic shape
    translate([10,10,0])ext2020(thick, teeth=[1,0,0,0]); // 2020 extrusion cutout
    translate([26,-20+holder,0])color("blue")cube([90, 20+20+offset-stock,thick]);
    translate([0,30+holder,0])color("blue")cube([10, offset-stock-10,thick]);
    translate([10,offset+20+holder,0])color("blue")cube([90, stock,thick]);
    if (bolt)
      translate([32,0,5])rotate([-90,0,0])cylinder(r=1.5, h=20+holder*2+stock,$fn=50); // hole to bolt stock on.
  }
}

panel_bracket(stock=(5/16)*25.4);
translate([-50,0,0])panel_bracket(stock=(5/16)*25.4, offset=110);
