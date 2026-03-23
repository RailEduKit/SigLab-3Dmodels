/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: direction_management_lever
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// include common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>

function arrow_block_height() = 9-engraving_height;
function overlap_cube_depth() = arrow_block_height()/2;
function arrow_block_depth() = block_depth - overlap_cube_depth();


arrowline_length = 6.5;

module onedirect_arrow() {
	color(INDICATOR_COLOR) union(){
		translate([ -arrowline_length, -3 / 2, 0 ])
		cube([ arrowline_length, 3, engraving_height ]);
		translate([ arrowline_length * (3 / 8), 0, 0 ])
		scale([ 3 / 4, (arrowline_length / (2 * arrowline_length * sin(120))), 1 ])
		cylinder(engraving_height, arrowline_length, arrowline_length, $fn = 3);
	}
	
}


module direction_management_lever() {
	color(BASE_COLOR)
	difference() {
		union() {
			// I axis
			cube([ block_width, block_depth, arrow_block_height() ]);
			translate([ 0, block_depth, 0 ])
			cube([ block_width, overlap_cube_depth(), arrow_block_height() ]);

			// handle
			translate([ 0, -handle_depth, (arrow_block_height() - handle_height) / 2 ])
			cube([ block_width, handle_depth, handle_height ]);
		}
		// axis
		translate([ 0, block_depth, arrow_block_height() / 2 ])
		rotate([ 0, 90, 0 ])
		cylinder(h = block_width, d = axis_diameter);
		// locker pin hole
		translate([ block_width / 2, -wall_thickness_y / 2 - 3 * move_tolerance, 0 ])
		cylinder(h = locker_height, d = locker_width + 2 * move_tolerance);
	}
	// arrows
	translate([ block_width / 2, block_depth / 2 + (locker_width) / 2 - 4.5, arrow_block_height() ])
	rotate([ 0, 0, -90 ])
	onedirect_arrow();
	translate([ block_width / 2, block_depth / 2 + (locker_width) / 2 - 4.5, -engraving_height ])
	rotate([ 0, 0, -90 ])
	onedirect_arrow();
}

direction_management_lever();