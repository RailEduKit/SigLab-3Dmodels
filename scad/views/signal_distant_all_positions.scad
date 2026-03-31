/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: signal_distant_all_positions
 */

// Include external libraries (has to be included, bacuase use files need the library)
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// use common parts
include <../parts/signal_box.scad>
use <signal_distant.scad>

right(body_width+5) zrot(180) //position for the creation of picture
signal_distant("APPROACH");

left(5) zrot(180) //position for the creation of picture
signal_distant("CLEAR");