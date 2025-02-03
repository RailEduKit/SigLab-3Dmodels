// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
move_tolerance = 0.5;
width = 14;
height = 20;
lever_height = 10;
lever_thickness_switch = 4;
signal_wall_thickness = 2.5;
signal_wall_height = 10;
rounding = 0.5;
foot_width = 2.5;

// copied parameters from signal
magnet_diameter = 5;
magnet_distance_to_middle_y = 7.5;
body_height = 13.5;
z_pos_axis = 10; 
block_height = 13.5;

// signal locker specifications
signal_color_overhang = block_height/2 - (body_height-z_pos_axis);
signal_locker_width = width/2 + 15;
signal_locker_depth = (width-signal_wall_thickness-rounding)/2;
signal_locker_height = height - signal_color_overhang - signal_wall_height + 1.5;

module signal_locker(){
    minkowski() {
        translate([0,(signal_wall_thickness)/2 - rounding,0]) cube([signal_locker_width-rounding, signal_locker_depth-2*rounding, signal_locker_height-2*rounding]);
        translate([0,signal_wall_thickness/2,0]) sphere(rounding);
    }
}

minkowski() {
    difference(){
        cylinder(d = width-2*rounding, h = height-2*rounding);
        rotate([0,0,90]) translate([(-width/2),(-(lever_thickness_switch+move_tolerance)/2-rounding),(height-signal_wall_height)]) cube([(width),(lever_thickness_switch+2*rounding+move_tolerance),(lever_height+2*rounding)]);
        // signal lock
        translate([-width/2, -(signal_wall_thickness+rounding+move_tolerance)/2, height-signal_wall_height]) cube([width, signal_wall_thickness+2*rounding+move_tolerance, signal_wall_height+2*rounding]);
        #translate([foot_width+(lever_thickness_switch+move_tolerance)/2-rounding,-width/2,height-signal_wall_height]) cube([width/2,width/2, signal_wall_height+2*rounding]); //make "foot" smaller
        #translate([-(foot_width+(lever_thickness_switch+move_tolerance)/2-rounding)-width/2,-width/2,height-signal_wall_height]) cube([width/2,width/2, signal_wall_height+2*rounding]); //make "foot" smaller
    };
    sphere(rounding);
}
signal_locker();
