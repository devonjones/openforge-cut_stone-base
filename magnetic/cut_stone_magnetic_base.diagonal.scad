/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]

/* [Edge Tile Support] */
/*
// Size of edge tile addition, 9.2 is standard for openforge
edge = 12.5;
left_edge = "false"; // [false,true]
right_edge = "false"; // [false,true]
front_edge = "false"; // [false,true]
back_edge = "false"; // [false,true]
*/

/* [Magnets] */
// Size of hole for magnet.  5.4 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.5;

/* [Wire Holes] */
// Size of hole for Filament tile joining.
filament_wire_hole = 1.1; // 0:Off,1.1:1.75mm filament,1.7:3mm filament
// Size of hole for paperclip tile joining.
paperclip_wire_hole = 0; // 0:Off,0.65:20 Gauge,0.7:18 Gauge

module internal_diagonal_mortar(x) {
    color("LightGrey") intersection() {
        translate([1,25*x-1,0]) rotate([0,0,-45]) translate([0,-4.1,0]) {
            cube([sqrt(pow(25*x,2)*2)-2,8.2,6]);
            translate([-2,1,0]) cube([10.7,8.2,5]);
            translate([9.7,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*2,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*3,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*4,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*5,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*6,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*7,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*8,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*9,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*10,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*11,1,0]) cube([9.2,8.2,5]);
            translate([9.7+10.2*12,1,0]) cube([9.2,8.2,5]);
        }
        union() {
            translate([1,1,0]) cube([25*x-2,25*x-2,10]);
            translate([0,0,0]) cube([25*x,25*x,5]);
        }
    }
}

module wire_holes(x,y,filament_wire_hole=1.1,paperclip_wire_hole=00,edge=12.5) {
    eoffset = -1 - edge;
    // center: 1  mm wire  18 gauge 
    // crossed: .8  mm wire  20 gauge 7.4 small  9.3 large  20 gauge
    eoffset = -1 - edge;

