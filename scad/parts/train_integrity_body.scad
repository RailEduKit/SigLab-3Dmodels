/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: train_integrity_body
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

thinnest_layer     = 0.2;

coupling_radius    = 13/2;
coupling_depth     = 8;
coupling_cut_pos   = coupling_radius*1/2;
boogie_width       = 20;
coupler_thickness  = 1.5;
lipp_height        = 4;
lipp_width         = coupler_thickness - move_tolerance;
shield_width       = 20;
shield_depth       = 25;
inlay_thickness    = 0.45;
shield_thickness   = 2; // the shield has to be at least 2mm thick. Otherwise the front symbol will be printed badly
inlay_radius       = 10.5/2;

symbol_height 	   = 0.6;

module train_integrity_body() {
	color(BASE_COLOR) union(){
	difference() { // coupling
		// outer ring
		cylinder(h = coupling_depth, r = coupling_radius + move_tolerance / 2 + coupler_thickness);
		// inner ring
		translate([ 0, 0, -coupler_thickness / 2 ])
		cylinder(h = coupling_depth + coupler_thickness, r = coupling_radius + move_tolerance / 2);
		// cutting the lower edge
		translate([ -coupling_radius * 1.3, coupling_cut_pos, -coupler_thickness / 2 ])
		cube([ coupling_radius * 2.6, coupling_radius * 1.2, coupling_depth + coupler_thickness ]);
	}

	union() { // upper board
		// beam
		translate([ -boogie_width / 2, -(coupling_radius + coupler_thickness + move_tolerance / 2), 0 ])
		cube([ boogie_width, coupler_thickness, coupling_depth ]);
		// lipp
		hull() {
			translate([
				-boogie_width / 2, -(coupling_radius + move_tolerance / 2 + coupler_thickness - lipp_width),
				coupling_depth
			])
			cube([ boogie_width, thinnest_layer, lipp_height / 4 ]);
			translate(
			    [ -boogie_width / 2, -(coupling_radius + move_tolerance / 2 + coupler_thickness), coupling_depth ])
			cube([ boogie_width, thinnest_layer, lipp_height ]);
		}
	}

	difference() { // front shield
		translate([ -shield_width / 2, -(shield_depth) / 2 - coupling_radius + 1, -shield_thickness ]) 
		cube([ shield_width, shield_depth, shield_thickness ]);
		translate([ 0, 0, -inlay_thickness ])
		cylinder(h = inlay_thickness, r = inlay_radius);
	}
	}
}

//train_integrity_body();