// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

$fn = 100;

magnet_rod();

module magnet_hole(){
    cylinder(h=magnet_thickness-move_tolerance, d=magnet_diameter+move_tolerance);
}

module magnet_rod(){
    difference(){
        cylinder(d=mr_diameter, h=mr_height);
        magnet_hole();
        translate([0,0,mr_height-(magnet_thickness-move_tolerance)])magnet_hole();
    }
}