/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: clearing_point_block
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// Include common parts
include <../parts/clearing_point_body.scad>
include <../parts/clearing_point_symbols.scad>
include <../parts/driving_direction_arrow.scad>

module clearing_point_block() {
    clearing_point_body();
    translate([ zs_width / 2, zs_depth / 2, zs_height ])
    block_clearing_symbol();
    translate([ zs_width * (4 / 5), (zs_depth - attach_arrow_depth) / 2, zs_height ])
	rotate([ 0, 0, 90 ])
	driving_direction_arrow();
}


right(zs_depth) zrot(90) //position for the creation of picture
clearing_point_block();