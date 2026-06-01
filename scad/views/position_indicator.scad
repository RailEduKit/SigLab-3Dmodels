/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: position_indicator
 */
// Include external libraries
include <BOSL2/std.scad>

include <../config/global_variables.scad>
include <../config/colors.scad>

// use common parts
use <../assemblies/position_indicator_number.scad>
use <../assemblies/position_indicator_plate.scad>

position_indicator_number();
position_indicator_plate();