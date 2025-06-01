// Copyright 2019 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments
wood_thickness  = 7;
blade_thickness = 2.5;
blade_length = 45;
blade_width  = 19;
pin_size = 5;
lever_length    = 50;
lever_hole_size = 3;
lever_thickness = 4.5;
knob_size       = 10;
knob_length     = 14;

//// switch blade part 1
//color("LightBlue",alpha) translate([17,0,0]) union(){
//    // blade
//    difference(){
//        intersection(){
//            cylinder(r = 40, h = blade_thickness);
//            translate([-blade_width/2,-pin_size,0]) cube([blade_width,blade_length,blade_thickness]);
//        };
//        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);// flank left
//        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);// flank right
//    };
//    //
//    // pin 1
//    cylinder(d = pin_size, h = blade_thickness*2 + wood_thickness);
//    // pin 2
//    translate([0,blade_length*2/3-pin_size,0]) cylinder(d = pin_size, h = blade_thickness*2 + wood_thickness);
//    // lever anchor 1
//    translate([blade_width*1/4,blade_length*0.7,0]) cylinder(d = lever_hole_size, h = blade_thickness*2 + wood_thickness);
//    // lever anchor 2
//    translate([-blade_width*1/4,blade_length*0.7,0]) cylinder(d = lever_hole_size, h = blade_thickness*2 + wood_thickness);
//}
////
//// switch blade part 2
//color("LightGreen",alpha) translate([-17,0,0]) union(){
//    // blade
//    difference(){
//        union(){
//            intersection(){
//                cylinder(r = 40, h = blade_thickness);
//                translate([-blade_width/2,-pin_size,0]) cube([blade_width,blade_length,blade_thickness]);
//            };
//            cylinder(d = pin_size*1.3, h = blade_thickness*2 + wood_thickness);// outer pin 1
//            translate([0,blade_length*2/3-pin_size,0]) cylinder(d = pin_size*1.3, h = blade_thickness*2 + wood_thickness);// outer pin 2
//        };
//        translate([-blade_width/2,-9,-1]) rotate(a=[0,0,6]) cube([3,blade_length,blade_thickness*2]);// flank left
//        translate([blade_width/3,-9,-1]) rotate(a=[0,0,-6]) cube([3,blade_length,blade_thickness*2]);// flank right
//        //
//        cylinder(d = pin_size, h = blade_thickness*3 + wood_thickness);// inner pin 1
//        translate([0,blade_length*2/3-pin_size,0]) cylinder(d = pin_size, h = blade_thickness*3 + wood_thickness);// inner pin 2
//        // lever anchor 1
//        translate([blade_width*1/4,blade_length*0.7,0]) cylinder(d = lever_hole_size, h = blade_thickness*2 + wood_thickness);
//        // lever anchor 2
//        translate([-blade_width*1/4,blade_length*0.7,0]) cylinder(d = lever_hole_size, h = blade_thickness*2 + wood_thickness);
//        //
//    };
//};
//
////

difference(){
    union(){
    cube([blade_length*1.55,blade_width*1.2,blade_thickness/2]);
        translate([ 5, 5,0]) cylinder(d = pin_size - 0.1, h = wood_thickness);
        translate([ 5,20,0]) cylinder(d = lever_hole_size - 0.1, h = wood_thickness);

        translate([20, 5,0]) cylinder(d = pin_size - 0.2, h = wood_thickness);
        translate([20,20,0]) cylinder(d = lever_hole_size - 0.1, h = wood_thickness);

        translate([35, 5,0]) cylinder(d = pin_size - 0.3, h = wood_thickness);
        translate([35,20,0]) cylinder(d = lever_hole_size - 0.1, h = wood_thickness);

        translate([50, 5,0]) cylinder(d = pin_size - 0.4, h = wood_thickness);
        translate([50,20,0]) cylinder(d = lever_hole_size - 0.1, h = wood_thickness);

        translate([65, 5,0]) cylinder(d = pin_size - 0.5, h = wood_thickness);
        translate([65,20,0]) cylinder(d = lever_hole_size - 0.1, h = wood_thickness);
    };

    translate([ 5,10,0]) linear_extrude(height=blade_thickness) text(".1", size=6, halign="center");
    translate([20,10,0]) linear_extrude(height=blade_thickness) text(".2", size=6, halign="center");
    translate([35,10,0]) linear_extrude(height=blade_thickness) text(".3", size=6, halign="center");
    translate([50,10,0]) linear_extrude(height=blade_thickness) text(".4", size=6, halign="center");
    translate([65,10,0]) linear_extrude(height=blade_thickness) text(".5", size=6, halign="center");
};