/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: locking_pin
 */

include <../config/global_variables.scad>

locking_pin();

module grip_ring() {
	height = 1.2;
	depth = 1.2;
	difference() {
		cylinder(h = height, d = locker_width);
		cylinder(h = height, d = locker_width - depth);
	}
}
module locking_pin() {
	difference() {
		minkowski() {
			difference() {
				cylinder(d = locker_width - 2 * rounding, h = locker_height - 2 * rounding);
				rotate([ 0, 0, 90 ])
				translate([
					(-locker_width / 2), (-(lever_thickness_switch + move_tolerance) / 2 - rounding),
					(locker_height - lever_height)
				])
				cube([
					(locker_width), (lever_thickness_switch + 2 * rounding + move_tolerance),
					(lever_height + 2 * rounding)
				]);
			};
			sphere(rounding);
		}
		translate([ 0, 0, 1 ])
		grip_ring();
	}
}

echo("lever_height+2*rounding: ", lever_height + 2 * rounding);
echo("z_pos_axis-handle_height/2+move_tolerance+2*rounding: ",
     z_pos_axis - handle_height / 2 + move_tolerance + 2 * rounding);

// signal_locker();
