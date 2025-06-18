/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: component/signal_lever
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>


module signal_lever(top_color = ASPECT_CLEAR, bottom_color = ASPECT_STOP) {
	module handle() {
		union() {
			intersection() {
				translate([ 0, handle_depth, (block_height - handle_height) / 2 ])
				color(BASE_COLOR) cube([ block_width, handle_depth, handle_height ]);
				translate([ 0, block_depth, block_height / 2 ])
				color(BASE_COLOR) scale([ 1, 0.5, 1 ]) rotate([ 0, 90, 0 ])
				cylinder(h = block_width, r = block_height / 2);
			}
			translate([ 0, -handle_depth, (block_height - handle_height) / 2 ])
			color(BASE_COLOR) cube([ block_width, handle_depth + block_depth, handle_height ]);
		}
	}
	module rotation_axis() {
		translate([ 0, block_depth, block_height / 2 ])
		rotate([ 0, 90, 0 ])
		cylinder(h = block_width, d = axis_diameter + move_tolerance);
	}
	module signal_aspect(color_aspect) {
		difference() {
			union() {
				color(color_aspect) cube([ block_width, block_depth, block_height / 2 ]);

				translate([ 0, block_depth, block_height / 2 ])
				scale([ 1, 0.5, 1 ]) rotate([ 0, 90, 0 ])
				color(color_aspect) cylinder(h = block_width, r = block_height / 2);
			}
			translate([ -1, 0, block_height / 2 - handle_height / 2 ])
			color(color_aspect) cube([ block_width + 2, block_depth + block_width, block_height / 2 + handle_height ]);
			// color border line
			// translate([0,0,(block_height-handle_height)/2-fine_line]) color(BASE_COLOR) cube([fine_line, 2*block_depth,
			// fine_line]); translate([0,0,(block_height+handle_height)/2]) color(BASE_COLOR) cube([fine_line,
			// 2*block_depth, fine_line]);
		}
	}

	difference() {
		union() {
			translate([ block_width, 0, block_height ])
			rotate([ 0, 180, 0 ])
			signal_aspect(top_color);
			signal_aspect(bottom_color);
			handle();
		}
		rotation_axis();
	}
}

module lever_space_cubes() {
	translate([ wall_thickness_x, 0, z_pos_axis - (handle_height) / 2 - move_tolerance ])
	cube([
		body_width - 2 * wall_thickness_x, wall_thickness_y,
		body_height
	]); // z=wall_thickness_z+(arrow_block_height-handle_height)/2
	translate([ wall_thickness_x, body_depth - wall_thickness_y, z_pos_axis - (handle_height) / 2 - move_tolerance ])
	cube([ body_width - 2 * wall_thickness_x, wall_thickness_y, body_height ]);
}
