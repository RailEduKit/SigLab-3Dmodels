/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: Balise
 */

// Include configuration file
include <../config/global_variables.scad>

module balise() {
	translate([ 0, 0, balise_height / 2 ])
	cube([ balise_width, balise_depth, balise_height ], center = true);
	translate([ 0, 0, balise_height ])
	cylinder(d = balise_pin_diameter, h = balise_pin_height);
}

balise();
