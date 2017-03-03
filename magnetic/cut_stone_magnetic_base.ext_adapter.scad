/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]
y = 2; //[1,2,3,4,5,6]

left = false; // [false,true]
right = false; // [false,true]

/* [Edge Tile Support] */

// Size of edge tile addition, 9.2 is standard for openforge
edge = 12.5;

/* [Magnets] */
// Size of hole for magnet.  5.4 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.5;

/* [Wire Holes] */
// Size of hole for Filament tile joining.
filament_wire_hole = 1.1; // 0:Off,1.1:1.75mm filament,1.7:3mm filament
// Size of hole for paperclip tile joining.
paperclip_wire_hole = 0; // 0:Off,0.65:20 Gauge,0.7:18 Gauge

module wire_holes(x,y,filament_wire_hole=1.1,paperclip_wire_hole=00,edge=12.5) {
    eoffset = -1 - edge;
    // center: 1  mm wire  18 gauge 
    // crossed: .8  mm wire  20 gauge 7.4 small  9.3 large  20 gauge
    eoffset = -1 - edge;

    ylength = 2 + 2 * edge + 25 * y;
    if (x > 1) {
        for ( i = [2 : x] ) {
            ipos = i * 25 - 25;
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
    
    xlength = 2 + 2 * edge + 25 * x;
    if (y > 1) {
        for ( i = [2 : y] ) {
            ipos = i*25-25;
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

module magnet_ejection_holes(x,y,magnet_hole, left=false,right=false,edge=12.5) {
    if (magnet_hole > 0) {
        l = 0;
        r = 0;
        f = 0;
        b = 0;
        length = 25*x;
        left_diff = left ? 12.5 : 0;
        right_diff = right ? 12.5 : 0;
        for ( i = [1 : x] ) {
            translate([i*25-12.5,3.6-f,-1]) cylinder(10,.9,.9,$fn=50);
            if(i*25-12.5-8 > left_diff && i*25-12.5+8 < length - right_diff) {
                translate([i*25-12.5,y*25-3.6+12.5,-1]) cylinder(10,.9,.9,$fn=50);
            }
        }
        for ( i = [1 : y] ) {
            translate([3.6-l,i*25-12.5,-1]) cylinder(10,.9,.9,$fn=50);
            translate([x*25-3.6+r,i*25-12.5,-1]) cylinder(10,.9,.9,$fn=50);
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

module fs_magnet_base(x,y,left=false,right=false,edge=12.5,
        magnet_hole=5.5,filament_wire_hole=1.1,paperclip_wire_hole=0) {
    length = 25*x;
    width = 25*y;
    left_diff = left ? 12.5 : 0;
    right_diff = right ? 12.5 : 0;
    ext_length = length - left_diff - right_diff;

    difference() {
        union() {
            translate([0,0,0]) difference() {
                stone_base(x,y,left,right);
                translate([1,1,-1]) cube([length-2,width-2,8]);
                translate([left_diff+1,width-2,-1]) cube([ext_length-2,edge+1,8]);
            }
            translate([6.55,6.55,0]) difference() {
                union() {
                    cube([length-13.1,width-13.1,6]);
                    translate([left_diff,width-14.1,0]) cube([ext_length-13.1,edge+1,6]);
                }
                translate([1,1,-1]) cube([25*x-15.1,25*y-15.1,8]);
                translate([left_diff+1,25*y-15.1,-1]) cube([ext_length-15.1,edge+1,8]);
            }
            translate([0,0,0]) difference() {
                union() {
                    translate([1,1,0]) cube([length-2,width-2,0.5]);
                    translate([left_diff+1,width-2,0]) cube([ext_length-2,edge+1,0.5]);
                }
                translate([7,7,-1]) cube([length-14,width-14,8]);
                translate([left_diff+7,width-8,-1]) cube([ext_length-14,edge+1,8]);
            }
            for ( i = [1 : x] ) {
                translate([i*25-12.5,3.8,0]) fs_magnet_holder(magnet_hole);
                if(i*25-12.5-8 > left_diff && i*25-12.5+8 < length - right_diff) {
                    translate([i*25-12.5,y*25-3.8+12.5,0]) fs_magnet_holder(magnet_hole);
                }
            }
            for ( i = [1 : y] ) {
                translate([3.8,i*25-12.5,0]) fs_magnet_holder(magnet_hole);
                translate([x*25-3.8,i*25-12.5,0]) fs_magnet_holder(magnet_hole);
            }
            if (x > 1) {
                for ( i = [2 : x] ) {
                    translate([i*25-25-6,1,0]) cube([12,6,6]); 
                    translate([i*25-25-6,y*25-7+edge,0]) cube([12,6,6]); 
                }
            }
            if (y > 1) {
                for ( i = [2 : y] ) {
                    translate([1,i*25-25-6,0]) cube([6,12,6]); 
                    translate([x*25-7,i*25-25-6,0]) cube([6,12,6]); 
                }
            }
            translate([1,1,0]) cube([6,6,6]);
            translate([x*25-7,1,0]) cube([6,6,6]);
            if(left_diff > 0) {
                translate([1,y*25-7,0]) cube([6,6,6]);
                translate([left_diff + 1,y*25-7 + edge,0]) cube([6,6,6]);
                translate([left_diff + 1,y*25-7,0]) cube([6,6,6]);
            } else {
                translate([1,y*25-7 + edge,0]) cube([6,6,6]);
            }
            if(right_diff > 0) {
                translate([x*25-7,y*25-7,0]) cube([6,6,6]);
                translate([x*25-7-right_diff,y*25-7 + edge,0]) cube([6,6,6]);
                translate([x*25-7-right_diff,y*25-7,0]) cube([6,6,6]);
            } else {
                translate([x*25-7,y*25-7 + edge,0]) cube([6,6,6]);
            }
            difference() {
                difference() {
                    union() {
                        translate([1,1,0]) cube([length-2,width-2,6]);
                        translate([left_diff+1,width-2,0]) cube([ext_length-2,edge+1,6]);
                    }
                    translate([2,2,-1]) cube([length-4,width-4,8]);
                    translate([left_diff+2,width-3,-1]) cube([ext_length-4,edge+1,8]);
                }
                for ( i = [1 : x] ) {
                    translate([i*25-12.5,3.7,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                    translate([i*25-12.5,y*25-3.7+edge,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                for ( i = [1 : y] ) {
                    translate([3.7,i*25-12.5,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                    translate([x*25-3.7,i*25-12.5,0]) translate([0,0,-1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);;
                }
                
            }
        }
        wire_holes(
            x, y,
            filament_wire_hole=filament_wire_hole,
            paperclip_wire_hole=paperclip_wire_hole);
        magnet_ejection_holes(x, y, magnet_hole, left, right, edge=edge);
    }
}

module stone_base(x,y, left=false,right=false,edge=12.5) {
    l = 0;
    r = 0;
    f = 0;
    b = 12.5;
    length = 25*x;
    width = 25*y;
    blength = 25*x+l+r;
    bwidth = 25*y+f+b;
    xblocks = floor(blength / 10.2);
    yblocks = floor(bwidth / 10.2);
    
    left_diff = left ? 12.5 : 0;
    right_diff = right ? 12.5 : 0;
    ext_length = length - left_diff - right_diff;
    
    intersection() {
        union() {
            for (i = [0:xblocks]) {
                for (j = [0:yblocks]) {
                    translate([i*10.2,j*10.2,0]) cube([9.2,9.2,5.5]);
                }
            }
        }
        union() {
            cube([length, width, 6]);
            translate([left_diff,width,0]) cube([ext_length, edge, 6]);
        }
    }
    translate([1,1,0]) cube([length-2, width-2, 6]);
    translate([left_diff+1,width-1,0]) cube([ext_length-2, edge, 6]);
}

color("Grey") fs_magnet_base(x,y,left,right,edge,magnet_hole,filament_wire_hole=filament_wire_hole,paperclip_wire_hole=paperclip_wire_hole);
