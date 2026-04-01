/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: overlap_body_straight
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git


// Include common parts
include <../parts/track_indicator_straight.scad>
use <overlap_pattern_straight.scad>

module overlap_body_straight(){
    difference(){
        color(ROUTE_COLOR) back(straight_length/2) track_indicator_straight();
        overlap_pattern_straight();
    }
    
}
overlap_body_straight();