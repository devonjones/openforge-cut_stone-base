/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

/* [Edge Tile Support] */
// Size of edge tile addition, 9.2 is standard for openforge
edge = 12.5;
left_edge = "false"; // [false,true]
right_edge = "false"; // [false,true]
front_edge = "false"; // [false,true]
back_edge = "false"; // [false,true]

/* [Hollow] */
// Should the base be hollow or closed?
hollow = "true"; // [false,true]
braces = 0;

/* [Magnets] */
// Size of hole for magnet.  5.5 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.5;

/* [Wire Holes] */
// Size of hole for Filament tile joining. 0:Off,1.1:1.75mm filament,1.7:3mm filament
filament_wire_hole = 1.1; // 0:Off,1.1:1.75mm filament,1.7:3mm filament
// Size of hole for paperclip tile joining. 0:Off,0.65:20 Gauge,0.7:18 Gauge
paperclip_wire_hole = 0; // 0:Off,0.65:20 Gauge,0.7:18 Gauge

/* [Construction Kit] */
ckit_squares = "false"; //[false,true]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = 25; // [25:Metric (Dwarven Forge/Hirstarts), 25.4:Imperial (Rampage/OpenLOCK/Dragonlock), 31.75:Imperial * 1.25 (Wyloch/TrueTiles)]

module wire_holes(x,y,square_basis,filament_wire_hole=1.1,paperclip_wire_hole=00,edge=12.5) {
    eoffset = -1 - edge;
    // center: 1  mm wire  18 gauge 
    // crossed: .8  mm wire  20 gauge 7.4 small  9.3 large  20 gauge
    eoffset = -1 - edge;

