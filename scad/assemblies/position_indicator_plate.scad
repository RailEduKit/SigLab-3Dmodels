/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: position_indicator_plate
 */



// Include external libraries
include <BOSL2/std.scad>

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// use common parts
include <../parts/track_indicator_straight.scad>
use <position_indicator_number.scad>


// number_plate = np
np_diameter = ris_width;
function np_height() = 1;
function number_height() = 0.6;

// om_pin variables are defined in track_indicator flexible   
function np_pin_diameter() = 4.5;
function np_pin_height() = 5;

frame_width = 180;
frame_depth = 180;
function step_size() = np_diameter+4*move_tolerance;
function x_start() = -(frame_width/2-np_diameter/2-1);
function y_start() = -(frame_depth/2-np_diameter/2-1);



module frame() {
	difference() {
		cube([ frame_width, frame_depth, 2 ], center = true);
		cube([ frame_width - 1, frame_depth - 1, 3 ], center = true);
	}
}

module number_plate(number) {
	color(BASE_COLOR) union(){
		difference() {
			down(om_thickness/2)track_indicator_straight(length = ris_width, connector = false);
			piece_number(number);
		}
		//translate([ 0, 0, np_height() ])
		//cylinder(h = np_pin_height(), d = np_pin_diameter());
	}

}

module position_indicator_plate() {
	
	/* counter = 0;
	for(x = [-(frame_width/2-np_diameter/2-1): np_diameter+2*move_tolerance: (frame_width/2-np_diameter/2-1)]){
	    for(y= [-(frame_depth/2-np_diameter/2-1): np_diameter+2*move_tolerance: (frame_depth/2-np_diameter/2-1)]){
	        translate([x,y,0])number_plate(counter);
	        counter = counter + 1;
	    }
	} */
	// generated with number_plates_creation.jl
	// still slow with rendering.
	translate([x_start()+0*step_size(),y_start()+0.0*step_size(),0])number_plate(0);
	translate([x_start()+0*step_size(),y_start()+1.0*step_size(),0])number_plate(5);
	translate([x_start()+0*step_size(),y_start()+2.0*step_size(),0])number_plate(10);
	translate([x_start()+1*step_size(),y_start()+0.0*step_size(),0])number_plate(15);
	translate([x_start()+1*step_size(),y_start()+1.0*step_size(),0])number_plate(20);
	translate([x_start()+1*step_size(),y_start()+2.0*step_size(),0])number_plate(25);
	translate([x_start()+2*step_size(),y_start()+0.0*step_size(),0])number_plate(30);
	translate([x_start()+2*step_size(),y_start()+1.0*step_size(),0])number_plate(35);
	translate([x_start()+2*step_size(),y_start()+2.0*step_size(),0])number_plate(40);
	translate([x_start()+3*step_size(),y_start()+0.0*step_size(),0])number_plate(45);
	translate([x_start()+3*step_size(),y_start()+1.0*step_size(),0])number_plate(50);
	translate([x_start()+3*step_size(),y_start()+2.0*step_size(),0])number_plate(55);
}

//number_plate(5);
position_indicator_plate();