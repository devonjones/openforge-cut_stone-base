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

module stone_base(x,y, left_edge="false",right_edge="false",front_edge="false",back_edge="false",edge=12.5) {
    l = left_edge == "true"?edge:0;
    r = right_edge == "true"?edge:0;
    f = front_edge == "true"?edge:0;
    b = back_edge == "true"?edge:0;
    length = 25*x+l+r;
    width = 25*y+f+b;
    xblocks = floor(length / 10.2);
    yblocks = floor(width / 10.2);
    
    color("Grey") intersection() {
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
    color("Grey") translate([1,1,0]) cube([length-2, width-2, 6]);
}

stone_base(x,y,left_edge,right_edge,front_edge,back_edge,edge);
