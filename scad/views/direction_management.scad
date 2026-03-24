/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: direction_management
 */

// include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
use <../assemblies/direction_management_lever.scad>
use <../assemblies/direction_management_box.scad>
use <../assemblies/locking_pin.scad>



 module direction_management(state, locker = false){
         union(){
            translate([0,-body_depth/2,-z_pos_axis]) direction_management_box();
            if(state == "-y"){
                //z=-arrow_block_height()/2-wall_thickness_z if(state== "-y"){
                 rotate([0,0,0]) translate([wall_thickness_x + move_tolerance,
                 -(arrow_block_depth+overlap_cube_depth),-arrow_block_height()/2-wall_thickness_z+wall_thickness_z])
                 direction_management_lever(); // translate y = -body_depth/2 + wall_thickness_y+3*move_tolerance
                 if (locker == true) {
                    translate([body_width/2,-(body_depth-wall_thickness_y)/2,locker_height()-0.5-z_pos_axis])
                    rotate([180,0,90]) locking_pin();
                 }
             }
             if(state== "-yz"){
                 translate([0,-overlap_cube_depth*(2/3),-(overlap_cube_depth)/4]) 
                 rotate([-45,0,0])
                 translate([wall_thickness_x + move_tolerance,
                 -arrow_block_depth,-arrow_block_height()/2-wall_thickness_z+wall_thickness_z]) direction_management_lever();
             }
             if(state == "z"){
                 down(overlap_cube_depth/2) rotate([-90,0,0]) translate([wall_thickness_x + move_tolerance,
                 -arrow_block_depth,-arrow_block_height()/2-wall_thickness_z+wall_thickness_z]) direction_management_lever();
             }

            if(state== "yz"){
                 translate([0,overlap_cube_depth*(2/3),-(overlap_cube_depth)/4]) 
                 rotate([-135,0,0])
                 translate([wall_thickness_x + move_tolerance,
                 -arrow_block_depth,-arrow_block_height()/2-wall_thickness_z+wall_thickness_z]) direction_management_lever();
            }
             if(state== "y"){
                 rotate([-180,0,0]) translate([wall_thickness_x + move_tolerance, -body_depth/2 +
                 wall_thickness_y+3*move_tolerance,-arrow_block_height()/2-wall_thickness_z+wall_thickness_z])
                 direction_management_lever(); 
                 if (locker == true) {
                    translate([body_width/2,(body_depth-wall_thickness_y)/2,locker_height()-0.5-z_pos_axis])
                    rotate([180,0,90]) locking_pin();
                 }
             }
         }
         //cut -> THIS would need a difference function
        //translate([15,-50,-25])
        //cube([50,100,50]);
    }



/*  module visualize_onePiece_with_locker(){
     direction_management_onePiece();
     translate([body_width*(1/2),body_depth*(1/6),locker_height()-0.5+wall_thickness_z]) rotate([180,0,90])
     locking_pin();
 } */


 direction_management("y");

/*  */
