/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: train_integrity_rear
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// use common parts
include <../parts/train_integrity_body.scad>
use <../assemblies/train_integrity_body_rear.scad>
use <../assemblies/train_integrity_symbol_rear.scad>

/* PRINT INSTRUCTION
To print the train integrity you have to export the symbol and the body seperately as STL.
Then you have to select the body STL and the symbol STL and load them TOGETHER at the same time in Bambu Studio.
Thus the two files are positioned at the same place and the symbol fills the holes in the body perfectly.
Then you can select the two parts seperately to color them.
Through this procedure you can print multiple colors in one layer.
 */

module train_integrity_rear(){
    difference(){
        train_integrity_body_rear();
        // create space for white triangles
        translate([ -shield_width / 2, -(shield_depth) / 2 - coupling_radius + 1, -shield_thickness ])
        cube([ shield_width, shield_depth, symbol_height ]);
    }
    difference(){
        // create white triangles
        color(INDICATOR_COLOR)
        translate([ -shield_width / 2, -(shield_depth) / 2 - coupling_radius + 1, -shield_thickness ])
        cube([ shield_width, shield_depth, symbol_height ]);
        train_integrity_symbol_rear();
    }
    train_integrity_symbol_rear();
}

yrot(180)
train_integrity_rear();