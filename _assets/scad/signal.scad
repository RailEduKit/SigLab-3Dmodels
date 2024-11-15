// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
width = 24;
height = 10;
length = 20;
rim_width = 4;// must be thicker than magnet_thickness
magnet_distance = 20;
magnet_width = 5;
magnet_thickness  = 3.0;
magnet_sqeeze_tolerance = 0;
magnet_outer_distance = 0.5;
//lever_height = 10;
//lever_thickness = 4;

// core body
difference(){
    cube([length ,width, height]);
    translate([-length*0.05,rim_width,height/2]) cube([length*1.1,width-rim_width*2, height/2*1.1]);
    translate([magnet_width/2+magnet_outer_distance,magnet_thickness,magnet_width]) rotate([90,0,0]) cylinder(d = magnet_width - magnet_sqeeze_tolerance, h = magnet_thickness +1);//magnet 1
    translate([length-magnet_width/2-magnet_outer_distance,magnet_thickness,magnet_width]) rotate([90,0,0]) cylinder(d = magnet_width - magnet_sqeeze_tolerance, h = magnet_thickness +1);//magnet 2
    translate([magnet_width/2+magnet_outer_distance,width+1,magnet_width]) rotate([90,0,0]) cylinder(d = magnet_width - magnet_sqeeze_tolerance, h = magnet_thickness+1);//magnet 3
    translate([length-magnet_width/2-magnet_outer_distance,width+1,magnet_width]) rotate([90,0,0]) cylinder(d = magnet_width - magnet_sqeeze_tolerance, h = magnet_thickness+1);//magnet 4
};


// lever