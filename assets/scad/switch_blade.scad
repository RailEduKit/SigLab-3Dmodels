// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
wood_thickness  = 5;
blade_thickness = 2.1;
blade_cap_thickness = 0.4;
blade_length = 45;
blade_width  = 19;
pin_diameter = 5;
pin_height = wood_thickness;
pos_second_pin = blade_length*2/3-pin_diameter+1;
lever_hole_size = 2.7;
lever_anchor_posX = blade_width*1/5;
lever_anchor_posY = blade_length*0.7;
sqeeze_tolerance = 0.6;
move_tolerance   = 0.7;
printer_line_width = 0.1;


// switch blade male
module male(){ union(){
    // blade
    difference(){
        intersection(){
            cylinder(r = 40, h = blade_thickness);
            translate([-blade_width/2,-pin_diameter,0]) cube([blade_width,blade_length,blade_thickness]);
        };
        // flank left
        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);
        // flank right
        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);
        // blade cap notch
        #translate([-1,pin_diameter,0]) cube([2+sqeeze_tolerance,pos_second_pin-2*pin_diameter+sqeeze_tolerance,blade_thickness/2+blade_cap_thickness+sqeeze_tolerance]); 
        // pin 1 hole
        cylinder(d = pin_diameter - sqeeze_tolerance + printer_line_width/2, h = blade_thickness*2 + pin_height); // #frage: warum ein Loch? Warum Zylinder nicht einfach drauf stellen?
        // pin 2 hole
        translate([0,pos_second_pin,0]) cylinder(d = pin_diameter - sqeeze_tolerance + printer_line_width/2, h = blade_thickness*2 + pin_height);
        // lever anchor 1
        translate([lever_anchor_posX,lever_anchor_posY,0]) cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = blade_thickness*2 + pin_height);
        // lever anchor 2
        translate([-lever_anchor_posX,lever_anchor_posY,0]) cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = blade_thickness*2 + pin_height);
    };
    // pin 1
    cylinder(d = pin_diameter - sqeeze_tolerance, h = blade_thickness*2 + pin_height); // #frage: warum zweimal Balde thickness? reicht nicht einmal für das Loch, dass du vorher konstruiert hast?
    // pin 2
    translate([0,pos_second_pin,0]) cylinder(d = pin_diameter - sqeeze_tolerance, h = blade_thickness*2 + pin_height);
};
};
//
// switch blade female
module female(){ union(){
    // blade
    difference(){
        union(){
            intersection(){
                cylinder(r = 40, h = blade_thickness);
                translate([-blade_width/2,-pin_diameter,0]) cube([blade_width,blade_length,blade_thickness]);
            };
            // outer pin 1
            cylinder(d = pin_diameter*1.3, h = blade_thickness*2 + pin_height);
            // outer pin 2
            translate([0,pos_second_pin,0]) cylinder(d = pin_diameter*1.3, h = blade_thickness*2 + pin_height);
        };
        // flank left
        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);
        // flank right
        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);
        // blade cap notch
        translate([-1,pin_diameter,0]) cube([2+sqeeze_tolerance,pos_second_pin-2*pin_diameter+sqeeze_tolerance,blade_thickness/2+blade_cap_thickness+sqeeze_tolerance]);
        // inner pin 1
        cylinder(d = pin_diameter, h = blade_thickness*3 + pin_height);
        // inner pin 2
        translate([0,pos_second_pin,0]) cylinder(d = pin_diameter, h = blade_thickness*3 + pin_height);
        // lever anchor 1
        translate([lever_anchor_posX,lever_anchor_posY,0]) cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = blade_thickness*2 + pin_height);
        // lever anchor 2
        translate([-lever_anchor_posX,lever_anchor_posY,0]) cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = blade_thickness*2 + pin_height);
        //
    };
};
};
//
// switch blade cap part 1
module cap(){ union(){
    difference(){
        union(){
            intersection(){
                cylinder(r = 40, h = blade_cap_thickness);
                translate([-blade_width/2,-pin_diameter,0]) cube([blade_width,blade_length,blade_thickness]);
            };
            // notch
            #translate([-1,pin_diameter,0]) cube([2,pos_second_pin-2*pin_diameter,blade_thickness/2+blade_cap_thickness]);
        };
        // flank left
        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);
        // flank right
        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);
    };
};
};

//display objects
color("LightBlue") translate([(blade_width+2)/2,15,0]) rotate(a=[0,0,180]) male();
color("LightGreen") translate([-(blade_width+2)/2,0,0]) female();
color("blue") translate([(blade_width+2)*1.5,0,0]) cap();
color("green") translate([-(blade_width+2)*1.5,15,0]) rotate(a=[0,0,180]) cap();