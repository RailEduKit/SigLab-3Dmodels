/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: track_curve
 */



// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>

// include common parts
include <../parts/magnet_hole.scad>
include <../parts/pin_hole.scad>
use <track_straight.scad>

// Include external libraries
include <trains/tracklib.scad>; // Import tracklib from dependency dotscad/trains.git

// curve = c
// pin hole 1 = ph1
c_alpha = (s_ph1_ypos() * 360)/(2*PI*curve_middle_radius);
c_ph1_ypos = sin(c_alpha) * curve_middle_radius;
c_ph1_xpos = curve_outer_radius - cos(c_alpha) * curve_middle_radius;
// pin hole 2 = ph2
c_beta = curve_angle/2;
c_ph2_ypos = sin(c_beta) * curve_middle_radius;
c_ph2_xpos = curve_outer_radius - cos(c_beta) * curve_middle_radius;
// pin hole 3 = ph3
c_gamma = curve_angle - c_alpha;
c_ph3_ypos = sin(c_gamma) * curve_middle_radius;
c_ph3_xpos = curve_outer_radius - cos(c_gamma) * curve_middle_radius;

c_mh_zpos = rail_height/2;
// magnet hole 4 = mh1
c_mh4_xpos = 0.1;
c_mh4_ypos = 7.7;
c_mh4_zrot = -2;
// magnet hole 5 = mh1
c_mh5_xpos = 40.3;
c_mh5_ypos = 7.5;
c_mh5_zrot = -2.4;
// magnet hole 6 = mh1
c_mh6_xpos = 61;
c_mh6_ypos = 152;
c_mh6_zrot = -43.7;
// magnet hole 7 = mh1
c_mh7_xpos = 89.05;
c_mh7_ypos = 123.35;
c_mh7_zrot = -43.3;



/* [parameters] */

//// Connector to place on the base end of the piece.
// base = "female"; // [male,female]
//
//// Render a curve to the left with the requested connector, or none for no curve.
// left = "female"; // [male,female,none]
//
//// Render a straight center track with the requested connector, or none for no straight track.
// straight = "male"; // [male,female,none]
//
//// Render a curve to the left with the requested connector, or none for no curve.
// right = "female"; // [male,female,none]

// Length of the straight track, or auto to use the best fit for the requested curve radius.
straight_size = straight_length; // [auto:auto, 51:xsmall, 102:small, 152:medium, 203:large, 254:xlarge, 305:xxlarge]

// Curve radius.  Sizes provided are standard.
radius = curve_inner_radius; // [87.5:small, 180:large]

/* [Hidden] */

// Angle of track to render.  45 is standard.
angle = curve_angle; // [1:360]

// Wheel wells on both sides of the track?
double_sided_rails = true;

// Render the part
// render_track(base, left, straight, right, straight_size, radius, angle, double_sided_rails);

/* ******************************************************************************
 * Main module code below:
 * ****************************************************************************** */

/*
 * @param string base              Connector to place on the base end of the piece.
 * @param string left              Render a curve to the left with the requested connector, or none for no curve.
 * @param string straight          Render a straight center track with the requested connector, or none for no straight
 * track.
 * @param string right             Render a curve to the left with the requested connector, or none for no curve.
 * @param string|int straight_size Length of the straight track, or auto to use the best fit for the requested curve
 * radius.
 * @param float radius             Curve radius (usually 87.5 or 180)
 * @param float angle              Angle of track to render.  45 is standard
 * @param boolean double_sided_rails    True: Wheel Wells on both sides of the track
 */
