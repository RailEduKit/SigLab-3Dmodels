/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_lever_distant
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
include <../parts/signal_symbols.scad>

module signal_lever_distant() {
	difference(){
		signal_lever(bottom_color = ASPECT_APPROACH);
		// symbol
		color(ASPECT_APPROACH)
		translate([
			signal_symbol_size + signal_symbol_side_space, signal_symbol_size + 4 * (block_depth - signal_symbol_size) / 5,
			0
		])
		rotate([ 0, 0, 180 ])
		symbol_distant();
		color(ASPECT_CLEAR)
		translate([ signal_symbol_side_space, 4 * (block_depth - signal_symbol_size) / 5, block_height - engraving_height ])
		symbol_distant();
	}
}

right(block_width) up(block_height) yrot(180) //position for the creation of picture
signal_lever_distant();