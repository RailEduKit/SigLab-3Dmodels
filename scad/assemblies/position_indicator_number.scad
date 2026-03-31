/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: position_indicator_number
 */

include <../config/global_variables.scad>
include <../config/colors.scad>

include <position_indicator_plate.scad>


module frame() {
	difference() {
		cube([ frame_width, frame_depth, 2 ], center = true);
		cube([ frame_width - 1, frame_depth - 1, 3 ], center = true);
	}
}

module piece_number(number) {
	color(INDICATOR_COLOR) union(){
		translate([ 0, 0, number_height ])
		rotate([ 180, 0, 0 ])
		linear_extrude(height = number_height) text(str(number), 7.5, halign = "center", valign = "center");
	}
}

module position_indicator_number() {
	translate([ x_start + 0 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(1);
	translate([ x_start + 0 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(2);
	translate([ x_start + 0 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(3);
	translate([ x_start + 0 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(4);
	translate([ x_start + 0 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(5);
	translate([ x_start + 1 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(6);
	translate([ x_start + 1 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(7);
	translate([ x_start + 1 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(8);
	translate([ x_start + 1 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(9);
	translate([ x_start + 1 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(10);
	translate([ x_start + 2 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(11);
	translate([ x_start + 2 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(12);
	translate([ x_start + 2 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(13);
	translate([ x_start + 2 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(14);
	translate([ x_start + 2 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(15);
	translate([ x_start + 3 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(16);
	translate([ x_start + 3 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(17);
	translate([ x_start + 3 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(18);
	translate([ x_start + 3 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(19);
	translate([ x_start + 3 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(20);
	translate([ x_start + 4 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(21);
	translate([ x_start + 4 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(22);
	translate([ x_start + 4 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(23);
	translate([ x_start + 4 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(24);
	translate([ x_start + 4 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(25);
	translate([ x_start + 5 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(26);
	translate([ x_start + 5 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(27);
	translate([ x_start + 5 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(28);
	translate([ x_start + 5 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(29);
	translate([ x_start + 5 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(30);
	translate([ x_start + 6 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(31);
	translate([ x_start + 6 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(32);
	translate([ x_start + 6 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(33);
	translate([ x_start + 6 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(34);
	translate([ x_start + 6 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(35);
	translate([ x_start + 7 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(36);
	translate([ x_start + 7 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(37);
	translate([ x_start + 7 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(38);
	translate([ x_start + 7 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(39);
	translate([ x_start + 7 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(40);
	translate([ x_start + 8 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(41);
	translate([ x_start + 8 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(42);
	translate([ x_start + 8 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(43);
	translate([ x_start + 8 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(44);
	translate([ x_start + 8 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(45);
	translate([ x_start + 9 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(46);
	translate([ x_start + 9 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(47);
	translate([ x_start + 9 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(48);
	translate([ x_start + 9 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(49);
	translate([ x_start + 9 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(50);
	translate([ x_start + 10 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(51);
	translate([ x_start + 10 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(52);
	translate([ x_start + 10 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(53);
	translate([ x_start + 10 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(54);
	translate([ x_start + 10 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(55);
	translate([ x_start + 11 * step_size, y_start + 0.0 * step_size, 0 ])
	piece_number(56);
	translate([ x_start + 11 * step_size, y_start + 1.0 * step_size, 0 ])
	piece_number(57);
	translate([ x_start + 11 * step_size, y_start + 2.0 * step_size, 0 ])
	piece_number(58);
	translate([ x_start + 11 * step_size, y_start + 3.0 * step_size, 0 ])
	piece_number(59);
	translate([ x_start + 11 * step_size, y_start + 4.0 * step_size, 0 ])
	piece_number(60);
}

position_indicator_number();
