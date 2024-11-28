$fn = 50;// number of fragments

//general specifications
signal_width = 30;
signal_depth = 50;
signal_height = 15;

//cover specifications
cover_height = 1.5;
frame_width = 6.5; //thicker, to have the pins on all 4 sides, also needed for magnets later on
frame_overhang = 3;

//control specifications
move_tolerance = 0.5;
bottom_h = 3;
groove_h = cover_height+1; //higher, because the print support remains a bit
top_h = 2;

//body specification
body_height = signal_height-cover_height;
wall_thickness = frame_width-frame_overhang; //if the wall has to be thicker, the frame has to become thicker too
cavity_width = signal_width-2*wall_thickness;
cavity_depth = signal_depth-2*wall_thickness;
cavity_height = body_height-wall_thickness;

//connecting pins specification
pin_width = 1;
pin_depth = 4;
pin_height = 2;
hole_tolerance = 0.2;

pin_x = (signal_width-wall_thickness)/2; //wall_thicknes has to be >= 3.5mm
pin_y = (signal_depth-wall_thickness)/2;
pin_z = (cover_height/2);
pin_hole_z = (body_height-pin_height)/2;

module pin(hole = false){
    if (hole==false){
        cube([pin_width, pin_depth, pin_height], center = true);
    };
    if (hole==true){
        cube([pin_width+hole_tolerance, pin_depth+hole_tolerance, pin_height+hole_tolerance],center = true);
    };
};



//cover
module cover(){
    union(){
        difference(){
            cube([signal_width, signal_depth, cover_height], center = true);
            cube([signal_width-2*frame_width, signal_depth-2*frame_width, cover_height], center = true);
        };
        translate([pin_x,0,pin_z]) pin();
        translate([-pin_x,0,pin_z]) pin();
        translate([0,pin_y,pin_z]) rotate([0,0,90]) pin(hole = false);
        translate([0,-pin_y,pin_z]) rotate([0,0,90]) pin(hole = false);
    };
    
};
//body
module body(){
    difference(){
        union(){
            difference(){
                cube([signal_width, signal_depth, body_height], center=true);
                translate([0,0,wall_thickness]) cube([cavity_width, cavity_depth, cavity_height], center    =true);
            };
            //barrier
            difference(){
                cube([signal_width, cavity_depth/4, body_height], center=true);
                cube([cavity_width-2*(frame_overhang-(1+move_tolerance)), cavity_depth/3, body_height],     center=true);
            }; //"frame_overhang-1" creates a groove of 1mm in the middle part
        };
        translate([pin_x,0,pin_hole_z]) pin(hole = false);
        translate([-pin_x,0,pin_hole_z]) pin(hole = false);
        translate([0,pin_y,pin_hole_z]) rotate([0,0,90]) pin(hole = false);
        translate([0,-pin_y,pin_hole_z]) rotate([0,0,90]) pin(hole = false);
    };
};
//control
module control(){
    //bottom
    scaling_factor_x = (cavity_width-2*(frame_overhang-1))/(cavity_width-move_tolerance);
    scale([scaling_factor_x,1,1]) cylinder(h=bottom_h, d=cavity_width-move_tolerance);
    //cylinder(h=bottom_h, d=signal_width-(2*frame_width)+1);
    //groove
    translate([0,0,bottom_h]) cylinder(h=groove_h, d=signal_width-(2*frame_width+move_tolerance));
    //top
    translate([0,0,bottom_h+groove_h]) cylinder(h=top_h, d=signal_width);
    translate([0,0,bottom_h+groove_h+top_h+5]) rotate([0,0,90]) cube([signal_width-8, 3, 10], center=true);
};

//display objects
translate([50, 0, cover_height/2]) cover();
translate([-50, 0, body_height/2]) body();
translate([0,0,0]) rotate([0,0,0]) control(); //translate Z=bottom_h+groove_h+top_h



    