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
        cube([frame_width,frame_depth,2], center = true);
        cube([frame_width-1,frame_depth-1,3], center = true);
    }
}

module piece_number(number) {
    translate([0,0,number_height]) rotate([180,0,0]) linear_extrude(height = number_height) text(str(number), 7.5, halign="center", valign="center");
}

module number_plate(number){
    difference(){
        cylinder(d=np_diameter, h=np_height);
        piece_number(number);
    }
    translate([0,0,np_height]) cylinder(h= np_pin_height, d= np_pin_diameter);
}

module plate_collection(){
    counter = 0;
    for(x = [-(frame_width/2-np_diameter/2-1): np_diameter+2*move_tolerance: (frame_width/2-np_diameter/2-1)]){
        for(y= [-(frame_depth/2-np_diameter/2-1): np_diameter+2*move_tolerance: (frame_depth/2-np_diameter/2-1)]){
            translate([x,y,0])number_plate(counter);
            counter = counter + 1;
        }
    }
}

module numberPlate_collection(){
    // can't render, to slow
    x_start = -(frame_width/2-np_diameter/2-1);
    y_start = -(frame_depth/2-np_diameter/2-1);
    numeration_start = 0;
    numeration_end = 59;
    numeration_length = 60;
    column_amount = 12;
    row_amount = 5; //numeration_length/column_amount; // attention, if it isn't an intiger but a float to round always up

    // xx has to match row_amount-1
    x0 = [for (i=[0:column_amount-1]) (x_start+0*step_size)];
    x1 = [for (i=[0:column_amount-1]) (x_start+1*step_size)];
    x2 = [for (i=[0:column_amount-1]) (x_start+2*step_size)];
    x3 = [for (i=[0:column_amount-1]) (x_start+3*step_size)];
    x4 = [for (i=[0:column_amount-1]) (x_start+4*step_size)];
    np_xpos = concat(x0,x1,x2,x3,x4);

    // the amount of y in concat has to match row_amount
    y = [for (i=[0:column_amount-1]) (y_start+i*step_size)];
    np_ypos = concat(y,y,y,y,y);

    // you have to check manually how often the numeration_length fully in.
    numeration = [for (i=[numeration_start:numeration_end]) i];

    for(i=[numeration_start:numeration_end]){
        translate([np_xpos[i],np_ypos[i],0])number_plate(numeration[i]);
    }
}

frame();
//plate_collection();
//number_plate(34);
//piece_number(34);
numberPlate_collection();