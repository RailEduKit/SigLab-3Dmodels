// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.


$fn = 200;

include<./specification_of_components.scad>
use<./basis_component-roundedBox.scad>

direction_management();

module arrow(){
    H = 3;
szer = 5;

translate([2.5,2.5,0]) scale([1,(szer/(2*szer*sin(120))),1]) cylinder(H,szer,szer,$fn=3);
}

module direction_management(){
    difference(){
        curvedBox(); // import from basis_component-roundedBox
        translate([body_width*(1/2),body_depth*(1/6),wall_thickness_z])cylinder(d=locker_width+move_tolerance, h=body_height-wall_thickness_z);
        translate([body_width*(1/2),body_depth*(5/6),wall_thickness_z])cylinder(d=locker_width+move_tolerance, h=body_height-wall_thickness_z);
    }
}