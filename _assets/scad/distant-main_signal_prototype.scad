$fn = 50;// number of fragments

//general specifications
signal_width = 20;
signal_depth = 50;
signal_height = 15;

//cover specifications
cover_height = 3;
frame_width = 4;

//control specifications
groove_depth = 1.5;
move_tolerance = 0.5;
bottom_h = 3;
groove_h = cover_height+move_tolerance;
top_h = 3;



//body specification
body_height = signal_height-cover_height;
wall_thickness = frame_width-(groove_depth+move_tolerance); //if the wall gets thicker, the frame has to become thicker too

//connecting pins specification
pin_d = 1;
pin_height = 2;
pin_x = (signal_width/2)-(wall_thickness/2);
pin_y = signal_depth/4;

pin_z = body_height/2;
pin_hole_z = (cover_height/2)-pin_height; //only half of the cover is above z=0
hole_tolerance = 0.2;


//cover
module cover(){
    difference(){
        cube([signal_width, signal_depth, cover_height], center = true);
        cube([signal_width-2*frame_width, signal_depth-2*frame_width, cover_height], center = true);
        //pin hole
        translate([pin_x, pin_y, pin_hole_z]) cylinder(pin_height+hole_tolerance, d=pin_d+hole_tolerance);
        translate([-pin_x, pin_y, pin_hole_z]) cylinder(pin_height+hole_tolerance, d=pin_d+hole_tolerance);
        translate([pin_x, -pin_y, pin_hole_z]) cylinder(pin_height+hole_tolerance, d=pin_d+hole_tolerance);
        translate([-pin_x, -pin_y, pin_hole_z]) cylinder(pin_height+hole_tolerance, d=pin_d+hole_tolerance);
    };
};
//body
module body(){
    difference(){
        cube([signal_width, signal_depth, body_height], center=true);
        translate([0,0,wall_thickness]) cube([signal_width-2*wall_thickness, signal_depth-2*        wall_thickness, body_height-wall_thickness], center=true);
    };
        //pins
        translate([pin_x, pin_y, pin_z]) cylinder(pin_height, d=pin_d);
        translate([-pin_x, pin_y, pin_z]) cylinder(pin_height, d=pin_d);
        translate([pin_x, -pin_y, pin_z]) cylinder(pin_height, d=pin_d);
        translate([-pin_x, -pin_y, pin_z]) cylinder(pin_height, d=pin_d);
};
//control
module control(){
    //bottom
    cylinder(h=bottom_h, d=signal_width-(2*wall_thickness+move_tolerance));
    //groove
    translate([0,0,bottom_h]) cylinder(h=groove_h, d=signal_width-(2*frame_width+move_tolerance));
    //top
    translate([0,0,bottom_h+groove_h]) cylinder(h=top_h, d=signal_width);
};



translate([25, 0, cover_height/2]) cover();
translate([-25, 0, body_height/2]) body();
translate([0,0,bottom_h+groove_h+top_h]) rotate([180,0,0]) control();



    