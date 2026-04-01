/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: overlap_curve
 */

 // Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git

// use common parts
use <../assemblies/overlap_body_curve.scad>
use <../assemblies/overlap_pattern_curve.scad>

module overlap_curve(){
    overlap_pattern_curve_rot();
    overlap_body_curve_rot();
}

right(curve_outer_radius) zrot(180-curve_angle) //position for the creation of picture
overlap_curve();

