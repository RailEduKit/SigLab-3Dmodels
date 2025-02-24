// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

$fn = 200;

module connector_cutout(){
    translate([0,0,dtc_cutout_z_pos]) difference(){
        rotate_extrude(angle = dtc_cutout_middle_angle) square([dtc_side_radius+1, dtc_cutout_height]);
        rotate_extrude(angle = dtc_cutout_middle_angle) square([dtc_middle_radius,dtc_cutout_height]);
    }
}

module inner_curve_cutout(){
    translate([0,0,dtc_cutout_z_pos]) difference(){
        rotate_extrude(angle = dtc_cutout_inner_angle) square([dtc_side_radius+1, dtc_cutout_height]);
        rotate_extrude(angle = dtc_cutout_inner_angle) square([dtc_inner_radius,dtc_cutout_height]);        
    }
}

module outer_curve_cutout(){
    rotate_extrude(angle = dtc_cutout_inner_angle) square([dtc_outer_radius, dtc_cutout_height]);
}

module template_outer_curve(){

translate([-(dtc_inner_radius-65),0,0])difference(){ 
difference(){
    rotate_extrude(angle = 90) square([dtc_side_radius, dtc_height]);
    inner_curve_cutout();
}
    connector_cutout();
    translate([0,125,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dsc_depth]);
    translate([0,65,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dsc_depth]);
    cube([dtc_inner_radius-65, dtc_side_radius, 2*dtc_cutout_z_pos+dsc_depth]);
    
    // hole position lines
    translate([dtc_side_radius-2*line_thickness, dtch_y_pos-line_thickness/2, dtc_cutout_z_pos+dsc_depth])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_side_radius-2*line_thickness, dtch_y_pos-line_thickness/2, dtc_cutout_z_pos-dsc_depth])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_inner_radius-2*line_thickness, dtch_y_pos-line_thickness/2, dtc_cutout_z_pos])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_inner_radius-2*line_thickness, dtch_y_pos-dsc_depth/2,dtc_cutout_z_pos+dtch_z_pos-line_thickness/2]) cube([2*line_thickness, dsc_depth, line_thickness]);
    translate([dtc_inner_radius-2*line_thickness,dtch_y_pos-line_thickness/2, dtc_cutout_z_pos-line_thickness]) cube([dtc_side_radius-dtc_inner_radius, line_thickness, line_thickness]);
    translate([dtc_inner_radius-2*line_thickness,dtch_y_pos-line_thickness/2, dtc_cutout_z_pos+dsc_depth]) cube([dtc_side_radius-dtc_inner_radius, line_thickness, line_thickness]);

    // hole position lines for switch hole (straight junction)
    translate([dtc_side_radius-2*line_thickness-49.3, dtc_switch_hole_y_pos-line_thickness/2, dtc_cutout_z_pos+dsc_depth])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_side_radius-2*line_thickness-49.3, dtc_switch_hole_y_pos-line_thickness/2, dtc_cutout_z_pos-dsc_depth])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_inner_radius-2*line_thickness-45, dtc_switch_hole_y_pos-line_thickness/2, dtc_cutout_z_pos])cube([2*line_thickness, line_thickness, dsc_depth]);
    translate([dtc_inner_radius-2*line_thickness-46, dtc_switch_hole_y_pos-dsc_depth/2,dtc_cutout_z_pos+dtch_z_pos-line_thickness/2]) cube([4*line_thickness, dsc_depth, line_thickness]);
    translate([dtc_inner_radius-2*line_thickness-46,dtc_switch_hole_y_pos-line_thickness/2, dtc_cutout_z_pos-line_thickness]) cube([dtc_side_radius-dtc_inner_radius, line_thickness, line_thickness]);
    translate([dtc_inner_radius-2*line_thickness-46,dtc_switch_hole_y_pos-line_thickness/2, dtc_cutout_z_pos+dsc_depth]) cube([dtc_side_radius-dtc_inner_radius, line_thickness, line_thickness]);
}

}

module template_inner_curve(){
difference(){
    cube([180, 70, 2*dtc_cutout_z_pos+dtc_cutout_height]);
}
}


//template_outer_curve();
template_inner_curve();


