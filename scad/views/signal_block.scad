/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_block
 */

// Include external libraries (has to be included, bacuase use files need the library)
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include other parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
use <../assemblies/locking_pin.scad> 
use <../assemblies/signal_box_block.scad>
use <../assemblies/signal_lever_block.scad>




module signal_block(aspect, locker = false) {
	translate([ 0, -body_depth / 2, -z_pos_axis ])
	signal_box_block(); // z=-block_height/2-wall_thickness_z
	if (aspect == "CLEAR") {
		rotate([ 0, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_block();
		if (locker == true) {
			echo(str("The aspect CLEAR can not be locked "));
		}
	}
	if (aspect == "STOP") {
		rotate([ -180, 0, 0 ])
		translate([
			wall_thickness_x + move_tolerance, -body_depth / 2 + wall_thickness_y + 3 * move_tolerance,
			-block_height / 2 - wall_thickness_z +
			wall_thickness_z
		])
		signal_lever_block();
		if (locker == true) {
			translate([ body_width / 2, (body_depth - wall_thickness_y) / 2, locker_height - 0.5 - z_pos_axis ])
			rotate([ 180, 0, 90 ])
			locking_pin();
		}
	}
}

right(body_width) zrot(180) //position for the creation of picture
signal_block("STOP");
