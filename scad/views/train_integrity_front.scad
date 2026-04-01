/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: train_integrity_front
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// use common parts
use <../assemblies/train_integrity_body_front.scad>
use <../assemblies/train_integrity_symbol_front.scad>

/* PRINT INSTRUCTION
To print the train integrity you have to export the symbol and the body seperately as STL.
Then you have to select the body STL and the symbol STL and load them TOGETHER at the same time in Bambu Studio.
Thus the two files are positioned at the same place and the symbol fills the holes in the body perfectly.
Then you can select the two parts seperately to color them.
Through this procedure you can print multiple colors in one layer.
 */

module train_integrity_front(){
    train_integrity_body_front();
    train_integrity_symbol_front();
}


yrot(180)
train_integrity_front();