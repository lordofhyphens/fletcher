// Print the hole_calibration.scad object to dial in the next 6 settings
// Google found http://www.fairburyfastener.com/xdims_metric_nuts.htm
M8=8.4;// diameter of M8 threaded rod
M5=5.3;// diameter of M5 threaded rod
M3=3.4;// diameter of M3 threaded rod
M8nut=13;// diameter of M8 nut flat to flat
M5nut=8;// diameter of M5 nut flat to flat
M3nut=5.6;// diameter of M3 nut flat to flat

M8nutThickness=6.8;// thickness of a standard M8 nut(nylock is 8mm)
M5nutThickness=4.7;// thickness of a standard M5 nut(nylock is 5mm)
M3nutThickness=2.4;// thickness of a standard M3 nut

ACME14=6.5;// diameter of 1/4 inch ACME threaded rod in mm
ACME14nut=12.8;// diameter of ACME 1/4 inch nut flat to flat in mm
ACME14nutThickness=6.5;// thickness of ACME 1/4 inch nut in mm

//rotary bearings
// format is IDxODxL
vv623=[3, 10, 4];
xx623=[3, 10, 4];
MF204=[4, 10, 4];
MF126=[6, 12, 4];
rotaryBearing=vv623;// for readability(can be changed if other bearings are used

//=======================//
// Advanced Config Items //
//=======================//
$fn=90;		// default resolution for parts, decrease if part compiling or stl/gcode is unmanageable

// added to all holes and extrusion sizes.
tolerance=0.2;
x_end_height=90;
x_end_width=40;
extrusion_width=20;

// interior separation of the vslot XZ gantry.
separation=18;

// spacing from Z towers
distance_from_2040=4; 

// height of lower Z ends
lower_z_height=30;
upper_z_height=27;

m5_screw_length=30;
wheel_inset=20;
inner_pulley_channel = 1.5*x_end_width/5;
center_pulley_channel = -0.5*x_end_width/4;
outer_pulley_channel = -2*x_end_width/5;
crossing_pulley_channel = 3*x_end_width/5;

print_area = [ 300, 300, 300 ];
bed_x = print_area[0];
bed_y = print_area[1];
bed_z = print_area[2]; 
z_tower_height = lower_z_height + bed_z;

// show extra hardware like vwheels and bearings
show_hardware = true;

echo("Needed 2040 extrusion lengths:" , str(z_tower_height));

pulley = [10,20,10];
