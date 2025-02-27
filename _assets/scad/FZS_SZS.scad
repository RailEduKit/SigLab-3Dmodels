// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

$fn = 50;

module magnet_hole(){
    cylinder(h=magnet_thickness+move_tolerance, d=magnet_diameter+move_tolerance);
}
module route_clearing_point(){
    union(){
        difference(){
            cylinder(h=engraving_height, d=cp_symbol_size);
            cylinder(h=engraving_height, d=cp_symbol_size-2*engraving_thickness);
        }   
    }
}

module block_clearing_point(){
    translate([0,0,engraving_height/2]) union(){    
        difference(){
            cube([cp_symbol_size,cp_symbol_size,engraving_height], center=true);
            cube([cp_symbol_size-2*engraving_thickness,cp_symbol_size-2*engraving_thickness,engraving_height], center=true);
        }
    }
}



module clearing_point(type){
    difference(){
        cube([zs_with,zs_depth,zs_height]);
        //Magnet holes
        translate([zs_with/2-magnet_distance_to_middle,magnet_thickness+move_tolerance,magnet_z]) rotate([90,0,0]) magnet_hole();
        translate([zs_with/2+magnet_distance_to_middle,magnet_thickness+move_tolerance,magnet_z]) rotate([90,0,0]) magnet_hole();
        translate([zs_with/2-magnet_distance_to_middle,zs_depth,magnet_z]) rotate([90,0,0]) magnet_hole();
        translate([zs_with/2+magnet_distance_to_middle,zs_depth,magnet_z]) rotate([90,0,0]) magnet_hole();
    }
    //symbols
    if(type == "rcp"){
            translate([zs_with/2,zs_depth/2,zs_height]) route_clearing_point();
    }
    if(type == "bcp"){
            translate([zs_with/2,zs_depth/2,zs_height]) block_clearing_point();
    }
}

clearing_point("bcp");
//route_clearing_point();
//block_clearing_point();