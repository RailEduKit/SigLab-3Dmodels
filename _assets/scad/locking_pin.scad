// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>
   
$fn = 50;// number of fragments
//locker_width = 14;
//locker_height = 20;
//lever_height = 10;
//lever_thickness_switch = 4;
//rounding = 0.5;

//// copied parameters from signal
//magnet_diameter = 5;
//magnet_distance_to_middle_y = 7.5;
//body_height = 13.5;
//z_pos_axis = 10; 
//block_height = 13.5;


minkowski() {
    difference(){
        cylinder(d = locker_width-2*rounding, h = locker_height-2*rounding);
        rotate([0,0,90]) translate([(-locker_width/2),(-(lever_thickness_switch+move_tolerance)/2-rounding),(locker_height-lever_height)])cube([(locker_width),(lever_thickness_switch+2*rounding+move_tolerance),(lever_height+2*rounding)]);
    };
    sphere(rounding);
}
//signal_locker();
