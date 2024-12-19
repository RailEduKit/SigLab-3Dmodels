// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

 /**
 To render this shape, you will need
 * [tracklib.scad](http://www.thingiverse.com/thing:216915) installed in the same
 * directory as this file or you clone the hole library to the library folder of your openSCAD: [dotscad/trains](https://github.com/dotscad/trains). 
 
 * FURTHERMORE: you need to clone the dotscad library 
 * (https://github.com/dotscad/dotscad.git) to your openSCAD library folder.
 * tracklib.scad uses this library.
 */
 
 // Import tracklib from globally-installed copy
use <trains/tracklib.scad>; // the hole library "trains" is stored in the openSCAD folder "library"


/* [parameters for the switch_body] */

// Connector to place on the base end of the piece.
base = "male"; // [male,female]

// Render a curve to the left with the requested connector, or none for no curve.
left = "female"; // [male,female,none]

// Render a straight center track with the requested connector, or none for no straight track.
straight = "female"; // [male,female,none]

// Render a curve to the left with the requested connector, or none for no curve.
right = "none"; // [male,female,none]

// Length of the straight track, or auto to use the best fit for the requested curve radius.
straight_size = 145; // [auto:auto, 51:xsmall, 102:small, 152:medium, 203:large, 254:xlarge, 305:xxlarge]

// Curve radius.  Sizes provided are standard.
radius = 182; // [87.5:small, 180:large]

/* [Hidden] */

// Angle of track to render.  45 is standard.
angle = 45; // [1:360]

// Wheel wells on both sides of the track?
double_sided_rails = true;

/* [parameters for the switch_blade] */
// coppy values from switch_blade
blade_length = 45;
blade_width  = 19;
pin_diameter = 5;
pin_female_diameter = pin_diameter*1.3;
lever_anchor_posY = blade_length*0.8111;
y_pos_second_pin = (blade_length*2/3)+1;




// Lots of facets
$fn=120;

// Render the part
//render_track(base, left, straight, right, straight_size, radius, angle, double_sided_rails);

/* ******************************************************************************
 * Main module code below:
 * ****************************************************************************** */

// Import tracklib from globally-installed copy
use <trains/tracklib.scad>;

/*
 * @param string base              Connector to place on the base end of the piece.
 * @param string left              Render a curve to the left with the requested connector, or none for no curve.
 * @param string straight          Render a straight center track with the requested connector, or none for no straight track.
 * @param string right             Render a curve to the left with the requested connector, or none for no curve.
 * @param string|int straight_size Length of the straight track, or auto to use the best fit for the requested curve radius.
 * @param float radius             Curve radius (usually 87.5 or 180)
 * @param float angle              Angle of track to render.  45 is standard
 * @param boolean double_sided_rails    True: Wheel Wells on both sides of the track
 */
module render_track(base, left, straight, right, straight_size, radius, angle, double_sided_rails) {
    straight_length = (
        straight_size == "auto"
        ? ((left == "none" && right == "none")
            ? -1 // Wish we could throw an exception in OpenSCAD
            : ((radius ==  87.5)
                ? 102
                : 152
            )
        )
        : straight_size
    );
    if (straight_length == -1) {
        echo("ERROR: When using straight_size==auto, you must render a right or left curve.");
    }
    else {
        translate([-radius,0,0]) difference() {
            union() {
                if (straight != "none") {
                    translate([radius+wood_width(),0,0])
                        rotate([0,0,90])
                        wood_track(straight_length, false);
                    if (straight == "male") {
                        translate([radius+wood_width()/2,straight_length,0])
                            rotate([0,0,90])
                            wood_plug();
                    }
                }
                if (left != "none") {
                    wood_track_arc(radius, angle, false);
                    if (left == "male") {
                        rotate([0,0,angle])
                            translate([radius+wood_width()/2,0,0])
                            rotate([0,0,90])
                            wood_plug();
                    }
                }
                if (right != "none") {
                    translate([radius*2+wood_width(),0,0])
                        rotate([0,0,180-angle])
                        wood_track_arc(radius, angle, false);
                    if (right == "male") {
                        translate([radius*2+wood_width(),0,0]) rotate([0,0,180-angle])
                            translate([radius+wood_width()/2,0,0])
                            rotate([0,0,-90])
                            wood_plug();
                    }
                }
                if (base == "male") {
                    translate([radius+wood_width()/2,0,0])
                        rotate([0,0,-90])
                        wood_plug();
                }
            }
            // Subtract any requested female connector regions
            if (straight == "female") {
                translate([radius+wood_width()/2,straight_length,0])
                    rotate([0,0,-90])
                    wood_cutout();
            }
            if (left == "female") {
                rotate([0,0,angle])
                    translate([radius+wood_width()/2,0,0])
                    rotate([0,0,-90])
                    wood_cutout();
            }
            if (right == "female") {
                translate([radius*2+wood_width(),0,0]) rotate([0,0,180-angle])
                    translate([radius+wood_width()/2,0,0])
                    rotate([0,0,90])
                    wood_cutout();
            }
            if (base == "female") {
                translate([radius+wood_width()/2,0,0])
                    rotate([0,0,90])
                    wood_cutout();
            }
            // Now we can subtract the "rails"
            if (straight != "none") {
                translate([radius+wood_width(),0,0]) rotate([0,0,90]) wood_rails(straight_length);
                if (double_sided_rails){
                    translate([radius,0,wood_height()]) rotate([180,0,90]) wood_rails(straight_length);
                }
            }
            if (left != "none") {
                wood_rails_arc(radius, angle);
                if (double_sided_rails){
                    rotate([180,0,angle])translate([0,0,-wood_height()])wood_rails_arc(radius, angle);
                }
            }
            if (right != "none") {
                translate([radius*2+wood_width(),0,0]) rotate([0,0,180-angle]) wood_rails_arc(radius, angle);
                if (double_sided_rails){
                    rotate([180,0,angle])translate([0,0,-wood_height()])wood_rails_arc(radius, angle);
                }
            }
        }
    }
}

