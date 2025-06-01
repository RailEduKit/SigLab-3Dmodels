/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: magnet_rod
 */

include <../config/global_variables.scad>

magnet_rod();

module magnet_hole() {
	cylinder(h = magnet_thickness, d = magnet_diameter);
}

module color_line() {
	difference() {
		cylinder(d = mr_diameter, h = fine_line);
		cylinder(d = mr_diameter - fine_line, h = fine_line);
	}
}

module magnet_rod() {
	difference() {
		scale([ 1, 1, 1 ]) cylinder(d = mr_diameter, h = mr_height);
		magnet_hole();
		translate([ 0, 0, mr_height - (magnet_thickness - move_tolerance) ])
		magnet_hole();
		// color border line
		scale([ 1, 0.5, 1 ]) translate([ 0, 0, 25 - fine_line ])
		color_line();
		scale([ 1, 0.5, 1 ]) translate([ 0, 0, mr_height - 25 ])
		color_line();
	}
}
