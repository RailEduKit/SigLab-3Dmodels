// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
thickness  = 2.5;
length = 45;
width  = 15;
magnet_size = 5;

difference(){
    cube([length*1.65,width*1.2,thickness/2]);

    translate([ 7.5,10,0]) linear_extrude(height=thickness) text("+.1", size=6, halign="center");
    translate([ 7.5, 5,0]) cylinder(d = magnet_size + 0.1, h = thickness);
    
    translate([22.5,10,0]) linear_extrude(height=thickness) text(".0", size=6, halign="center");
    translate([22.5, 5,0]) cylinder(d = magnet_size - 0.0, h = thickness);
    
    translate([37.5,10,0]) linear_extrude(height=thickness) text("-.1", size=6, halign="center");
    translate([37.5, 5,0]) cylinder(d = magnet_size - 0.1, h = thickness);
    
    translate([52.5,10,0]) linear_extrude(height=thickness) text("-.2", size=6, halign="center");
    translate([52.5, 5,0]) cylinder(d = magnet_size - 0.2, h = thickness);
    
    translate([67.5,10,0]) linear_extrude(height=thickness) text("-.3", size=6, halign="center");
    translate([67.5, 5,0]) cylinder(d = magnet_size - 0.3, h = thickness);
};