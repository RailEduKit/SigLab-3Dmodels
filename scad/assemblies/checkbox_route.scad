/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: checkbox_route
 */

// Include external libraries
include <BOSL2/std.scad> // include is needed, because the locking_pin file uses the BOSL library

// Include configuration file
include <../config/global_variables.scad>

// include common components
include <../parts/signal_box.scad>
include <../parts/checkbox_symbols_route.scad>
use <locking_pin.scad>

rc_symbol_xpos = body_width - (body_width - (body_width*(1/3)+locker_width()/2))/2;



module checkbox_route() {
	difference() {
		signal_box(); // import from components/signal_box.scad
		for (y = [ body_depth * (1 / 6), body_depth / 2, body_depth * (5 / 6) ]) {
			color(BASE_COLOR)
			translate([ body_width * (1 / 3), y, wall_thickness_z ])
			cylinder(d = locker_width() + move_tolerance, h = body_height - wall_thickness_z);
		}
	}
	translate([ rc_symbol_xpos, body_depth * (1 / 6), body_height ])
	color(INDICATOR_COLOR) turnout_locking_symbol();
	translate([ rc_symbol_xpos, body_depth * (3 / 6), body_height ])
	color(INDICATOR_COLOR) flank_protection_symbol();
	translate([ rc_symbol_xpos, body_depth * (5 / 6), body_height ])
	color(INDICATOR_COLOR) overlap_symbol();
}

checkbox_route();