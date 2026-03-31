/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: switch_locker
 */

// this locker can be combined with the mechanical switch of BRIO https://www.brio.co.uk/en-GB/products/railway-toys/train-tracks/mechanical-switches-63334400

// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git

// Include configuration file
include <../config/global_variables.scad>
include <../config/colors.scad>


//switch locker = sl
sl_width = rail_height + 2*wall_thickness;
sl_depth = 27 + wall_thickness;
sl_height = 0.6;

sl_lock_height = rail_groove_depth + sl_height + move_tolerance;

sl_barrier_width = sl_width;
sl_barrier_depth = 17.5 + wall_thickness;
sl_barrier_height = rail_height+ move_tolerance + sl_height;

sl_wedge_width = 2;
sl_wedge_depth = 3;
sl_wedge_short = 2; // alternative depth
sl_wedge_height = 9;

brio_handle_diameter = rail_height;
brio_handle_height = sl_barrier_height - sl_height;
brio_handle_depth = 15 + move_tolerance;
handle_curve_h = 2;
brio_axis_diameter = 7;

sl_handle_width = 2;
sl_handle_depth = sl_depth;
sl_handle_height = 10;


module wedge(y_value) {
    hull(){
        translate([0,0,-sl_wedge_height+nozzle_diameter/2])
        rotate([90,0,0])
        cylinder(d=nozzle_diameter, h= y_value);
        translate([-sl_wedge_width/2, -y_value, -0.2]) //sl_depth-y_value
        cube([sl_wedge_width, y_value, 0.2]);
    }
}

module half_circle(diameter) {
    difference() {
        sphere(d = diameter);
        translate([0, diameter/2, 0])
        cube([diameter, diameter, diameter],center=true);
    }
}

module brio_switch_handle() {
    // the half circle is needed, otherwise the locker moves upwards if you move the switch
    translate([0, 0, 0]) // y: handle_curve_h if you use half circle
    cube([brio_handle_diameter, brio_handle_depth, brio_handle_height]); // y: -handle_curve_h if you use half circle

    //brio sxis
    translate([(brio_handle_diameter-brio_axis_diameter)/2,brio_handle_depth,0])
    cube([brio_axis_diameter, 5, brio_handle_height]);

    // half circle
    //translate([(brio_handle_diameter)/2, handle_curve_h, (brio_handle_diameter)/2]) 
    //scale([1,handle_curve_h/((brio_handle_diameter)/2),1])
    //half_circle(brio_handle_diameter);

}

module barrier() {
    difference(){
        difference(){
            cube([sl_barrier_width, sl_barrier_depth, sl_barrier_height]);
            //TODO cut the cube to gain more flexibilaty while installation
            translate([wall_thickness,wall_thickness,0])
            brio_switch_handle();
        }
        // gap for better movement
        //translate([0,wall_thickness+handle_curve_h,0])
        //cube([sl_barrier_width,2,sl_barrier_height]);
    }

}

module handle(){
    cube([sl_handle_width, sl_handle_depth, sl_handle_height]);
}

module switch_locker() {
    color(ROUTE_COLOR) union(){
            /*     hull(){
            translate([-sl_width/2 + nozzle_diameter/2, nozzle_diameter/2, 0])
            cylinder(d = nozzle_diameter, h=sl_height);
            translate([sl_width/2-nozzle_diameter/2, nozzle_diameter/2, 0])
            cylinder(d = nozzle_diameter, h=sl_height);
            translate([0, sl_depth - nozzle_diameter/2, 0])
            cylinder(d = 5*nozzle_diameter, h=sl_height);
        } */
        difference(){
            hull(){
                translate([-sl_width/2,sl_barrier_depth,-sl_lock_height])
                cube([sl_width, 0.4, sl_lock_height]);
                translate([-sl_wedge_width/2, sl_depth-sl_wedge_depth, -sl_lock_height]) //sl_depth-y_value
                cube([sl_wedge_width, sl_wedge_depth, sl_lock_height]);
            }
            translate([-sl_barrier_width/2,sl_barrier_depth,-sl_lock_height])
            cube([sl_barrier_width, rail_well_width + 2*move_tolerance, sl_lock_height-sl_height]);
        }
        

        translate([-sl_barrier_width/2, 0, -sl_barrier_height])
        barrier();
        //translate([0,sl_depth,0])
        //wedge(sl_wedge_depth);
        //translate([0,sl_barrier_depth+sl_wedge_short+move_tolerance,0])
        //wedge(sl_wedge_short);
        translate([-sl_handle_width/2,0,0])
        handle();
    }
}

up(sl_lock_height) back(sl_depth) right(sl_width/2) zrot(180) //position for the creation of picture
switch_locker();
