/* [Base Tile Size] */
x = 2; //[1,2,3,4]
y = 2; //[1,2,3,4]

/* [Edge Tile Support] */
// Size of edge tile addition, 9.2 is standard for openforge
edge_width = 12.5;
edge = "false"; // [false, true]

/* [Magnets] */
// Size of hole for magnet.  5.4 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 5.5;

/* [Wire Holes] */
// Size of hole for Filament tile joining.
filament_wire_hole = 1.1; // 0:Off,1.1:1.75mm filament,1.7:3mm filament
// Size of hole for paperclip tile joining.
paperclip_wire_hole = 0; // 0:Off,0.65:20 Gauge,0.7:18 Gauge

module wire_holes(x,y,filament_wire_hole=1.1,paperclip_wire_hole=00,edge=12.5) {
    eoffset = -1;
    // center: 1  mm wire  18 gauge 
    // crossed: .8  mm wire  20 gauge 7.4 small  9.3 large  20 gauge
    eoffset = -1;

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

module magnet_ejection_holes(x,y,magnet_hole,edge_width=12.5,edge="false") {
    if (magnet_hole > 0) {
        e = edge == "true"?edge_width:0;
        l = e;
        r = e;
        f = e;
        b = e;
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
        edge_width=12.5, edge="false",
        magnet_hole=5.5,filament_wire_hole=1.1,paperclip_wire_hole=0) {
    e = edge == "true"?edge_width:0;
    l = 0;
    r = e;
    f = 0;
    b = e;
    back_start = e > 0 ? 0 : 9.2;
    color("LightGrey") intersection() {
        scale([x < y ? ((25*x)+e)/((25*y)+e) : 1, y < x ? ((25*y)+e)/((25*x)+e) : 1,1]) translate([0,0,0]) cylinder(10,max([x, y])*25+e, max([x,y])*25+e,$fn=100);
        difference() {
            union() {
                translate([-l,-f,0]) difference() {
                    stone_base(x,y,edge_width,edge);
                    translate([1,1,-1]) cube([25*x-2+l+r+5,25*y-2+f+b+5,8]);
                }
                translate([6.55-l,6.55-f,0]) difference() {
                    cube([25*x-13.1+l+r,25*y-13.1+f+b,6]);
                    translate([1,1,-1]) cube([25*x-15.1+l+r+5,25*y-15.1+f+b+5,8]);
                }
                intersection() {
                    translate([-l,-f,0]) difference() {
                        translate([1,1,0]) cube([25*x+l+r-2,25*y+f+b-2,0.5]);
                        translate([7,7,-1]) cube([25*x-14+l+r,25*y-14+f+b,8]);
                    }
                    scale([x < y ? ((25*x)-1+e)/((25*y)-1+e) : 1, y < x ? ((25*y)-1+e)/((25*x)-1+e) : 1,1]) translate([0,0,0]) cylinder(6,max([x, y])*25-1+e, max([x,y])*25-1+e,$fn=100);
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
                        intersection() {
                            translate([0,0,0]) difference() {
                                scale([x < y ? ((25*x)+e)/((25*y)+e) : 1, y < x ? ((25*y)+e)/((25*x)+e) : 1,1]) translate([0,0,0]) cylinder(5.5,max([x, y])*25+e, max([x,y])*25+e,$fn=100);
                                scale([x < y ? ((25*x)-9.2)/((25*y)-back_start) : 1, y < x ? ((25*y)-back_start)/((25*x)-back_start) : 1,1]) translate([0,0,-1]) cylinder(10,max([x, y])*25-back_start, max([x,y])*25-back_start,$fn=100);
                                if(x == 1) {
                                    if(y == 1) {
                                        translate([0,-.5,0]) rotate([0,0,50]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 2) {
                                        translate([0,10.2*0.5,0]) rotate([0,0,0]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*1.5-3,0]) rotate([0,0,8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2.5-5,0]) rotate([0,0,17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3.5-6,0]) rotate([0,0,28]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 3) {
                                        translate([0,10.2*0.775-.5,0]) rotate([0,0,1]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*1.8-1.5,0]) rotate([0,0,4]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2.825-2.5,0]) rotate([0,0,6]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3.85-3,0]) rotate([0,0,8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*4.875-3,0]) rotate([0,0,10]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*5.9-3,0]) rotate([0,0,14]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 4) {
                                        translate([0,10.2*1.2-1,0]) rotate([0,0,1]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2.2-2,0]) rotate([0,0,4]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3.2-2.5,0]) rotate([0,0,6]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*4.2-3,0]) rotate([0,0,8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*5.2-3.5,0]) rotate([0,0,10]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*6.2-4.5,0]) rotate([0,0,14]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*7.2-4.5,0]) rotate([0,0,16]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*8.2-4.25,0]) rotate([0,0,20]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    }
                                } else if(x == 2) {
                                    if(y == 1) {
                                        translate([10.2*0.5,0,0]) rotate([0,0,90-0]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*1.5-3,0,0]) rotate([0,0,90-8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2.5-5,0,0]) rotate([0,0,90-17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3.5-6,0,0]) rotate([0,0,90-28]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 2) {
                                        translate([0,-.5,0]) rotate([0,0,17.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,32]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,46.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,61]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,75.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 3) {
                                        translate([0,10.2*1.2-4,0]) rotate([0,0,5.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2.2-6,0]) rotate([0,0,9]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3.2-8,0]) rotate([0,0,13.25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*4.2-15.7,0]) rotate([0,0,25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*5.2-20.5,0]) rotate([0,0,35]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*6.2-23.5,0]) rotate([0,0,45]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*7.2-26,0]) rotate([0,0,60.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 4) {
                                        translate([0,10.2*0.5-3,0]) rotate([0,0,2]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*1.5-7,0]) rotate([0,0,7]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2.5-10.5,0]) rotate([0,0,12]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3.5-14.25,0]) rotate([0,0,17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*4.5-16.5,0]) rotate([0,0,21]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*5.5-18.5,0]) rotate([0,0,25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*6.5-22,0]) rotate([0,0,32]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*7.5-21.5-.25,0]) rotate([0,0,36]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*8.5-19.25,0]) rotate([0,0,39]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*9.5-21,0]) rotate([0,0,55]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    }
                                } else if(x == 3) {
                                    if(y == 1) {
                                        translate([10.2*0.775-.5,0,0]) rotate([0,0,90-1]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*1.8-1.5,0,0]) rotate([0,0,90-4]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2.825-2.5,0,0]) rotate([0,0,90-6]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3.85-3,0,0]) rotate([0,0,90-8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*4.875-3,0,0]) rotate([0,0,90-10]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*5.9-3,0,0]) rotate([0,0,90-14]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 2) {
                                        translate([10.2*1.2-4,0,0]) rotate([0,0,90-5.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2.2-6,0,0]) rotate([0,0,90-9]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3.2-8,0,0]) rotate([0,0,90-13.25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*4.2-15.7,0,0]) rotate([0,0,90-25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*5.2-20.5,0,0]) rotate([0,0,90-35]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*6.2-23.5,0,0]) rotate([0,0,90-45]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*7.2-26,0,0]) rotate([0,0,90-60.5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 3) {
                                        translate([0,-.5,0]) rotate([0,0,9]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,18]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,27]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,36]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,45]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,54]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,63]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,72]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,81]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 4) {
                                        translate([0,10.2*1-2,0]) rotate([0,0,2]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*2-7.5,0]) rotate([0,0,7]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*3-12.75,0]) rotate([0,0,12]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*4-14.25-3.75,0]) rotate([0,0,17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*5-16.5-9,0]) rotate([0,0,24]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*6-18.5-10.25,0]) rotate([0,0,28]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*7-22-17,0]) rotate([0,0,38]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*8-21.5-20.5,0]) rotate([0,0,44]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*9-19.25-32,0]) rotate([0,0,55]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*10-58,0]) rotate([0,0,65]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,10.2*11-59,0]) rotate([0,0,75]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    }
                                } else if(x == 4) {
                                    if(y == 1) {
                                        translate([10.2*1.2-1,0,0]) rotate([0,0,90-1]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2.2-2,0,0]) rotate([0,0,90-4]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3.2-2.5,0,0]) rotate([0,0,90-6]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*4.2-3,0,0]) rotate([0,0,90-8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*5.2-3.5,0,0]) rotate([0,0,90-10]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*6.2-4.5,0,0]) rotate([0,0,90-14]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*7.2-4.5,0,0]) rotate([0,0,90-16]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*8.2-4.25,0,0]) rotate([0,0,90-20]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 2) {
                                        translate([10.2*0.5-3,0,0]) rotate([0,0,90-2]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*1.5-7,0,0]) rotate([0,0,90-7]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2.5-10.5,0,0]) rotate([0,0,90-12]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3.5-14.25,0,0]) rotate([0,0,90-17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*4.5-16.5,0,0]) rotate([0,0,90-21]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*5.5-18.5,0,0]) rotate([0,0,90-25]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*6.5-22,0,0]) rotate([0,0,90-32]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*7.5-21.5-.25,0,0]) rotate([0,0,90-36]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*8.5-19.25,0,0]) rotate([0,0,90-39]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*9.5-21,0,0]) rotate([0,0,90-55]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 3) {
                                        translate([10.2*1-2,0,0]) rotate([0,0,90-2]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*2-7.5,0,0]) rotate([0,0,90-7]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*3-12.75,0,0]) rotate([0,0,90-12]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*4-14.25-3.75,0,0]) rotate([0,0,90-17]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*5-16.5-9,0,0]) rotate([0,0,90-24]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*6-18.5-10.25,0,0]) rotate([0,0,90-28]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*7-22-17,0,0]) rotate([0,0,90-38]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*8-21.5-20.5,0,0]) rotate([0,0,90-44]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*9-19.25-32,0,0]) rotate([0,0,90-55]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*10-58,0,0]) rotate([0,0,90-65]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([10.2*11-59,0,0]) rotate([0,0,90-75]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    } else if(y == 4) {
                                        translate([0,-.5,0]) rotate([0,0,90/14-.0625*12]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*2-.0625*11]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*3-.0625*10]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*4-.0625*9]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*5-.0625*8]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*6-.0625*7]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*7-.0625*6]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*8-.0625*5]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*9-.0625*4]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*10-.0625*3]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*11-.0625*2]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*12-.0625]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                        translate([0,-.5,0]) rotate([0,0,90/14*13]) translate([0,0,-1]) cube([25*(max(x,y))+1+e,1,8]);
                                    }
                                }
                            }
                            translate([1,1,0]) cube([25*x+e,25*y+e,10]);
                        }
                        intersection() {
                            translate([0,0,0]) difference() {
                                scale([x < y ? ((25*x)-1+e)/((25*y)-1+e) : 1, y < x ? ((25*y)-1+e)/((25*x)-1+e) : 1,1]) translate([0,0,0]) cylinder(6,max([x, y])*25-1+e, max([x,y])*25-1+e,$fn=100);
                                scale([x < y ? ((25*x)-9.2)/((25*y)-back_start) : 1, y < x ? ((25*y)-back_start)/((25*x)-back_start) : 1,1]) translate([0,0,-1]) cylinder(10,max([x, y])*25-back_start, max([x,y])*25-back_start,$fn=100);
                            }
                            translate([1,1,0]) cube([25*x+e,25*y+e,10]);
                        }
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
                edge_width=12.5,
                edge=edge);
        }
    }
}

module stone_base(x,y,edge_width=12.5,edge="false") {
    e = edge == "true"?edge_width:0;
    l = e;
    r = e;
    f = e;
    b = e;
    length = 25*x+l+r;
    width = 25*y+f+b;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    intersection() {
        union() {
            for (i = [0:xblocks]) {
                translate([i*10.2,0,0]) cube([9.2,9.2,5.5]);
            }
            for (j = [0:yblocks]) {
                translate([0,j*10.2,0]) cube([9.2,9.2,5.5]);
            }
        }
        cube([length, width, 6]);
    }
    translate([1,1,0]) cube([length-2, width-2, 6]);

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

fs_magnet_base(x,y,edge_width,edge,magnet_hole,filament_wire_hole=filament_wire_hole,paperclip_wire_hole=paperclip_wire_hole);
