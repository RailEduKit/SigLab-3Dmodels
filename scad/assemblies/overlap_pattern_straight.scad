/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: overlap_pattern_straight
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git


// Include common parts
include <../parts/track_indicator_straight.scad>
include <../parts/overlap_bar.scad>

module negative_track_indicator(){
    difference(){
        cuboid([2*ris_width, straight_length + 3*bar_depth, om_thickness]);
        diff()
            cuboid([ris_width- 2*bar_frame, ris_length, om_thickness]){
            attach(FRONT) symmetrical_connector("male");
            attach(FRONT) symmetrical_connector("female");
            attach(BACK) symmetrical_connector("male");
            //attach(BACK) symmetrical_connector("male", frame = - 2*bar_frame);
            attach(BACK) symmetrical_connector("female");
        }


        //track_indicator_straight();
    }
}

module overlap_pattern_straight(){
    module bar_setup(){
        x = round(straight_length / sqrt(2*pow(bar_width,2)));
        for(i = [-6:2:x]){
        left(ris_width/2 - bar_frame) back(i*sqrt(2*pow(bar_width,2)) + bar_frame) bar_for_curve(); 
        }
    }
    up(om_thickness/2 + 0.011) difference(){ // +0.011 to see it at the surface of the track indicator straigth
        bar_setup();
        back(straight_length/2) negative_track_indicator();
    }

    
}

//negative_track_indicator();
//track_indicator_straight();
overlap_pattern_straight();

