/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = 25.4; // [25:Dwarven Forge/Hirstarts, 25.4:OpenLOCK, 31.75:Wyloch]

/*
 * Openlock connection bay
 */

module openlock_chamber(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.2]);
    }
    translate([5,-5,1.4]) cube([4,5*2,4.2]);
}

module openlock_supports(buffer=0) {
    translate([0-buffer*2,-0.5,1.4-buffer]) cube([10+buffer*2,1,4.2+buffer*2]);
}

module openlock_negative() {
    difference() {
        openlock_chamber(1);
        //openlock_supports(1);
    }
}

module fs_magnet_base(x,y,square_basis) {
    glue_pad = 16;
    glue_pad_buffer = 1;
    
    intx = x > 2 ? 2 : x;
    inty = y > 2 ? 2 : y;
    difference() {
        union() {
            translate([0,0,0]) difference() {
                stone_base(x,y,square_basis);
                translate([6.55,6.55,0]) translate([1,1,-1]) cube([square_basis*x-15.1,square_basis*y-15.1,8]);
            }
            translate([intx/2*square_basis-glue_pad/2,+1-glue_pad_buffer,0]) cube([glue_pad,6+glue_pad_buffer,6]); 
            translate([intx/2*square_basis-glue_pad/2,y*square_basis-7,0]) cube([glue_pad,6+glue_pad_buffer,6]); 
            if (x > 3) {
                translate([3*square_basis-glue_pad/2,+1-glue_pad_buffer,0]) cube([glue_pad,6+glue_pad_buffer,6]); 
                translate([3*square_basis-glue_pad/2,y*square_basis-7,0]) cube([glue_pad,6+glue_pad_buffer,6]); 
            }
                translate([+1-glue_pad_buffer,inty/2*square_basis-glue_pad/2,0]) cube([6+glue_pad_buffer,glue_pad,6]); 
                translate([x*square_basis-7,inty/2*square_basis-glue_pad/2,0]) cube([6+glue_pad_buffer,glue_pad,6]); 
            if (y > 3) {
                translate([+1-glue_pad_buffer,3*square_basis-glue_pad/2,0]) cube([6+glue_pad_buffer,glue_pad,6]); 
                translate([x*square_basis-7,3*square_basis-glue_pad/2,0]) cube([6+glue_pad_buffer,glue_pad,6]); 
            }
        }

        translate([square_basis*intx/2,0,0]) rotate([0,0,90]) openlock_negative();
        translate([square_basis*intx/2,square_basis*y,0]) rotate([0,0,-90]) openlock_negative();
        if (x > 3) {
            translate([square_basis*3,0,0]) rotate([0,0,90]) openlock_negative();
            translate([square_basis*3,square_basis*y,0]) rotate([0,0,-90]) openlock_negative();
        }

        translate([0,square_basis*inty/2,0]) openlock_negative();
        translate([square_basis*x,square_basis*inty/2,0]) rotate([0,0,180]) openlock_negative();
        if (y > 3) {
            translate([0,square_basis*3,0]) openlock_negative();
            translate([square_basis*x,square_basis*3,0]) rotate([0,0,180]) openlock_negative();
        }
    }
}

module stone_base(x,y,square_basis) {
    length = square_basis*x;
    width = square_basis*y;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    intersection() {
        union() {
            for (i = [0:xblocks]) {
                for (j = [0:yblocks]) {
                    if (i == 0 || j == 0 || i == xblocks || j == yblocks) {
                        translate([i*10.2,j*10.2,0]) cube([9.2 + (i==xblocks ? 10.2 : 0),9.2 + (j==yblocks ? 10.2 : 0),5.5]);
                    }
                }
            }
        }
        cube([length, width, 6]);
    }
    translate([1,1,0]) cube([length-2, width-2, 6]);
}

color("Grey") fs_magnet_base(x,y,square_basis);
