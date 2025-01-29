// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

/* **TODO**
1. Symbol auf den Hebel
*/

$fn = 200;
block_width=undef;
move_tolerance=undef;
// body specifications
axis_diameter = 2.5; //maybe use the same material as lever anchor
body_width = 30; // material constraint
body_depth = 50;
body_height = 13.5; // material constraint
wall_thickness_x = (body_width-block_width-move_tolerance)/2;//5;
wall_thickness_y = 2;
wall_thickness_z = 2;
track_arc_inner_radius = 182;
sagitta = 0.43; //DE: Pfeilhöhe -> 25mm Straighten round edge in the middle
z_pos_axis = 10; // the block_height=13.5 lies a bit heigher, previous: block_height/2+wall_thickness_z

// Locking Part specifications
lock_pin_diameter = 9.5;
lock_lever_thickness = 3;
lock_lever_height = 10;

// magnet specification
magnet_thickness = 3;
magnet_diameter = 5;
magnet_distance_to_middle_y = 7.5;
magnet_z = 6;


// color_block specifications
move_tolerance = 1;
block_width = 20; //material constraint //body_width-2*wall_thickness_x-move_tolerance;
block_depth = (body_depth-2*wall_thickness_y)/2-1.5*move_tolerance;
block_height = 13.5; // material constraint
//block_height =(body_height-wall_thickness_z)*1.4; //the heigher the value, the more color_block comes out of the body. BUT also: the higher will be the axis hole
overhang = block_height/2-move_tolerance; //the circle has to be flattend at one side with move_tolerance
handle_depth = 10+wall_thickness_y;
handle_height = 3;

// main Symbol Specifications
symbol_side_space = 4;
symbol_height = 1;
symbol_thickness = 1;
symbol_size = block_width-2*symbol_side_space;
triangle_height = (sqrt(3)*symbol_size)/2;


module equ_triangle(side_length,corner_radius,triangle_height){
    // copy from https://www.youtube.com/watch?v=5hDB8Nsd688
    translate([0,corner_radius]){
    hull(){
        cylinder(r=corner_radius,h=triangle_height);
     rotate([0,0,60])translate([side_length-corner_radius*2,0,0])cylinder(r=corner_radius,h=triangle_height);   
         rotate([0,0,120])translate([side_length-corner_radius*2,0,0])cylinder(r=corner_radius,h=triangle_height);
        };
};
};

module magnet_hole(){
    cylinder(h=magnet_thickness+0.5, d=magnet_diameter+0.5);
}

//symbol_main();
module symbol_main(){
    difference(){
        cube([symbol_size, symbol_size, symbol_height]);
        translate([symbol_thickness,symbol_thickness,0]) cube([symbol_size-2*symbol_thickness, symbol_size-2*symbol_thickness, symbol_height]);
    }
}
//symbol_distant();
module symbol_distant(){
    difference(){
        equ_triangle(symbol_size, symbol_thickness, symbol_height);
        translate([0,symbol_thickness,0]) equ_triangle(symbol_size-2*symbol_thickness, symbol_thickness, symbol_height);
    }
}

module cavity_cube(){
    translate([wall_thickness_x,wall_thickness_y,wall_thickness_z]) cube([body_width-2*wall_thickness_x, body_depth-2*wall_thickness_y, body_height-wall_thickness_z]);
}
module handle_space_cubes(){
    translate([wall_thickness_x,0,z_pos_axis-(handle_height+move_tolerance)/2]) cube([body_width-2*wall_thickness_x,wall_thickness_y,body_height]); //z=wall_thickness_z+(block_height-handle_height)/2
    translate([wall_thickness_x,body_depth-wall_thickness_y,z_pos_axis-(handle_height+move_tolerance)/2]) cube([body_width-2*wall_thickness_x,wall_thickness_y,body_height]);
}

