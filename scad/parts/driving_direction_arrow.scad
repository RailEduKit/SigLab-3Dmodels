/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: component/driving_direction_arrow
 */

module attach_arrow() {
	hull() {
		cyl_d = 0.4;
		translate([ cyl_d / 2, (attach_arrow_depth - cyl_d) / 2, 0 ])
		cylinder(d = cyl_d, h = attach_arrow_height);
		translate([ cyl_d / 2, -(attach_arrow_depth - cyl_d) / 2, 0 ])
		cylinder(d = cyl_d, h = attach_arrow_height);
		translate([ attach_arrow_depth - cyl_d / 2, 0, 0 ])
		cylinder(d = cyl_d, h = attach_arrow_height);
	}
}

module driving_direction_arrow() {
	translate([ attach_arrow_depth / 2, 0, 0 ])
	rotate([ 0, 0, -90 ])
	color(INDICATOR_COLOR) attach_arrow();
	translate([ (attach_arrow_depth - 1.2) / 2, 0, 0 ])
	color(INDICATOR_COLOR) cube([ 1.2, attach_arrow_depth, attach_arrow_height ]);
}
