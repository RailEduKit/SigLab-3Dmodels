$fn = 50;// number of fragments

//general specifications
signal_width = 30;
signal_depth = 50;
signal_height = 12;

//cover specifications
cover_height = 1.5;
frame_width = 4.5;
frame_overhang = 1;

//body specification
body_height = signal_height-cover_height;
wall_thickness = frame_width-frame_overhang; //if the wall has to be thicker, the frame has to become thicker too
ground_thickness = 2;
cavity_width = signal_width-2*wall_thickness;
cavity_depth = signal_depth-2*wall_thickness;
cavity_height = body_height-ground_thickness;
lock_passage_y = (signal_depth-wall_thickness)/2;

//control specifications
move_tolerance = 0.5;
bottom_width = cavity_width-move_tolerance;
bottom_depth = cavity_depth/2;
bottom_h = 3;
groove_width = signal_width-2*frame_width-move_tolerance;
groove_depth = (signal_depth/2)-2*frame_width-move_tolerance;
groove_h = cover_height+1; //higher, because the print support remains a bit
top_width = signal_width;
top_depth = (signal_depth/2)+2*frame_overhang;
top_h = 2;
lock_width = 7;
lock_depth = wall_thickness+5;
lock_heigth = 2;
lockpin_d = 3;

//connecting pins specification
pin_width = 1;
pin_depth = 4;
pin_height = 2;
hole_tolerance = 0.2;

pinA_x = (signal_width-wall_thickness)/2; //wall_thicknes has to be >= 3.5mm
pinA_y = ((signal_depth/2)-wall_thickness);
pin_z = (cover_height/2);
pin_hole_z = (body_height-pin_height)/2;

//stopper specification
stopper_width = signal_width-2;
stopper_depth = 10;
stopper_top_thickness = 1.5;
stopper_side_thickness = lockpin_d;
stopper_height = bottom_h+groove_h+top_h+stopper_top_thickness+move_tolerance;

//color block specification
c_block_width = cavity_width-move_tolerance;
c_block_depth = cavity_depth/2 - move_tolerance;
c_block_height = 2; // has to be < cavity_height-bottom_h-groove_h-2*move_tolerance

module pin(){
    cube([pin_width, pin_depth, pin_height], center = true);
//    if (hole==true){
//        cube([pin_width+hole_tolerance, pin_depth+hole_tolerance, pin_height+hole_tolerance],center = true);
//    };
};




module cover(){
    union(){
        difference(){
            cube([signal_width, signal_depth, cover_height], center = true);
            cube([signal_width-2*frame_width, signal_depth-2*frame_width, cover_height], center = true);
        };
        translate([pinA_x,pinA_y,pin_z]) pin();
        translate([-pinA_x,pinA_y,pin_z]) pin();
        translate([pinA_x,-pinA_y,pin_z]) pin();
        translate([-pinA_x,-pinA_y,pin_z]) pin();
    };
    
};

module body(){
    difference(){
        union(){
            difference(){
                cube([signal_width, signal_depth, body_height], center=true);
                translate([0,0,ground_thickness/2]) cube([cavity_width, cavity_depth, cavity_height], center    =true);
            };
        };
        translate([pinA_x,pinA_y,pin_hole_z]) pin();
        translate([-pinA_x,pinA_y,pin_hole_z]) pin();
        translate([pinA_x,-pinA_y,pin_hole_z]) pin();
        translate([-pinA_x,-pinA_y,pin_hole_z]) pin();
        // color block pin
        translate([0,(cavity_depth-move_tolerance/2)/4, -pin_hole_z]) pin();
        translate([0,-(cavity_depth-move_tolerance/2)/4, -pin_hole_z]) pin();
        //lock passage
        translate([0,lock_passage_y,(body_height-(bottom_h+move_tolerance))/2]) cube([lock_width+move_tolerance,wall_thickness,bottom_h+2*move_tolerance], center=true);
    };
};


module control(){
    //bottom
    translate([0,0,bottom_h/2]) cube([bottom_width, bottom_depth, bottom_h], center=true);
    //lock
    difference(){
        translate([0,(bottom_depth+lock_depth)/2,lock_heigth/2]) cube([lock_width, lock_depth, lock_heigth],center=true);
        translate([0,bottom_depth/2+wall_thickness+lockpin_d/2+1,0]) cylinder(lock_heigth, d=lockpin_d+move_tolerance);
    };
    //groove
    translate([0,0,bottom_h+(groove_h/2)]) cube([groove_width, groove_depth, groove_h], center=true);
    //top
    translate([0,0,bottom_h+groove_h+(top_h/2)]) cube([top_width, top_depth, top_h], center=true);
    //handle
    translate([0,0,bottom_h+groove_h+top_h+5]) cube([signal_width-8, 3, 10], center=true);
};


module stopper(){
    difference(){
        cube([stopper_width,stopper_depth,stopper_height]);
        cube([stopper_width,stopper_depth-stopper_side_thickness, stopper_height-stopper_top_thickness]);
        translate([(stopper_width-(lock_width+move_tolerance))/2,stopper_depth-stopper_side_thickness,0]) cube([lock_width+move_tolerance, stopper_side_thickness, lock_heigth+move_tolerance]);//
    };
    translate([stopper_width/2, stopper_depth-lockpin_d/2, 0]) cylinder(lock_heigth+move_tolerance, d=lockpin_d);
    
};


module color_block(){
    cube([c_block_width, c_block_depth, c_block_height], center=true);
    translate([0,0,c_block_height]) pin();
    
};


//display objects
position = 27;
translate([position, position, cover_height/2]) cover();
translate([-position, position, body_height/2]) body();
translate([-position,-position,0]) control(); //translate Z=bottom_h+groove_h+top_h
translate([position/2, -position/2, stopper_height]) rotate([180,0,0]) stopper();
translate([-position, -2*position,0]) color_block();
translate([position, -2*position,0]) color_block();



    