    ylength = 2 + 2 * edge + square_basis * y;
    if (x > 1) {
        for ( i = [2 : x] ) {
            ipos = i * square_basis - square_basis;
            if (filament_wire_hole > 0) {
                translate([ipos-3,eoffset,6/2]) rotate([-90,0,0]) cylinder(ylength,filament_wire_hole,filament_wire_hole,$fn=50);
                translate([ipos+3,eoffset,6/2]) rotate([-90,0,0]) cylinder(ylength,filament_wire_hole,filament_wire_hole,$fn=50);
            }
            if (paperclip_wire_hole > 0.0) {
                // Large Loop
                translate([ipos+4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos+4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                // Small Loop
                translate([ipos+2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(ylength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            }
        }
    }
    
    xlength = 2 + 2 * edge + square_basis * x;
    if (y > 1) {
        for ( i = [2 : y] ) {
            ipos = i*square_basis-square_basis;
            if (filament_wire_hole > 0) {
                translate([eoffset,ipos-3,6/2]) rotate([0,90,0]) cylinder(xlength,filament_wire_hole,filament_wire_hole,$fn=50);
                translate([eoffset,ipos+3,6/2]) rotate([0,90,0]) cylinder(xlength,filament_wire_hole,filament_wire_hole,$fn=50);
            }
            if (paperclip_wire_hole > 0.0) {
                // Large Loop
                translate([eoffset,ipos+4.5,6/2+1.5]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-4.5,6/2+1.5]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos+4.5,6/2-1]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-4.5,6/2-1]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                // Small Loop
                translate([eoffset,ipos+2.4,6/2+1.5]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-2.4,6/2+1.5]) rotate([0,90,0]) cylinder(xlength,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            }
        }
    }
}

module magnet_ejection_holes(x,y,square_basis,magnet_hole,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    if (magnet_hole > 0) {
        l = left_edge == "true"?edge:0;
        r = right_edge == "true"?edge:0;
        f = front_edge == "true"?edge:0;
        b = back_edge == "true"?edge:0;
        for ( i = [1 : x] ) {
            translate([i*square_basis-square_basis/2,3.6-f,-1]) cylinder(10,.9,.9,$fn=50);
            translate([i*square_basis-square_basis/2,y*square_basis-3.6+b,-1]) cylinder(10,.9,.9,$fn=50);
        }
        for ( i = [1 : y] ) {
            translate([3.6-l,i*square_basis-square_basis/2,-1]) cylinder(10,.9,.9,$fn=50);
            translate([x*square_basis-3.6+r,i*square_basis-square_basis/2,-1]) cylinder(10,.9,.9,$fn=50);
        }
    }
}

module fs_magnet_holder(magnet_hole=5.4) {
    // 5mm buckyballs
    if(magnet_hole > 0) {
        difference() {
            cylinder(6,3.7,3.7, $fn=100);
            translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
        }
    }
}

module fs_magnet_holes(magnet_hole=5.4) {
    // 5mm buckyballs
    if(magnet_hole > 0) {
        translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
    }
}

module fs_magnet_base(x,y,square_basis,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5,
        magnet_hole=5.5,filament_wire_hole=1.1,paperclip_wire_hole=0,
        ckit_squares="false",hollow="true",braces=0) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    ckit = ckit_squares == "true"?true:false;
    hollow_interior = hollow == "true"?true:false;
    
    difference() {
        union() {
            translate([-l,-f,0]) difference() {
                stone_base(x,y,square_basis,left_edge,right_edge,front_edge,back_edge,edge);
                //cube([square_basis*x+l+r,square_basis*y+f+b,6]);
                if(hollow_interior) {
                    translate([1,1,-1]) cube([square_basis*x-2+l+r,square_basis*y-2+f+b,8]);
                } else {
                    for ( i = [1 : x] ) {
                        translate([i*square_basis- square_basis/2,3.8-f,0]) fs_magnet_holes(magnet_hole);
                        translate([i*square_basis-square_basis/2,y*square_basis-3.8+b,0]) fs_magnet_holes(magnet_hole);
                    }
                    for ( i = [1 : y] ) {
                        translate([3.8-l,i*square_basis-square_basis/2,0]) fs_magnet_holes(magnet_hole);
                        translate([x*square_basis-3.8+r,i*square_basis-square_basis/2,0]) fs_magnet_holes(magnet_hole);
                    }
                }
            }
            translate([6.55-l,6.55-f,0]) difference() {
                cube([square_basis*x-13.1+l+r,square_basis*y-13.1+f+b,6]);
                translate([1,1,-1]) cube([square_basis*x-15.1+l+r,square_basis*y-15.1+f+b,8]);
            }
            translate([-l,-f,0]) difference() {
                translate([1,1,0]) cube([square_basis*x+l+r-2,square_basis*y+f+b-2,0.5]);
                translate([7,7,-1]) cube([square_basis*x-14+l+r,square_basis*y-14+f+b,8]);
            }
            for ( i = [1 : x] ) {
                translate([i*square_basis- square_basis/2,3.8-f,0]) fs_magnet_holder(magnet_hole);
                translate([i*square_basis-square_basis/2,y*square_basis-3.8+b,0]) fs_magnet_holder(magnet_hole);
            }
            for ( i = [1 : y] ) {
                translate([3.8-l,i*square_basis-square_basis/2,0]) fs_magnet_holder(magnet_hole);
                translate([x*square_basis-3.8+r,i*square_basis-square_basis/2,0]) fs_magnet_holder(magnet_hole);
            }
            if (x > 1) {
                for ( i = [2 : x] ) {
                    translate([i*square_basis-square_basis-6,-f+1,0]) cube([12,6,6]); 
                    translate([i*square_basis-square_basis-6,y*square_basis-7+b,0]) cube([12,6,6]); 
                }
            }
            if (y > 1) {
                for ( i = [2 : y] ) {
                    translate([-l+1,i*square_basis-square_basis-6,0]) cube([6,12,6]); 
                    translate([x*square_basis-7+r,i*square_basis-square_basis-6,0]) cube([6,12,6]); 
                }
            }
            translate([-l+1,-f+1,0]) cube([6,6,6]);
            translate([x*square_basis-7+r,-f+1,0]) cube([6,6,6]);
            translate([-l+1,y*square_basis-7+b,0]) cube([6,6,6]);
            translate([x*square_basis-7+r,y*square_basis-7+b,0]) cube([6,6,6]);
            if(ckit) {
                translate([-l+1+6,-f+1+6,0]) cube([6,6,6]);
                translate([x*square_basis-7+r-6,-f+1+6,0]) cube([6,6,6]);
                translate([-l+1+6,y*square_basis-7+b-6,0]) cube([6,6,6]);
                translate([x*square_basis-7+r-6,y*square_basis-7+b-6,0]) cube([6,6,6]);
            }
            difference() {
                union() {
                    translate([1-l,1-f,0]) cube([x*square_basis+r+l-2,1,6]);
                    translate([1-l,y*square_basis+b-2,0]) cube([x*square_basis+r+l-2,1,6]);
                    translate([1-l,1-f,0]) cube([1,y*square_basis+b+f-2,6]);
                    translate([x*square_basis+r-2,1-f,0]) cube([1,y*square_basis+b+f-2,6]);
                }
                for ( i = [1 : x] ) {
                    translate([i*square_basis-square_basis/2,3.7-f,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                    translate([i*square_basis-square_basis/2,y*square_basis-3.7+b,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                for ( i = [1 : y] ) {
                    translate([3.7-l,i*square_basis-square_basis/2,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                    translate([x*square_basis-3.7+r,i*square_basis-square_basis/2,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                
            }
            if(braces > 0) {
                if (y > 1) {
                    for ( i = [1 : (y-1)]) {
                        translate([1-l,i*square_basis-braces/2,0]) cube([x*square_basis-2+l+r,braces,6]);
                    }
                }
                if (x > 1) {
                    for ( i = [1 : (x-1)]) {
                        translate([i*square_basis-braces/2,1-f,0]) cube([braces,y*square_basis-2+f+b,6]);
                    }
                }
            }
        }
        wire_holes(
            x, y, square_basis,
            filament_wire_hole=filament_wire_hole,
            paperclip_wire_hole=paperclip_wire_hole);
        magnet_ejection_holes(
            x,y,square_basis,
            magnet_hole,
            left_edge=left_edge,
            right_edge=right_edge,
            front_edge=front_edge,
            back_edge=back_edge,
            edge=12.5);
    }
}

module stone_base(x,y,square_basis,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    length = square_basis*x+l+r;
    width = square_basis*y+f+b;
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

color("Grey") fs_magnet_base(x,y,square_basis,left_edge,right_edge,front_edge,back_edge,edge,magnet_hole,filament_wire_hole=filament_wire_hole,paperclip_wire_hole=paperclip_wire_hole,
    ckit_squares=ckit_squares,hollow=hollow,braces=braces);
