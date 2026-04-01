/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: polarity_indicator
 */

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>
include <../parts/clearing_point_body.scad>

// include common parts
include <../parts/signal_box.scad>

polarity_width = 5;
polarity_height = 5;

polarity_gap = 10;

module polarity_bars_straight(){
    color(ASPECT_STOP)
    translate([-polarity_gap-polarity_width,0,0])
    cube([polarity_width, straight_length, polarity_height]);
    color(ASPECT_STOP)
    translate([polarity_gap+rail_width,0,0])
    cube([polarity_width, straight_length, polarity_height]);
}

module polarity_bars_curve(){
    color(ASPECT_STOP)
    translate([curve_inner_radius + rail_width,0,0])
    rotate_extrude(angle = -curve_angle)
    translate([-(curve_inner_radius-polarity_gap),0,0]) square([polarity_width,polarity_height]);

    color(ASPECT_STOP)
    translate([curve_outer_radius,0,0])
    rotate_extrude(angle = -curve_angle)
    translate([-(curve_outer_radius+polarity_gap+polarity_width),0,0]) square([polarity_width,polarity_height]);
}

module polarity_bars_signal_box(){
    color(ASPECT_CLEAR)
    translate([body_width+polarity_width/2+polarity_gap,0,0])
    cube([polarity_width, body_depth, polarity_height], center = true);
    color(ASPECT_STOP)
    translate([-polarity_width/2-polarity_gap,0,0])
    cube([polarity_width, body_depth, polarity_height], center = true);
}

module polarity_bars_clearing_point(){
    color(ASPECT_STOP)
    translate([0, -polarity_gap-polarity_width,0])
    cube([zs_width, polarity_width, polarity_height]);

    color(ASPECT_CLEAR)
    translate([0, polarity_gap+zs_depth,0])
    cube([zs_width, polarity_width, polarity_height]);
}


polarity_bars_straight();
polarity_bars_signal_box();