/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = 25.4; // [25:Dwarven Forge/Hirstarts, 25.4:OpenLOCK, 31.75:Wyloch]

/* [Magnets] */
// Size of hole for magnet.  5.5 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.5;

/* [Priority] */
// Do you want openlock or magnets to win when the two conflict
priority = "openlock"; // [openlock,magnets]

/* [Style] */
// What should the base look like on the exterior
style = "stone"; // [stone,plain]

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

module openlock_positive() {
    translate([0,-8,0]) cube([2,16,6]); 
}

module openlock_negative() {
    difference() {
        openlock_chamber(1);
        //openlock_supports(1);
    }
}

module magnet_positive(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([3.7,0,0]) cylinder(6,3.7,3.7, $fn=100);
    }
}

module magnet_negative(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([3.7,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([3.7,0,-1]) cylinder(10,.9,.9,$fn=50);
    }
}



module center_connector_positive(edge, ordinal, magnet_hole=5.5, priority="openlock") {
    if (edge == 1) {
        if (priority == "openlock") {
            openlock_positive(magnet_hole);
        } else {
            magnet_positive(magnet_hole);
        }
    } else {
        magnet_positive(magnet_hole);
    }
}

module center_connector_negative(edge, ordinal, magnet_hole=5.5, priority="openlock") {
    if (edge == 1) {
        if (priority == "openlock") {
            openlock_negative(magnet_hole);
        } else {
            magnet_negative(magnet_hole);
        }
    } else {
        magnet_negative(magnet_hole);
    }
}

module joint_connector_positive(edge, ordinal, magnet_hole=5.5, priority="openlock") {
    if(ordinal % 2 != 0 || edge % 2 != 0) {
        openlock_positive();
    }
}

module joint_connector_negative(edge, ordinal, magnet_hole=5.5, priority="openlock") {
    if(ordinal % 2 != 0 || edge % 2 != 0) {
        openlock_negative();
    }
}

module openlock_base(x,y,square_basis,
        style="plain",magnet_hole=5.5,priority="openlock") {
    difference() {
        union() {
            translate([0,0,0]) difference() {
                if (style == "stone") {
                    stone_base(x,y,square_basis);
                } else if (style == "plain") {
                    plain_base(x,y,square_basis);
                }
                translate([6.55,6.55,0]) translate([1,1,-1]) cube([square_basis*x-15.1,square_basis*y-15.1,8]);
            }

            for ( i = [0 : y-1] ) {
                translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_positive(y,i,magnet_hole, priority);
                translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,i,magnet_hole, priority);
            }
            if (y > 1) {
                for ( i = [1 : y-1] ) {
                    translate([0,square_basis*i,0]) joint_connector_positive(y,i,magnet_hole, priority);
                    translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_positive(y,i,magnet_hole, priority);
                }
            }
            for ( i = [0 : x-1] ) {
                translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_positive(x,i,magnet_hole, priority);
                translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_positive(x,i,magnet_hole, priority);
            }
            if (x > 1) {
                for ( i = [1 : x-1] ) {
                    translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_positive(y,i,magnet_hole, priority);
                    translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_positive(y,i,magnet_hole, priority);
                }
            }
        }
        
        for ( i = [0 : y-1] ) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_negative(y,i,magnet_hole, priority);
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,i,magnet_hole, priority);
        }
        if (y > 1) {
            for ( i = [1 : y-1] ) {
                translate([0,square_basis*i,0]) joint_connector_negative(y,i,magnet_hole, priority);
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_negative(y,i,magnet_hole, priority);
            }
        }
        for ( i = [0 : x-1] ) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_negative(x,i,magnet_hole, priority);
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_negative(x,i,magnet_hole, priority);
        }
        if (x > 1) {
            for ( i = [1 : x-1] ) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_negative(y,i,magnet_hole, priority);
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_negative(y,i,magnet_hole, priority);
            }
        }
    }
}

module plain_base(x,y,square_basis) {
    translate([0,0,0]) cube([square_basis*x, square_basis*y, 6]);
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

color("Grey") openlock_base(x,y,square_basis,style=style,magnet_hole=magnet_hole,priority=priority);
