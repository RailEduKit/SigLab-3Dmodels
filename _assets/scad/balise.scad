// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<config.scad>

balise();
module balise(){
    translate([0,0,balise_height/2]) cube([balise_width, balise_depth, balise_height], center = true);
    translate([0,0,balise_height]) cylinder(d=balise_pin_diameter, h=balise_pin_height);
}
