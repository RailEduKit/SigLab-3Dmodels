/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: component/signal_box
 */

// include common components
include <../components/magnet_hole.scad>

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

module space_locking_pin() {
	translate([
		0, body_depth / 2 - magnet_distance_to_middle - magnet_diameter - 2 * move_tolerance - lock_lever_depth,
		body_height -
		lock_lever_height
	])
	cube([ wall_thickness_x - lock_lever_thickness, lock_lever_depth + move_tolerance, lock_lever_height ]);
}
