/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributor
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_block
 * Description: Block signal component for the Interactive Signalling Laboratory.
 * It is used to create a block signal for a track and a locking pin.
 */

// Include configuration file
include <config.scad>

// include common components
include <components/signal_box.scad>
include <components/signal_lever.scad>
include <components/driving_direction_arrow.scad>

// include other parts
use <locking_pin.scad> // used in visualize_colorBlock_in_body("block", "y");


//symbol_block();
module symbol_block(){
    difference(){
        cube([signal_symbol_size, signal_symbol_size, engraving_height]);
        translate([engraving_thickness,engraving_thickness,0])
            cube([signal_symbol_size-2*engraving_thickness, signal_symbol_size-2*engraving_thickness, engraving_height]);
    }
}

module body(){
    difference(){
        signal_box(); // import from basis_component-roundedBox
        cavity_cube_signal_box();
        //axis
        translate([0,body_depth/2,z_pos_axis]) rotate([0,90,0]) cylinder(h=body_width, d=axis_diameter);
        // handle space
        lever_space_cubes();
        // locker pin hole
        difference(){
            translate([body_width/2,body_depth-wall_thickness_y/2,0])
                cylinder(h=locker_height, d=locker_width+2*move_tolerance);
            translate([wall_thickness_x+move_tolerance,body_depth-wall_thickness_y,0])
                cube([block_width,locker_width,locker_height]);
        }
    }
    translate([body_width-wall_thickness_x+attach_arrow_wall_distance,body_depth/2,body_height]) driving_direction_arrow();
    translate([attach_arrow_wall_distance,body_depth/2,body_height]) driving_direction_arrow();
    //lock block
    lock_block_width = 6;
    lock_block_depth = 2;
    lock_block_height = z_pos_axis-handle_height/2-move_tolerance+handle_height;
    translate([(body_width-lock_block_width)/2, wall_thickness_y,0])
        cube([lock_block_width,lock_block_depth,lock_block_height]);
}

module signal_lever_block(){
    difference(){
        signal_lever();
        // locker pin hole
        translate([block_width/2,-wall_thickness_y/2-3*move_tolerance,0]) cylinder(h=locker_height, d=locker_width+2*move_tolerance);
    }
    //symbol
    translate([signal_symbol_side_space, 4*(block_depth-signal_symbol_size)/5,0]) symbol_block();
    translate([signal_symbol_side_space,4*(block_depth-signal_symbol_size)/5,block_height-engraving_height]) symbol_block();
}

module visualize_colorBlock_in_body(state){
    translate([0,-body_depth/2,-z_pos_axis]) body(); //z=-block_height/2-wall_thickness_z
    if(state== "-y"){
        rotate([0,0,0]) translate([wall_thickness_x + move_tolerance, -body_depth/2 + wall_thickness_y+3*move_tolerance,-block_height/2-wall_thickness_z+wall_thickness_z]) signal_lever_block();
    }
    if(state== "y"){
    rotate([-180,0,0]) translate([wall_thickness_x + move_tolerance, -body_depth/2 + wall_thickness_y+3*move_tolerance,-block_height/2-wall_thickness_z+wall_thickness_z]) signal_lever_block();
        translate([body_width/2,(body_depth-wall_thickness_y)/2,locker_height-0.5-z_pos_axis]) rotate([180,0,90]) locking_pin();
    }
}


body();
translate([-30,handle_depth,0]) signal_lever();
// visualize_colorBlock_in_body("-y");
