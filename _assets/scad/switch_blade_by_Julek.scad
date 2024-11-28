// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

$fn = 50;// number of fragments
wood_thickness  = 5;
move_tolerance   = 0.7;
sqeeze_tolerance = 0.6;

//blade specification
blade_thickness = 2.5;
blade_cover_thicknes = 0.4;
blade_length = 45;
blade_width  = 19;

//lever anchor specification
lever_hole_size = 2.7;
lever_height = blade_thickness-blade_cover_thicknes;
lever_anchor_posX = blade_width*1/5;
lever_anchor_posY = blade_length*0.7;

//pin specification
pin_diameter = 5;
pin_height = wood_thickness;

//y_pos_first_pin = //TODO
y_pos_second_pin = blade_length*2/3-pin_diameter+1;



module lever_anchor(){
    cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = lever_height);
};

module switch_blade(){ union(){
    difference(){
        intersection(){
            cylinder(r = 40, h = blade_thickness);
            translate([-blade_width/2,-pin_diameter,0]) cube([blade_width,blade_length,blade_thickness]); //why pin diameter in translate?
        };
        // flank left
        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);
        // flank right
        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);
        // lever_anchor
        translate([lever_anchor_posX,lever_anchor_posY, blade_cover_thicknes]) lever_anchor();
        translate([-lever_anchor_posX,lever_anchor_posY, blade_cover_thicknes]) lever_anchor();
    };
};
};



module pin(){
    cylinder(d = pin_diameter, h = pin_height);
};

module pin_hole(){ union(){
    difference(){
        cylinder(d = pin_diameter*1.3, h = pin_height); //pin_diameter*1.3
        cylinder(d = pin_diameter + sqeeze_tolerance, h = pin_height);
    };
};
};

module switch_male(){ union(){
    switch_blade();
    translate([0,0,blade_thickness]) pin();
    translate([0,y_pos_second_pin,blade_thickness]) pin();
};
};

module switch_female(){ union(){
    switch_blade();
    translate([0,0,blade_thickness]) pin_hole();
    translate([0,y_pos_second_pin,blade_thickness]) pin_hole();
    
};
};




//switch_male();
//switch_female();

//pin();
//lever_anchor();
switch_blade();