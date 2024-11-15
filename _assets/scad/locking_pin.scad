// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
width = 14;
height = 20;
lever_height = 10;
lever_thickness = 4;
rounding = 0.5;

minkowski() {
    difference(){
        cylinder(d = width-2*rounding, h = height-2*rounding);
        translate([(-width/2-rounding),(-lever_thickness/2-rounding),(height-(lever_height+rounding))]) cube([(width+2*rounding),(lever_thickness+2*rounding),(lever_height+rounding)]);
    };
    sphere(rounding);
}