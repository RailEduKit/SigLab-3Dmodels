/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_route
 */

// Include external libraries (has to be included, bacuase use files need the library)
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// use common components
include <../parts/signal_box.scad>
use <../assemblies/locking_pin.scad>
use <../assemblies/checkbox_route.scad>
use <../views/signal_block.scad>



module route_signal(aspect) {
	signal_block(aspect);
	rotate([0,0,180])
	translate([ 0, -body_depth / 2, -z_pos_axis ])
	checkbox_route();
	if (aspect == "CLEAR"){
		rotate([0,0,180])
		translate([ 0, -body_depth / 2, -z_pos_axis ])
		for (y = [ body_depth * (1 / 6), body_depth / 2, body_depth * (5 / 6) ]) {
			translate([ body_width * (1 / 3), y, locker_height])
			rotate([ 180, 0, 90 ])
			locking_pin();
		}
	}
}

zrot(180) //position for the creation of picture
route_signal("STOP"); // CLEAR or STOP
