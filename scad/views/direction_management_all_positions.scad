/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: direction_management_different_positions
 */

// include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common parts
include <../parts/signal_box.scad>
use <direction_management.scad>

right(0.5*body_width+1*10) direction_management("-y");
//right(0.5*body_width+10) direction_management("-yz");
left(0.5*body_width) direction_management("z");
//left(1.5*body_width+10) direction_management("yz");
left(1.5*body_width+1*10) direction_management("y");