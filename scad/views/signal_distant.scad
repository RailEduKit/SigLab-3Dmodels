/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_distant
 */

// Include external libraries (has to be included, bacuase use files need the library)
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// use common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
use <../assemblies/signal_box_distant.scad>
use <../assemblies/signal_lever_distant.scad>

module signal_distant(aspect) {
	translate([ 0, -body_depth / 2, -z_pos_axis ])
	signal_box_distant(); // z=-block_height/2-wall_thickness_z
	if (aspect == "CLEAR") {
		rotate([ 0, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_distant();
	}
	if (aspect == "APPROACH") {
		rotate([ -180, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_distant();
	}
}

right(body_width) zrot(180) //position for the creation of picture
signal_distant("APPROACH");
