/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_lever_block
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
include <../parts/signal_lever.scad>
include <../parts/signal_symbols.scad>
use <locking_pin.scad>

module signal_lever_block() {
	difference() {
		signal_lever();
		// locker pin hole
		color(ASPECT_STOP)
		translate([ block_width / 2, -wall_thickness_y / 2 - 3 * move_tolerance, 0 ])
		cylinder(h = (block_height- handle_height)/2, d = locker_width() + 2 * move_tolerance);
		color(BASE_COLOR)
		translate([ block_width / 2, -wall_thickness_y / 2 - 3 * move_tolerance, (block_height- handle_height)/2 ])
		cylinder(h = handle_height, d = locker_width() + 2 * move_tolerance);
		color(ASPECT_CLEAR)
		translate([ block_width / 2, -wall_thickness_y / 2 - 3 * move_tolerance, (block_height + handle_height)/2 ])
		cylinder(h = block_height, d = locker_width() + 2 * move_tolerance);

	
		// symbol
		color(ASPECT_STOP)
		translate([ signal_symbol_side_space, 4 * (block_depth - signal_symbol_size) / 5, 0 ])
		symbol_block();
		color(ASPECT_CLEAR)
		translate([ signal_symbol_side_space, 4 * (block_depth - signal_symbol_size) / 5, block_height - engraving_height ])
		symbol_block();
	}
}

right(block_width) up(block_height) yrot(180) //position for the creation of picture
signal_lever_block();