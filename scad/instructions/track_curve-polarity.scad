/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: track_curve_polarity
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// include common components
use <../jigs/track_curve.scad>
use <polarity_indicator.scad>

// include external libraries
include <trains/tracklib.scad>; // Import tracklib from dependency dotscad/trains.git

module track_curve_polarity(){
    curve_with_drill_holes();
    polarity_bars_curve();
}

track_curve_polarity();