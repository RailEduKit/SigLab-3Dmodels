/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: component/signal_box
 */


// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// include common components
include <magnet_hole.scad>

block_width = 20; //material constraint //body_width-2*wall_thickness_x-move_tolerance;

// body specifications
axis_diameter = 2; //maybe use the same material as lever anchor
wall_thickness_x = (body_width-block_width)/2-move_tolerance;//5;
wall_thickness_y = lever_thickness_switch;
wall_thickness_z = 2;
z_pos_axis = 10; // the block_height=13.5 lies a bit heigher, previous: block_height/2+wall_thickness_z




module signal_box() {
	module box() {
		difference() {
			cube([ body_width, body_depth, body_height ]);
		}
	}
	module round_edge() {
		cylinder(h = body_height, r = track_arc_inner_radius);
	}
	color(BASE_COLOR) difference() {
		intersection() {
			intersection() {
				translate([ 0, 0, 0 ])
				box();
				translate([ track_arc_inner_radius - sagitta, body_depth / 2, 0 ])
				round_edge();
			}
			intersection() {
				translate([ 0, 0, 0 ])
				box();
				translate([ body_width - track_arc_inner_radius + sagitta, body_depth / 2, 0 ])
				round_edge();
			}
		}
		// magnet holes
		translate([ 0, body_depth / 2 - magnet_distance_to_middle, magnet_z ])
		rotate([ 0, 90, 0 ])
		magnet_hole();
		translate([ 0, body_depth / 2 + magnet_distance_to_middle, magnet_z ])
		rotate([ 0, 90, 0 ])
		magnet_hole();
		translate([ body_width - magnet_thickness - 0.5, body_depth / 2 - magnet_distance_to_middle, magnet_z ])
		rotate([ 0, 90, 0 ])
		magnet_hole();
		translate([ body_width - magnet_thickness - 0.5, body_depth / 2 + magnet_distance_to_middle, magnet_z ])
		rotate([ 0, 90, 0 ])
		magnet_hole();
	}
}

module cavity_cube_signal_box() {
	translate([ wall_thickness_x, wall_thickness_y, wall_thickness_z ])
	cube([ body_width - 2 * wall_thickness_x, body_depth - 2 * wall_thickness_y, body_height - wall_thickness_z ]);
}

//signal_box();