module space_locking_pin(){
    translate([0, body_depth/2 - magnet_distance_to_middle_y - magnet_diameter - move_tolerance - lock_pin_diameter, body_height - lock_lever_height])cube([wall_thickness_x-lock_lever_thickness+move_tolerance/2, lock_pin_diameter+move_tolerance, lock_lever_height]);
}
//body("main");
module body(symbol_type){
    module box(){
        difference(){
            cube([body_width, body_depth, body_height]);
            cavity_cube();
        }
    }
    module round_edge(){
        cylinder(h=body_height, r=track_arc_inner_radius);
    }
    difference(){
        intersection(){
            intersection(){
                translate([0,0,0])box();
                translate([track_arc_inner_radius-sagitta,body_depth/2,0])round_edge();
            }
            intersection(){
                translate([0,0,0])box();
                translate([body_width-track_arc_inner_radius+sagitta,body_depth/2,0])round_edge();
            }
        }
        if(symbol_type == "main"){
            space_locking_pin();
            translate([body_width-(wall_thickness_x-lock_lever_thickness+move_tolerance/2),0,0])space_locking_pin();
        }
        //magnet holes
        translate([0,body_depth/2 - magnet_distance_to_middle_y, magnet_z])rotate([0,90,0])magnet_hole();
        translate([0,body_depth/2 + magnet_distance_to_middle_y, magnet_z])rotate([0,90,0])magnet_hole();
        translate([body_width-magnet_thickness-0.5,body_depth/2 - magnet_distance_to_middle_y, magnet_z])rotate([0,90,0])magnet_hole();
        translate([body_width-magnet_thickness-0.5,body_depth/2 + magnet_distance_to_middle_y, magnet_z])rotate([0,90,0])magnet_hole();
        //axis
        translate([0,body_depth/2,z_pos_axis]) rotate([0,90,0]) cylinder(h=body_width, d=axis_diameter);
        handle_space_cubes();
    }
}

//color_block(("distant"));
module color_block(symbol_type){
    difference(){
        union(){
            cube([block_width, block_depth, block_height]);
            translate([0,block_depth,block_height/2]) scale([1,(overhang)/(block_height/2),1]) rotate([0,90,0]) cylinder(h=block_width, r=block_height/2);
            //handle
            translate([0,-handle_depth, (block_height-handle_height)/2]) cube([block_width, handle_depth, handle_height]);
        }
        //axis
        translate([0,block_depth,block_height/2]) rotate([0,90,0]) cylinder(h=block_width, d=axis_diameter);
        //symbol
        if(symbol_type == "main"){
            translate([symbol_side_space,(block_depth-symbol_size)/2,0]) symbol_main();
            translate([symbol_side_space,(block_depth-symbol_size)/2,block_height-symbol_height]) symbol_main();
        }
        if (symbol_type == "distant"){
            translate([block_width/2,triangle_height+(block_depth-triangle_height)/2,0]) rotate([0,0,180]) symbol_distant();
            translate([block_width/2,(block_depth-triangle_height)/2,block_height-symbol_height]) symbol_distant();
        }
        
    }
}


module visualize_colorBlock_in_body(symbol_type, state){
    translate([0,-body_depth/2,-z_pos_axis]) body(symbol_type); //z=-block_height/2-wall_thickness_z
    if(state== "-y"){
        rotate([0,0,0]) translate([wall_thickness_x + move_tolerance/2, -body_depth/2 + wall_thickness_y+move_tolerance*1.5,-block_height/2-wall_thickness_z+wall_thickness_z]) color_block(symbol_type=symbol_type);
    }
    if(state== "y"){
        rotate([-180,0,0]) translate([wall_thickness_x + move_tolerance/2, -body_depth/2 + wall_thickness_y+move_tolerance,-block_height/2-wall_thickness_z+wall_thickness_z]) color_block(symbol_type=symbol_type);
    }
}

module prove_moveability(){
    //move_tolerance space between bottom and color_block
    translate([0,-body_depth/2,-block_height/2]) cube([body_width,body_depth,move_tolerance]);
    //middle position
    #rotate([-90,0,0]) translate([wall_thickness_x + move_tolerance/2, -body_depth/2 + wall_thickness_y+move_tolerance,-block_height/2-wall_thickness_z+wall_thickness_z]) color_block(symbol_type=symbol_type);
}

module print_components(symbol_type){
    body(symbol_type);
    translate([-block_height-10,0,block_width]) rotate([0,90,0]) color_block(symbol_type=symbol_type);
}

module unworked_color_block(){
    height = block_height;
    width = block_width;
    depth = block_depth+handle_depth+height/2;
    cube([width, depth, height]);
    
}


