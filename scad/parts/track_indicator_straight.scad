/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: track indicator straight
 */

// Include configuration file
include <../config/global_variables.scad>

// Include common parts
use <symmetrical_connector.scad>

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git

// The space between track and train is about 3mm height.

// overlap measure -> om
om_thickness = 2;
// track guidance
om_track_guidance_width = 0.8;
om_track_guidance_height = 2.5;


// ris = route indicator straight
ris_width = rail_well_spacing + 2 * om_track_guidance_width + move_tolerance;
ris_length = straight_length;
ris_rounding = om_track_guidance_width; //om_thickness/2 doesn't work at the track guidance


module track_indicator_straight() {
    diff()
        cuboid([ris_width, ris_length, om_thickness], rounding = ris_rounding, edges = [TOP+LEFT, TOP+RIGHT, FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]){
            //guidance
            xflip_copy() position(BOTTOM+LEFT+FRONT) cuboid([om_track_guidance_width, ris_length, om_track_guidance_height], anchor= LEFT+TOP+FRONT, rounding= ris_rounding, edges = [LEFT+FRONT, LEFT+BACK]);
            // dovetail
            zrot_copies(n=2) attach(FRONT) symmetrical_connector();
        }
}

/* back(straight_length/2) //position for the creation of picture
track_indicator_straight(); */