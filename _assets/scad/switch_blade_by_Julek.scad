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
lever_anchor_posX = blade_width*1/5;
lever_anchor_posY = blade_length*0.8111;

//pin specification
pin_diameter = 5;
pin_height = wood_thickness;
y_pos_first_pin = pin_diameter;
y_pos_second_pin = (blade_length*2/3)+1;





module switch_blade(thickness){ union(){
    difference(){
        intersection(){
            cylinder(r = blade_length, h = thickness);
            translate([-blade_width/2,0,0]) cube([blade_width,blade_length,thickness]); //why pin diameter in translate?
        };
        // flank left
        translate([-blade_width/2,-4,-thickness/4]) rotate(a=[0,0,6]) cube([3,blade_length,thickness*2]);
        // flank right
        translate([blade_width/3,-4,-thickness/4]) rotate(a=[0,0,-6]) cube([3,blade_length,thickness*2]);
    };
};
};

module lever_anchor(){
    cylinder(d = lever_hole_size - move_tolerance + sqeeze_tolerance, h = blade_thickness);
};

module cap_notch(male=true){
    if(male==true){
        cube([2,y_pos_second_pin-2*pin_diameter,(blade_thickness-blade_cover_thicknes)/2]);
    };
    if(male==false){
        cube([2+sqeeze_tolerance,y_pos_second_pin-2*pin_diameter+sqeeze_tolerance,(blade_thickness-blade_cover_thicknes)/2+sqeeze_tolerance]);
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
    difference(){
        switch_blade(blade_thickness);
        // lever_anchor
        translate([lever_anchor_posX,lever_anchor_posY, blade_cover_thicknes]) lever_anchor();
        translate([-lever_anchor_posX,lever_anchor_posY, blade_cover_thicknes]) lever_anchor();
    };
    translate([0,y_pos_first_pin,blade_thickness]) pin();
    translate([0,y_pos_second_pin,blade_thickness]) pin();
    
};
};

module switch_female(){ union(){
    difference(){
        switch_blade(blade_thickness-blade_cover_thicknes);
        //cap notch
        translate([-1,2*pin_diameter,0]) cap_notch(male=false);
        // lever_anchor
        translate([lever_anchor_posX,lever_anchor_posY,0]) lever_anchor();
        translate([-lever_anchor_posX,lever_anchor_posY,0]) lever_anchor();
    };
    translate([0,y_pos_first_pin,blade_thickness-blade_cover_thicknes]) pin_hole();
    translate([0,y_pos_second_pin,blade_thickness-blade_cover_thicknes]) pin_hole();
};
};

module cap(){ union(){
    switch_blade(blade_cover_thicknes);
    translate([-1,2*pin_diameter,0]) cap_notch(male=true);
};
};

color("LightBlue") translate([(blade_width+2)/2,15,0]) rotate(a=[0,0,180]) switch_male();
color("LightGreen") translate([-(blade_width+2)/2,-15,0]) switch_female();
color("green") translate([-(blade_width+2)*1.5,15,0]) rotate(a=[0,0,180]) cap();

//pin();
//lever_anchor();
//switch_blade();