module render_track(base, left, straight, right, double_sided_rails) {
	straight_length = (straight_size == "auto"
	                       ? ((left == "none" && right == "none") ? -1 // Wish we could throw an exception in OpenSCAD
	                                                              : ((radius == 87.5) ? 102 : 152))
	                       : straight_size);
	if (straight_length == -1) {
		echo("ERROR: When using straight_size==auto, you must render a right or left curve.");
	} else {
		translate([ -radius, 0, 0 ])
		difference() {
			union() {
				if (straight != "none") {
					translate([ radius + wood_width(), 0, 0 ])
					rotate([ 0, 0, 90 ])
					wood_track(straight_length, false);
					if (straight == "male") {
						translate([ radius + wood_width() / 2, straight_length, 0 ])
						rotate([ 0, 0, 90 ])
						wood_plug();
					}
				}
				if (left != "none") {
					wood_track_arc(radius, angle, false);
					if (left == "male") {
						rotate([ 0, 0, angle ])
						translate([ radius + wood_width() / 2, 0, 0 ])
						rotate([ 0, 0, 90 ])
						wood_plug();
					}
				}
				if (right != "none") {
					translate([ radius * 2 + wood_width(), 0, 0 ])
					rotate([ 0, 0, 180 - angle ])
					wood_track_arc(radius, angle, false);
					if (right == "male") {
						translate([ radius * 2 + wood_width(), 0, 0 ])
						rotate([ 0, 0, 180 - angle ])
						translate([ radius + wood_width() / 2, 0, 0 ])
						rotate([ 0, 0, -90 ])
						wood_plug();
					}
				}
				if (base == "male") {
					translate([ radius + wood_width() / 2, 0, 0 ])
					rotate([ 0, 0, -90 ])
					wood_plug();
				}
			}
			// Subtract any requested female connector regions
			if (straight == "female") {
				translate([ radius + wood_width() / 2, straight_length, 0 ])
				rotate([ 0, 0, -90 ])
				wood_cutout();
			}
			if (left == "female") {
				rotate([ 0, 0, angle ])
				translate([ radius + wood_width() / 2, 0, 0 ])
				rotate([ 0, 0, -90 ])
				wood_cutout();
			}
			if (right == "female") {
				translate([ radius * 2 + wood_width(), 0, 0 ])
				rotate([ 0, 0, 180 - angle ])
				translate([ radius + wood_width() / 2, 0, 0 ])
				rotate([ 0, 0, 90 ])
				wood_cutout();
			}
			if (base == "female") {
				translate([ radius + wood_width() / 2, 0, 0 ])
				rotate([ 0, 0, 90 ])
				wood_cutout();
			}
			// Now we can subtract the "rails"
			if (straight != "none") {
				translate([ radius + wood_width(), 0, 0 ])
				rotate([ 0, 0, 90 ])
				wood_rails(straight_length);
				if (double_sided_rails) {
					translate([ radius, 0, wood_height() ])
					rotate([ 180, 0, 90 ])
					wood_rails(straight_length);
				}
			}
			if (left != "none") {
				wood_rails_arc(radius, angle);
				if (double_sided_rails) {
					rotate([ 180, 0, angle ])
					translate([ 0, 0, -wood_height() ])
					wood_rails_arc(radius, angle);
				}
			}
			if (right != "none") {
				translate([ radius * 2 + wood_width(), 0, 0 ])
				rotate([ 0, 0, 180 - angle ])
				wood_rails_arc(radius, angle);
				if (double_sided_rails) {
					translate([ radius * 2 + wood_width(), 0, wood_height() ])
					rotate([ 180, 0, 180 ])
					wood_rails_arc(radius, angle);
				}
			}
		}
	}
}

module curve_shape_control() {
	linear_extrude(height = 1) projection() render_track("female", "none", "none", "male", false);
}

module curve_with_drill_holes() {
	color(SPRUCE_WOOD) difference() {
		render_track("female", "none", "none", "male", true);
		translate([ c_ph2_xpos, c_ph2_ypos, 0 ])
		pin_hole();
		translate([ c_mh4_xpos, c_mh4_ypos, c_mh_zpos ])
		rotate([ 0, 90, c_mh4_zrot ])
		magnet_hole();
		translate([ c_mh5_xpos, c_mh5_ypos, c_mh_zpos ])
		rotate([ 0, -90, c_mh5_zrot ])
		magnet_hole();
		translate([ c_mh6_xpos, c_mh6_ypos, c_mh_zpos ])
		rotate([ 0, 90, c_mh6_zrot ])
		magnet_hole();
		translate([ c_mh7_xpos, c_mh7_ypos, c_mh_zpos ])
		rotate([ 0, -90, c_mh7_zrot ])
		magnet_hole();
	}
}

curve_with_drill_holes();
