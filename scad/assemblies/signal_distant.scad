/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_distant
 */

// Include configuration file
include <../config/global_variables.scad>

// include common components
include <components/signal_box.scad>
include <components/signal_lever.scad>
include <components/driving_direction_arrow.scad>

// symbol_distant();
module symbol_distant() {
	// symbol_distant = sb
	cylinder_diameter = 0.4;
	sb_beta = atan(1 / 2);
	sb_gamma = 180 - 90 - sb_beta;
	sb_theta = 90 - sb_gamma;
	top_cyl_ydif = engraving_thickness / sin(sb_beta);
	bottom_cyl_xdif = engraving_thickness / sin(sb_gamma) + tan(sb_theta) * engraving_thickness;

	difference() {
		hull() {
			translate([ signal_symbol_size / 2, cylinder_diameter / 2, 0 ])
			cylinder(d = cylinder_diameter, h = engraving_height);
			translate([ cylinder_diameter / 2, signal_symbol_size - cylinder_diameter / 2, 0 ])
			cylinder(d = cylinder_diameter, h = engraving_height);
			translate([ signal_symbol_size - cylinder_diameter / 2, signal_symbol_size - cylinder_diameter / 2, 0 ])
			cylinder(d = cylinder_diameter, h = engraving_height);
		}
		hull() {
			translate([ signal_symbol_size / 2, top_cyl_ydif + cylinder_diameter / 2, 0 ])
			cylinder(d = cylinder_diameter, h = engraving_height);
			translate([
				bottom_cyl_xdif + cylinder_diameter / 2,
				signal_symbol_size - engraving_thickness - cylinder_diameter / 2, 0
			])
			cylinder(d = cylinder_diameter, h = engraving_height);
			translate([
				signal_symbol_size - bottom_cyl_xdif - cylinder_diameter / 2,
				signal_symbol_size - engraving_thickness - cylinder_diameter / 2, 0
			])
			cylinder(d = cylinder_diameter, h = engraving_height);
		}
	}
}

module body() {
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

// signal_lever(("distant"));
module signal_lever_distant() {
	// difference(){
	signal_lever(bottom_color = ASPECT_APPROACH);
	// symbol
	translate([
		signal_symbol_size + signal_symbol_side_space, signal_symbol_size + 4 * (block_depth - signal_symbol_size) / 5,
		0
	])
	rotate([ 0, 0, 180 ])
	symbol_distant();
	translate([ signal_symbol_side_space, 4 * (block_depth - signal_symbol_size) / 5, block_height - engraving_height ])
	symbol_distant();
	// }
}

module visualize_colorBlock_in_body(state) {
	translate([ 0, -body_depth / 2, -z_pos_axis ])
	body(); // z=-block_height/2-wall_thickness_z
	if (state == "-y") {
		rotate([ 0, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_distant();
	}
	if (state == "y") {
		rotate([ -180, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_distant();
	}
}

// body();
// translate([-30,handle_depth,0]) signal_lever_distant();
visualize_colorBlock_in_body("y");
