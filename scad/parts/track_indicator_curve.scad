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
include <track_indicator_straight.scad> // access variables

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git



// ric = route indicator curve
ric_inner_radius = curve_inner_radius + (rail_width-ris_width)/2 - move_tolerance/2;
//echo(str("ric_inner_radius = ", ric_inner_radius));

module track_indicator_curve() {
        difference(){
            union(){
                rotate_extrude(angle=curve_angle)
                right(ric_inner_radius) rect([ris_width, om_thickness], rounding = ris_rounding*[1,1,0,0], anchor = LEFT+FRONT)
                xflip_copy() position(FRONT + LEFT) rect([om_track_guidance_width,om_track_guidance_height], anchor = BACK+LEFT);
                right(ric_inner_radius+ris_width/2) up(om_thickness/2) xrot(90)
                symmetrical_connector("male");
                zrot(curve_angle) right(ric_inner_radius+ris_width/2) up(om_thickness/2) zrot(180) xrot(90) 
                symmetrical_connector("male");

            }
            right(ric_inner_radius+ris_width/2) up(om_thickness/2) xrot(90)
            symmetrical_connector("female");
            zrot(curve_angle) right(ric_inner_radius+ris_width/2) up(om_thickness/2) zrot(180) xrot(90)
            symmetrical_connector("female"); // Dont't worry, after rendering, the track guidance shouldn't overlap with the connector! Otherwise change the slope.
        }
    }

//indicator();
/* right(curve_outer_radius) zrot(180-curve_angle) //position for the creation of picture
track_indicator_curve(); */