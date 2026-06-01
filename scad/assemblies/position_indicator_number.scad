/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: position_indicator_number
 */

// Include external libraries
include <BOSL2/std.scad>

include <../config/global_variables.scad>
include <../config/colors.scad>

use <position_indicator_plate.scad>


module frame() {
	difference() {
		cube([ frame_width, frame_depth, 2 ], center = true);
		cube([ frame_width - 1, frame_depth - 1, 3 ], center = true);
	}
}

module piece_number(number) {
	color(INDICATOR_COLOR) union(){
		translate([ 0, 0, -number_height() ])
		//rotate([ 180, 0, 0 ])
		linear_extrude(height = number_height()) text(str(number), 7.5, halign = "center", valign = "center");
	}
}

module position_indicator_number() {
	translate([x_start()+0*step_size(),y_start()+0.0*step_size(),0])piece_number(0);
	translate([x_start()+0*step_size(),y_start()+1.0*step_size(),0])piece_number(5);
	translate([x_start()+0*step_size(),y_start()+2.0*step_size(),0])piece_number(10);
	translate([x_start()+1*step_size(),y_start()+0.0*step_size(),0])piece_number(15);
	translate([x_start()+1*step_size(),y_start()+1.0*step_size(),0])piece_number(20);
	translate([x_start()+1*step_size(),y_start()+2.0*step_size(),0])piece_number(25);
	translate([x_start()+2*step_size(),y_start()+0.0*step_size(),0])piece_number(30);
	translate([x_start()+2*step_size(),y_start()+1.0*step_size(),0])piece_number(35);
	translate([x_start()+2*step_size(),y_start()+2.0*step_size(),0])piece_number(40);
	translate([x_start()+3*step_size(),y_start()+0.0*step_size(),0])piece_number(45);
	translate([x_start()+3*step_size(),y_start()+1.0*step_size(),0])piece_number(50);
	translate([x_start()+3*step_size(),y_start()+2.0*step_size(),0])piece_number(55);

}

position_indicator_number();
