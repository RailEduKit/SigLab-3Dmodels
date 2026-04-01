/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: symmetrical_connector
 */

// Include configuration file
include <../config/global_variables.scad>



// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git

// Include common parts
include <track_indicator_straight.scad> // access variables

// overlap measure -> om
function om_dovetail_width() = rail_well_spacing/2-2.5;
function om_dovetail_depth() = 5;
function om_dovetail_angle() = 23;

module male_connector(){
    right(ris_width*(1/4)) dovetail("male",  w = om_dovetail_width(), h = om_dovetail_depth(), slide = om_thickness, radius = om_dovetail_depth()/7,round = true, angle = om_dovetail_angle());
}

module female_connector(){
    // the slop has to be smaller than 0.65. If its higher you get a problem in the track_indicator_curve. The track guidance would be in the way of the connector.
    // If the slope is smaller than 0.3 the connecting is a bit rough.
    left(ris_width*(1/4)) tag("remove") dovetail("female", w = om_dovetail_width(), h = om_dovetail_depth(), slide = om_thickness, radius = om_dovetail_depth()/7, round = true, $slop = 0.55, angle=om_dovetail_angle());
}

module symmetrical_connector(part = "both"){
    if (part == "both") {
        male_connector();
        female_connector();
    }
    if (part == "male") {
        male_connector();
    }
    if (part == "female") {
        female_connector();
    }
}

/* symmetrical_connector();
symmetrical_connector("male");
symmetrical_connector("female");
 */