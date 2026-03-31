/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: train_integrity_symbol_rear
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// include common parts
include <../parts/train_integrity_body.scad> // access variables

/* PRINT INSTRUCTION
To print the train integrity you have to export the symbol and the body seperately as STL.
Then you have to select the body STL and the symbol STL and load them TOGETHER at the same time in Bambu Studio.
Thus the two files are positioned at the same place and the symbol fills the holes in the body perfectly.
Then you can select the two parts seperately to color them.
Through this procedure you can print multiple colors in one layer.
 */


module triangle() {
	cylinder_diameter = 0.1;
	hull() {
		translate([ cylinder_diameter / 2, cylinder_diameter / 2, 0 ])
		cylinder(d = cylinder_diameter, h = symbol_height);
		translate([ cylinder_diameter / 2, shield_depth - cylinder_diameter / 2, 0 ])
		cylinder(d = cylinder_diameter, h = symbol_height);
		translate([ (shield_width - cylinder_diameter) / 2, (shield_depth - cylinder_diameter) / 2, 0 ])
		cylinder(d = cylinder_diameter, h = symbol_height);
	}
}

module train_integrity_symbol_rear() {
	color(ASPECT_STOP) union(){
		translate([ -shield_width / 2, -(shield_depth) / 2 - coupling_radius + 1, -shield_thickness ])
		triangle();
		translate([ shield_width / 2, -(shield_depth) / 2 - coupling_radius + 1, -shield_thickness + symbol_height ])
		rotate([ 0, 180, 0 ])
		triangle();
	}
	
}

train_integrity_symbol_rear();