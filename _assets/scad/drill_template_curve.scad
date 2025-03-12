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
        rotate_extrude(angle = curve_angle) square([dtc_side_radius+1, dtc_cutout_height]);
        rotate_extrude(angle = curve_angle) square([dtc_inner_radius,dtc_cutout_height]);        
    }
}

module outer_curve_cutout(){
    translate([dtc_outer_radius+dsg_thickness,0,dtc_cutout_z_pos])rotate([0,0,180-curve_angle])rotate_extrude(angle = curve_angle) square([dtc_outer_radius, dtc_cutout_height]);
}

module template_outer_curve(){

translate([-(dtc_inner_radius-65),0,0])difference(){ 
difference(){
    rotate_extrude(angle = 90) square([dtc_side_radius, dtc_height]);
    inner_curve_cutout();
}
    connector_cutout();
    //ground holes
    translate([0,125,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dtc_cutout_height]);
    translate([0,65,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dtc_cutout_height]);
    translate([0,0,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dtc_cutout_height]);
    translate([0,10,dtc_cutout_z_pos]) cube([dtc_inner_radius, dsg_hole_depth, dtc_cutout_height]);
    
    // trim template to relevant size
    cube([dtc_inner_radius-65, dtc_side_radius, dtc_height]);
    translate([dtc_inner_radius-65,148,0])cube([50, 50, dtc_height]);
    
    // hole position lines
    translate([dtc_side_radius-2*thin_line, dtch_y_pos-thin_line/2, dtc_cutout_z_pos+dtc_cutout_height])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_side_radius-2*thin_line, dtch_y_pos-thin_line/2, dtc_cutout_z_pos-dtc_cutout_height])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_inner_radius-2*thin_line, dtch_y_pos-thin_line/2, dtc_cutout_z_pos])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_inner_radius-2*thin_line, dtch_y_pos-dtc_cutout_height/2,dtc_cutout_z_pos+dtch_z_pos-thin_line/2]) cube([2*thin_line, dtc_cutout_height, thin_line]);
    translate([dtc_inner_radius-2*thin_line,dtch_y_pos-thin_line/2, dtc_cutout_z_pos-thin_line]) cube([dtc_side_radius-dtc_inner_radius, thin_line, thin_line]);
    translate([dtc_inner_radius-2*thin_line,dtch_y_pos-thin_line/2, dtc_cutout_z_pos+dtc_cutout_height]) cube([dtc_side_radius-dtc_inner_radius, thin_line, thin_line]);

    // hole position lines for switch hole (straight junction)
    translate([dtc_side_radius-2*thin_line-49.3, dtc_switch_hole_y_pos-thin_line/2, dtc_cutout_z_pos+dtc_cutout_height])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_side_radius-2*thin_line-49.3, dtc_switch_hole_y_pos-thin_line/2, dtc_cutout_z_pos-dtc_cutout_height])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_inner_radius-2*thin_line-45, dtc_switch_hole_y_pos-thin_line/2, dtc_cutout_z_pos])cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([dtc_inner_radius-2*thin_line-46, dtc_switch_hole_y_pos-dtc_cutout_height/2,dtc_cutout_z_pos+dtch_z_pos-thin_line/2]) cube([4*thin_line, dtc_cutout_height, thin_line]);
    translate([dtc_inner_radius-2*thin_line-46,dtc_switch_hole_y_pos-thin_line/2, dtc_cutout_z_pos-thin_line]) cube([dtc_side_radius-dtc_inner_radius, thin_line, thin_line]);
    translate([dtc_inner_radius-2*thin_line-46,dtc_switch_hole_y_pos-thin_line/2, dtc_cutout_z_pos+dtc_cutout_height]) cube([dtc_side_radius-dtc_inner_radius, thin_line, thin_line]);
}
translate([0,-5,0]) cube([65+12,5,dtc_height]);
}

module template_inner_curve(){
difference(){
    cube([70, 130, 2*dtc_cutout_z_pos+dtc_cutout_height]);
    outer_curve_cutout();
    // curved sides
    translate([dtc_outer_radius+dsg_thickness,0,dtc_cutout_z_pos+dtc_cutout_height])rotate([0,0,180-curve_angle])rotate_extrude(angle = curve_angle) square([dtc_middle_radius, dtc_cutout_z_pos]);
    translate([dtc_outer_radius+dsg_thickness,0,0])rotate([0,0,180-curve_angle])rotate_extrude(angle = curve_angle) square([dtc_middle_radius, dtc_cutout_z_pos]);
    # translate([65,130/2-5,0]) rotate([0,0,-15]) scale([0.5,1,1]) cylinder(d=120, h=dtc_cutout_z_pos);
    
    // ground holes
    translate([0,0,dtc_cutout_z_pos])cube([70, dsg_hole_depth, dtc_cutout_height]);
    translate([0,10,dtc_cutout_z_pos])cube([70, dsg_hole_depth, dtc_cutout_height]);
    translate([0,70,dtc_cutout_z_pos])cube([70, dsg_hole_depth, dtc_cutout_height]);
    
    // hole position lines
    translate([32, dtch_y_pos-thin_line/2, dtc_cutout_z_pos-dtc_cutout_height]) cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([32, dtch_y_pos-thin_line/2, dtc_cutout_z_pos+dtc_cutout_height]) cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([4, dtch_y_pos-thin_line/2, dtc_cutout_z_pos]) cube([2*thin_line, thin_line, dtc_cutout_height]);
    translate([4, dtch_y_pos-thin_line/2,dtc_cutout_z_pos-thin_line])cube([30, thin_line, thin_line]);
    translate([4, dtch_y_pos-thin_line/2,dtc_cutout_z_pos+dtc_cutout_height])cube([30, thin_line, thin_line]);
    translate([4, dtch_y_pos-5/2, dtc_cutout_z_pos+dtch_z_pos]) cube([2*thin_line, 5, thin_line]);
}
translate([0,-5,0])cube([dsg_thickness+12,5,2*dtc_cutout_z_pos+dtc_cutout_height]);
}

//template_outer_curve();
//translate([100,0,0]) template_outer_curve();
template_inner_curve();




