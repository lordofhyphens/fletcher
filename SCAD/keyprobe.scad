/* Experimental probe configuration for lift. Current hope is for a cherrymx switch, could probably work with a reed switch. */

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

translate([50,0,0])mirror([0,0,1])probe(false, [2,9,3], pos=[1,-1]);
