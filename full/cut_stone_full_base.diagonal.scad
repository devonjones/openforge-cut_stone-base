/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6]

/* [Edge Tile Support] */
// Size of edge tile addition, 9.2 is standard for openforge
/*
edge = 12.5;
left_edge = "false"; // [false,true]
right_edge = "false"; // [false,true]
front_edge = "false"; // [false,true]
back_edge = "false"; // [false,true]
*/

module internal_diagonal_mortar(x) {
    color("LightGrey") difference() {
        intersection() {
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
        translate([x*25,0,-1]) rotate([0,0,45+90]) cube([x*25*2,x*25*2,8]);
    }
}

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
