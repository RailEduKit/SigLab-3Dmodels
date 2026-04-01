/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: sigal_distant-polarity
 */

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>

// use common parts
include <../parts/signal_box.scad>
use <../views/signal_distant.scad>
use <polarity_indicator.scad>

module signal_distant_polarity(state) {
    signal_distant(state);
    polarity_bars_signal_box();
}

right(body_width) zrot(180) //position for the creation of picture
signal_distant_polarity("APPROACH");