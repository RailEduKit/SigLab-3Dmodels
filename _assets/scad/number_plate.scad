// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>
$fn = 50;

module frame(){
    difference(){
        cube([180,180,2], center = true);
        cube([180-1,180-1,3], center = true);
    }
}

module piece_number() {
    translate([0,0,thin_line]) rotate([180,0,0]) linear_extrude(height = thin_line) text("12", 7.5, halign="center", valign="center");
}

module number_plate(){
    difference(){
        cylinder(d=np_diameter, h=1);
        piece_number();
    }
    
}

module plate_collection(){
    for(x=){
        for(y=){
            translate([x,y,0])number_plate();
        }
    }

}

frame();
number_plate();
//piece_number();