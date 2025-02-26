// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

module template_straight(){
difference(){
    cube([dsb_width, dsb_depth, dsb_height]);
    //straight
    translate([0,dsc_y_pos,dsg_thickness]) cube([dsc_rail_width, dsc_depth, dsb_height]);
    //connector
    translate([dsc_rail_width,dsc_y_pos, dsc_connector_z_pos]) cube([dsc_connector_width,dsc_depth, dsc_connector_z_pos]);
    // ground holes
    for (x=[dsc_rail_width-dsg_hole_depth : -10 : 5]){
        translate([x,dsc_y_pos,0]) cube([dsg_hole_depth,dsc_depth,dsg_thickness]);
    }
    
    
    // hole position lines
    translate([dsc_rail_width-2*dsg_hole_depth, dsc_y_pos+(dsc_depth-line_thickness)/2, dsg_thickness-line_thickness]) cube([dsg_hole_depth,line_thickness,line_thickness]);
    translate([dsc_rail_width-dsh_x_pos-line_thickness/2, dsc_y_pos, dsg_thickness-line_thickness])cube([line_thickness, dsc_depth, line_thickness]);
    translate([dsc_rail_width-dsh_x_pos-line_thickness/2, dsc_y_pos-dsc_depth, dsb_height-line_thickness])cube([line_thickness, dsc_depth, line_thickness]);
    translate([dsc_rail_width-dsh_x_pos-line_thickness/2, dsc_y_pos+dsc_depth, dsb_height-line_thickness])cube([line_thickness, dsc_depth, line_thickness]);
    translate([dsc_rail_width-dsh_x_pos-line_thickness/2, dsc_y_pos-line_thickness, dsg_thickness-line_thickness]) cube([line_thickness, line_thickness, dsb_height]);
    translate([dsc_rail_width-dsh_x_pos-line_thickness/2, dsc_y_pos+dsc_depth, dsg_thickness-line_thickness]) cube([line_thickness, line_thickness, dsb_height]);
    
}
//translate([-dsc_supporting_surface_width, dsc_y_pos, 0]) cube([dsc_supporting_surface_width, rail_height+move_tolerance, dsg_thickness]);
}

template_straight();