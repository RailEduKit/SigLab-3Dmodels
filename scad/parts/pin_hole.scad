/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: component/pin_hole
 */

use <../assemblies/position_indicator_plate.scad>

module pin_hole() {
	cylinder(h = rail_height, d = np_pin_diameter() + move_tolerance);
}