    xlength = 2 + 2 * edge + 25 * x;
    if (x > 1) {
        for ( i = [2 : x] ) {
            ipos = i * 25 - 25;
            if (filament_wire_hole > 0) {
                translate([ipos-3,eoffset,6/2]) rotate([-90,0,0]) cylinder(21.5,filament_wire_hole,filament_wire_hole,$fn=50);
                translate([ipos+3,eoffset,6/2]) rotate([-90,0,0]) cylinder(21.5,filament_wire_hole,filament_wire_hole,$fn=50);
            }
            if (paperclip_wire_hole > 0.0) {
                // Large Loop
                translate([ipos+4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-4.5,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos+4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-4.5,eoffset,6/2-1]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                // Small Loop
                translate([ipos+2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([ipos-2.4,eoffset,6/2+1.5]) rotate([-90,0,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            }
        }
    }
    
    ylength = 2 + 2 * edge + 25 * y;
    if (y > 1) {
        for ( i = [2 : y] ) {
            ipos = i*25-25;
            if (filament_wire_hole > 0) {
                translate([eoffset,ipos-3,6/2]) rotate([0,90,0]) cylinder(21.5,filament_wire_hole,filament_wire_hole,$fn=50);
                translate([eoffset,ipos+3,6/2]) rotate([0,90,0]) cylinder(21.5,filament_wire_hole,filament_wire_hole,$fn=50);
            }
            if (paperclip_wire_hole > 0.0) {
                // Large Loop
                translate([eoffset,ipos+4.5,6/2+1.5]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-4.5,6/2+1.5]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos+4.5,6/2-1]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-4.5,6/2-1]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                // Small Loop
                translate([eoffset,ipos+2.4,6/2+1.5]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
                translate([eoffset,ipos-2.4,6/2+1.5]) rotate([0,90,0]) cylinder(21.5,paperclip_wire_hole,paperclip_wire_hole,$fn=50);
            }
        }
    }
}

module magnet_ejection_holes(x,y,magnet_hole,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    if (magnet_hole > 0) {
        l = left_edge == "true"?edge:0;
        r = right_edge == "true"?edge:0;
        f = front_edge == "true"?edge:0;
        b = back_edge == "true"?edge:0;
        for ( i = [1 : x] ) {
            translate([i*25-12.5,3.6-f,-1]) cylinder(10,.9,.9,$fn=50);
        }
        for ( i = [1 : y] ) {
            translate([3.6-l,i*25-12.5,-1]) cylinder(10,.9,.9,$fn=50);
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

module fs_magnet_base(x,y,
        left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5,
        magnet_hole=5.5,filament_wire_hole=1.1,paperclip_wire_hole=0) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    difference() {
        union() {
            translate([-l,-f,0]) difference() {
                stone_base(x,y,left_edge,right_edge,front_edge,back_edge,edge);
                difference() {
                    translate([1,1,-1]) cube([25*x-2+l+r,25*y-2+f+b,8]);
                    translate([25*x,0,-1]) rotate([0,0,45]) translate([-3.1,0,0]) cube([x*25*2, x*25*2, 8]);
                }
                for ( i = [1 : x] ) {
                    translate([i*25-12.5,3.7-f,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                for ( i = [1 : y] ) {
                    translate([3.7-l,i*25-12.5,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
            }
            translate([6.55-l,6.55-f,0]) difference() {
                cube([25*x-13.1+l+r,25*y-13.1+f+b,6]);
                translate([1,1,-1]) cube([25*x-15.1+l+r+2,25*y-15.1+f+b+2,8]);
            }
            translate([-l,-f,0]) difference() {
                translate([1,1,0]) cube([25*x+l+r-2,25*y+f+b-2,0.5]);
                translate([7,7,-1]) cube([25*x+1+l+r,25*y+1+f+b,8]);
            }
            for ( i = [1 : x] ) {
                translate([i*25-12.5,3.8-f,0]) fs_magnet_holder(magnet_hole);
            }
            for ( i = [1 : y] ) {
                translate([3.8-l,i*25-12.5,0]) fs_magnet_holder(magnet_hole);
            }
            if (x > 1) {
                for ( i = [2 : x] ) {
                    translate([i*25-25-6,-f+1,0]) cube([12,6,6]); 
                }
            }
            if (y > 1) {
                for ( i = [2 : y] ) {
                    translate([-l+1,i*25-25-6,0]) cube([6,12,6]); 
                }
            }
            translate([-l+1,-f+1,0]) cube([6,6,6]);
            difference() {
                union() {
                    translate([1-l,1-f,0]) cube([x*25+r+l-2,1,6]);
                    translate([1-l,1-f,0]) cube([1,y*25+b+f-2,6]);
                }
                for ( i = [1 : x] ) {
                    translate([i*25-12.5,3.7-f,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                for ( i = [1 : y] ) {
                    translate([3.7-l,i*25-12.5,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
            }
        }
        wire_holes(
            x, y,
            filament_wire_hole=filament_wire_hole,
            paperclip_wire_hole=paperclip_wire_hole);
        magnet_ejection_holes(
            x,y,
            magnet_hole,
            left_edge=left_edge,
            right_edge=right_edge,
            front_edge=front_edge,
            back_edge=back_edge,
            edge=12.5);
    }
}

module stone_base(x,y, left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    length = 25*x+l+r;
    width = 25*y+f+b;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    difference() {
        union() {
            intersection() {
                union() {
                    for (i = [0:xblocks]) {
                        for (j = [0:yblocks]) {
                            if (i == 0 || j == 0 || i == xblocks || j == yblocks) {
                                translate([i*10.2,j*10.2,0]) cube([9.2,9.2,5.5]);
                            }
                        }
                    }
                }
                cube([length, width, 6]);
            }
            translate([1,1,0]) cube([length-2, width-2, 6]);
        }
        translate([25*x,0,-1]) rotate([0,0,45]) cube([x*25*2, x*25*2, 8]);
    }
    internal_diagonal_mortar(x);
    /*translate([1,1,0]) cube([48,48,6]);
    cube([9.2,9.2,5.5]);
    translate([10.2,0,0]) cube([9.2,9.2,5.5]);
    translate([20.4,0,0]) cube([9.2,9.2,5.5]);
    translate([30.6,0,0]) cube([9.2,9.2,5.5]);
    translate([40.8,0,0]) cube([9.2,9.2,5.5]);
    translate([0,10.2,0]) cube([9.2,9.2,5.5]);
    translate([0,20.4,0]) cube([9.2,9.2,5.5]);
    translate([0,30.6,0]) cube([9.2,9.2,5.5]);
    translate([0,40.8,0]) cube([9.2,9.2,5.5]);
    translate([10.2,40.8,0]) cube([9.2,9.2,5.5]);
    translate([20.4,40.8,0]) cube([9.2,9.2,5.5]);
    translate([30.6,40.8,0]) cube([9.2,9.2,5.5]);
    translate([40.8,40.8,0]) cube([9.2,9.2,5.5]);
    translate([40.8,10.2,0]) cube([9.2,9.2,5.5]);
    translate([40.8,20.4,0]) cube([9.2,9.2,5.5]);
    translate([40.8,30.6,0]) cube([9.2,9.2,5.5]);*/
}

color("Grey") fs_magnet_base(x,x,left_edge,right_edge,front_edge,back_edge,edge,magnet_hole,filament_wire_hole=filament_wire_hole,paperclip_wire_hole=paperclip_wire_hole);





/*
module stone_diagonal_base(x, edge=12.5) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    length = 25*x+l+r;
    width = 25*x+f+b;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    color("Grey") intersection() {
        union() {
            intersection() {
                union() {
                    for (i = [0:xblocks]) {
                        for (j = [0:yblocks]) {
                            if (i == 0 || j == 0 || i == xblocks || j == yblocks) {
                                translate([i*10.2,j*10.2,0]) cube([9.2,9.2,5.5]);
                            }
                        }
                    }
                }
                cube([length, width, 6]);
            }
            translate([1,1,0]) cube([length-2, width-2, 6]);
        }
        translate([x*25,0,-1]) rotate([0,0,45+90]) cube([x*25*2,x*25*2,8]);
    }
    internal_diagonal_mortar(x);
    color("Grey") intersection() {
    }
}

stone_diagonal_base(x);
*/
