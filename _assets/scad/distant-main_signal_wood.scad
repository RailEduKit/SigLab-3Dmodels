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

module body(){
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
    translate([0,-body_depth/2,-z_pos_axis]) body(); //z=-block_height/2-wall_thickness_z
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
    body();
    translate([-block_height-10,0,block_width]) rotate([0,90,0]) color_block(symbol_type=symbol_type);
}

module mill_color_block() {
    module unworked_block(){
        height = block_height;
        width = block_width;
        depth = block_depth+handle_depth+height/2;
        cube([width, depth, height]);
        
    }
    projection(cut = true) rotate([0,90,0]) difference(){
        unworked_block(); 
        translate([0,handle_depth,0]) color_block("distant");
        
    }
//    %unworked_block();
//    translate([0,handle_depth,0]) color_block(symbol_type);
}

module mill_signal_symbol(symbol_type){
    //where does the production need the coordinate origin?
    projection(cut=true) color_block(symbol_type);    
}


module mill_handlespace_and_rounding(){
    projection(cut=true) difference(){
            cube([body_width, body_depth, body_height]);
            body();
        }
        projection() handle_space_cubes();
    }
module mill_cavity_box(){
    projection(cut=true) difference(){
            cube([body_width, body_depth, body_height]);
            translate([0,0,-wall_thickness_z])cavity_cube();
        }
    }
    
module values_to_console(){
    echo("handle space: ", (block_height-handle_height)/2);
    echo("axis height: ", block_height/2+wall_thickness_z);
    echo("wall_thickness_x: ", wall_thickness_x);
    echo("block_depth: ", block_depth);
}


//visualize_colorBlock_in_body("distant", "y");
//print_components();
//mill_color_block();
//mill_handlespace_and_rounding();
//mill_cavity_box();
//mill_signal_symbol("distant");
values_to_console();


