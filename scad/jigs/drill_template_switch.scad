/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: drill_template_switch
 */

include <../config/global_variables.scad>

module switch_shape() {
	translate([ dtc_outer_radius + 45, 0, dtc_cutout_z_pos ])
	rotate([ 0, 0, 180 - curve_angle ])
	union() {
		rotate_extrude(angle = curve_angle) square([ dtc_outer_radius, dtc_cutout_height ]);
		translate([ dtc_outer_radius - rail_width - 15, 0, 0 ])
		cube([ rail_width + 15, straight_length, dsc_depth ]);
		translate([ dtc_outer_radius - (rail_width - 12) - 12, 0, 0 ])
		cube([ rail_width - 12, straight_length + 19, dsc_depth ]);
	}
}

module drill_template_switch() {
	difference() {
		cube([ 80, 130, dtc_height ]); // dtc_height
		switch_shape();

		// curved sides
		translate([ 24 + dtc_outer_radius + dsg_thickness, 0, dtc_cutout_z_pos + dtc_cutout_height ])
		rotate([ 0, 0, 180 - curve_angle ])
		rotate_extrude(angle = curve_angle) square([ dtc_middle_radius, dtc_cutout_z_pos ]);
		translate([ 24 + dtc_outer_radius + dsg_thickness, 0, 0 ])
		rotate([ 0, 0, 180 - curve_angle ])
		rotate_extrude(angle = curve_angle) square([ dtc_middle_radius, dtc_cutout_z_pos ]);

		// ground holes
		translate([ 0, 30, dtc_cutout_z_pos ])
		cube([ 60, dsg_hole_depth, dtc_cutout_height ]);
		translate([ 0, 65, dtc_cutout_z_pos ])
		cube([ 60, dsg_hole_depth, dtc_cutout_height ]);

		// hole position lines
		translate([ 44, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos ])
		cube([ 2 * thin_line, thin_line, dtc_cutout_height ]);
		translate([ 44, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos - thin_line ])
		cube([ dtc_cutout_z_pos + 5, thin_line, thin_line ]);
		translate([ 44, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos + dtc_cutout_height ])
		cube([ dtc_cutout_z_pos + 5, thin_line, thin_line ]);
		translate([ 44, dtch_y_pos - 5 / 2, dtc_cutout_z_pos + dtch_z_pos ])
		cube([ 2 * thin_line, 5, thin_line ]);
	}
	// translate([0,-5,0]) cube([45+12, 5,dtc_height]);
	difference() {
		union() {
			// stabilisation pillar
			cube([ 45 + rail_width, 15, dtc_cutout_z_pos ]);
			translate([ 0, 0, dtc_cutout_z_pos + dtc_cutout_height ])
			cube([ 45 + rail_width, 15, dtc_cutout_z_pos ]);
		}
		translate([ 45 + rail_width - 2 * thin_line, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos - dtc_cutout_height ])
		cube([ 2 * thin_line, thin_line, dtc_cutout_height ]);
		translate([ 45 + rail_width - 2 * thin_line, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos + dtc_cutout_height ])
		cube([ 2 * thin_line, thin_line, dtc_cutout_height ]);
		translate([ 44, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos - thin_line ])
		cube([ dtc_cutout_z_pos + rail_width, thin_line, thin_line ]);
		translate([ 44, dtch_y_pos - thin_line / 2, dtc_cutout_z_pos + dtc_cutout_height ])
		cube([ dtc_cutout_z_pos + rail_width, thin_line, thin_line ]);
	}
	// connector space
	difference() {
		translate([ 0, -dsc_connector_width / 2, 0 ])
		cube([ 45 + rail_width, dsc_connector_width / 2, 2 * dtc_cutout_z_pos + dtc_cutout_height ]);
		translate([ 45 + 12, -dsc_connector_width, dtc_cutout_z_pos ])
		cube([ dsc_connector_height, dsc_connector_width, dsc_depth ]);
		translate([ 45 + rail_width - 2 * thin_line, -dsc_connector_width, dtc_cutout_z_pos + dtch_z_pos ])
		cube([ 2 * thin_line, dsc_connector_width, thin_line ]);
	}
}
// switch_shape();

drill_template_switch();