module subtract_rail(blade_length){
    //the values are mostly trial and error
    x = wood_width()/2;
    h = wood_height()-wood_well_height();
    mill_length = blade_length+7; //this shouldn't be changed
    mill_start = 20; // this shouldn't be changed
    outer_r = blade_length;
    y_outer_r = (mill_length+mill_start)-outer_r;
    middle_r = 150; // the outer_r doesn't take the hole track away
    y_middle_r = (mill_length+mill_start)-6-middle_r;
    inner_r = 150;
    y_inner_r = mill_start-inner_r;

    
    union(){
        translate([x,y_outer_r,0]) rotate([0,0,90-angle/2+5])rotate_extrude(angle=50) square([outer_r,h]); //same radius as the switch_blade
        difference(){
            translate([x,y_middle_r,0]) rotate([0,0,90-angle/2+17])rotate_extrude(angle=13) square([middle_r,h]); //take away a few remains
            translate([x,y_inner_r,0]) rotate([0,0,90-angle/2+18])rotate_extrude(angle=10) square([inner_r,h]); //clear cut at the bottom
        }
    }
}

module pivot_hole(pin_female_diameter){
    x=wood_width()/2;
    y=30;
    translate([x,y,0]) cylinder(h=wood_height(), d=pin_female_diameter+1);
    
}
//moving_area(pin_diameter,pin_female_diameter,lever_anchor_posY, y_pos_second_pin);
module moving_area(pin_diameter, pin_female_diameter, y_lever_anchor, y_second_pin){
    h = wood_height();
    module area_length(){
        a=50;
        center_x=wood_width()/2;
        center_y=30-pin_diameter; //30 should equal the y value of pivot_hole
        outer_r = y_lever_anchor+5;// has to be adjusted, when I have acces to modified switch without blade
        inner_r = y_second_pin-pin_female_diameter;
        difference(){ 
            translate([center_x,center_y,0]) rotate([0,0,90-20]) rotate_extrude(angle=a) square([outer_r,h]);
            translate([center_x,center_y,0]) rotate([0,0,90-20]) rotate_extrude(angle=a) square([inner_r,h]);
        }
    }
    module curved_boundery(){
        radius1 = 182+5+wood_well_spacing(); // to get a 3D object
        radius2 = 182+16; //the blade shouldn't go more to the side as: 16= wood_well_rim()+wood_well_width()+(blade_width-pin_female_diameter)/2 
        translate([-radius,0,0]) difference(){
            rotate_extrude(angle=45) square([radius1,h]);
            rotate_extrude(angle=45) square([radius2,h]);
        }
    }
    module straight_boundery(){
        x_size=12;
        y_size=140;
        xpos = (wood_width()+pin_female_diameter)/2 -x_size +1;// +1 -> the boundery should be slightly left of the pivot hole.
        translate([xpos,0,0]) cube([x_size,y_size,h]);
    }
    union(){
        intersection(){
            area_length();
            curved_boundery();
        }
        intersection(){
            area_length();
            straight_boundery();
        }
    } 
}

modified_switch();
module modified_switch(){
    difference(){
        render_track(base, left, straight, right, straight_size, radius, angle, double_sided_rails);
        subtract_rail(blade_length);
        translate([0,0,wood_well_height()])subtract_rail(blade_length);
        pivot_hole(pin_female_diameter);
        moving_area(pin_diameter,pin_female_diameter,lever_anchor_posY, y_pos_second_pin);
        
    }
}