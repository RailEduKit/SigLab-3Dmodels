/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_box_block
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
include <../parts/driving_direction_arrow.scad>
use <locking_pin.scad>

module signal_box_block() {
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
		// locker pin hole
		difference() {
			translate([ body_width / 2, body_depth - wall_thickness_y / 2, 0 ])
			cylinder(h = locker_height(), d = locker_width() + 2 * move_tolerance);
			translate([ wall_thickness_x + move_tolerance, body_depth - wall_thickness_y, 0 ])
			cube([ block_width, locker_width(), locker_height() ]);
		}
	}
	translate([ body_width - wall_thickness_x + attach_arrow_wall_distance, body_depth / 2, body_height ])
	driving_direction_arrow();
	translate([ attach_arrow_wall_distance, body_depth / 2, body_height ])
	driving_direction_arrow();
	// lock block
	lock_block_width = 6;
	lock_block_depth = 2;
	lock_block_height = z_pos_axis - handle_height / 2 - move_tolerance + handle_height;
	color(BASE_COLOR)
	translate([ (body_width - lock_block_width) / 2, wall_thickness_y, 0 ])
	cube([ lock_block_width, lock_block_depth, lock_block_height ]);
}

back(body_depth) right(body_width) zrot(180) //position for the creation of picture
signal_box_block();