module mill_color_block_side() {
    projection(cut = true) rotate([0,90,0]) difference(){
        unworked_color_block(); 
        translate([0,handle_depth,0]) color_block("distant");
        
    }
//    %unworked_color_block();
//    translate([0,handle_depth,0]) color_block(symbol_type);
}

module mill_color_block_top(symbol_type){
    projection(cut=true)difference(){
        unworked_color_block();
        if(symbol_type == "main"){
            translate([symbol_side_space,(block_depth-symbol_size)/2 + handle_depth,0]) symbol_main();
        }
        if (symbol_type == "distant"){
            translate([block_width/2,(block_depth-triangle_height)/2 + handle_depth,0]) symbol_distant();
        }
    }
    
}
module mill_color_block_bottom_distant() {
    projection(cut=true)difference(){
        unworked_color_block();
        translate([block_width/2,triangle_height+(block_depth-triangle_height)/2 + handle_depth,0]) rotate([0,0,180]) symbol_distant();
    }
}


module mill_signal_body_top_2(symbol_type){
    projection(cut=true) difference(){
            cube([body_width, body_depth, body_height]);
            body(symbol_type);
        }
        projection() handle_space_cubes();
    }
module mill_signal_body_top_1(symbol_type){
    projection(cut=true) difference(){
            cube([body_width, body_depth, body_height]);
            translate([0,0,-wall_thickness_z]) cavity_cube(); //has to be moved to the ground
            if (symbol_type == "main"){
                translate([0,0, -(body_height - lock_lever_height)]) space_locking_pin(); //has to be moved to the ground
                translate([body_width-(wall_thickness_x-lock_lever_thickness+move_tolerance/2),0,-(body_height - lock_lever_height)])space_locking_pin(); //has to be moved to the ground
                
            }
    }
}

module mill_signal_body_side(){
    // its always "distant" because the locking part shouldn't be visible at the side projection.
     projection(cut=true) translate([body_height,0,-(body_width-2)])rotate([0,-90,0])body("distant");
}
  
module values_to_console(){
    echo("handle space: ", (block_height-handle_height)/2);
    echo("axis height: ", block_height/2+wall_thickness_z);
    echo("wall_thickness_x: ", wall_thickness_x);
    echo("block_depth: ", block_depth);
    echo("y pos lockpin: ", body_depth/2 - magnet_distance_to_middle_y - magnet_diameter - move_tolerance - lock_pin_diameter);
}

module 2D_drawing_signal_body(symbol_type){
    translate([50, 50, 0]) union(){
        projection(cut = true) translate([0,0,-7])body(symbol_type);
        projection(cut = true) translate([50, 0, -body_width+1.5])rotate([0,-90,0]) body(symbol_type);
        projection(cut = true) translate([-20,0,1.5]) rotate([0,90,0]) body(symbol_type);
        projection(cut = true) translate([0,70,0]) rotate([90,0,0])body(symbol_type);
        projection(cut = true) translate([0,-20,0]) rotate([-90,0,0])body(symbol_type);
        projection(cut = true) translate([0,90,-body_depth/2]) rotate([90,0,0])body(symbol_type);
    }
}

module 2D_drawing_color_block(symbol_type){
     translate([50, 50, 0]) union(){
        mill_color_block_top(symbol_type);
        projection(cut=true) translate([30,handle_depth,block_width/2]) rotate([0,90,0]) color_block(symbol_type);
        projection(cut = true) translate([-20,handle_depth,0]) rotate([0,90,0]) color_block(symbol_type);
        projection(cut = true) translate([0, 60, -block_width-axis_diameter/2]) rotate([90,0,0]) color_block(symbol_type);
        if(symbol_type == "distant"){
           translate([50,0,0]) mill_color_block_bottom_distant();
        } 
    }
}
//visualize_colorBlock_in_body("main", "y");
//print_components("main");

/********************************
drawing
********************************/
//2D_drawing_signal_body("main");
body("main");

//2D_drawing_signal_body("distant");
//body("distant");

//2D_drawing_color_block("main");
//color_block("main");

//2D_drawing_color_block("distant");
//color_block("distant");

/********************************
mill
**********************************/
//mill_color_block_side();
//mill_color_block_top("main");
//mill_color_block_bottom_distant();
//mill_signal_body_top_1("main");
//mill_signal_body_top_2("main");
//mill_signal_body_side();

values_to_console();


