/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_box_distant
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
include <../parts/driving_direction_arrow.scad>

module signal_box_distant() {
	color(BASE_COLOR)
	difference() {
		signal_box(); // import from basis_component-roundedBox
		cavity_cube_signal_box();
		// axis
		translate([ 0, body_depth / 2, z_pos_axis ])
		rotate([ 0, 90, 0 ])
		cylinder(h = body_width, d = axis_diameter);
		// handle space
		lever_space_cubes();
	}
	translate([ body_width - wall_thickness_x + attach_arrow_wall_distance, body_depth / 2, body_height ])
	driving_direction_arrow();
	translate([ attach_arrow_wall_distance, body_depth / 2, body_height ])
	driving_direction_arrow();
}

back(body_depth) right(body_width) zrot(180) //position for the creation of picture
signal_box_distant();