// Copyright 2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

module diagonal_cutout(){
    translate([0,0,4])rotate([0,-17.5,0]) union(){
        cube([85, dsb_depth, 30]);
        // chamfer
        translate([85/2+2.6,dsc_y_pos,0])rotate([45,0,0])cube([80, 3, 3], center=true);
        translate([85/2+2.6,dsc_y_pos+dsc_depth,0])rotate([45,0,0])cube([80, 3, 3], center=true);
    }
}


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
    diagonal_cutout();
    
    
    // hole position lines
    translate([dsc_rail_width-2*dsg_hole_depth, dsc_y_pos+(dsc_depth-thin_line)/2, dsg_thickness-thin_line]) cube([dsg_hole_depth,thin_line,thin_line]);
    translate([dsc_rail_width-dsh_x_pos-thin_line/2, dsc_y_pos, dsg_thickness-thin_line])cube([thin_line, dsc_depth, thin_line]);
    translate([dsc_rail_width-dsh_x_pos-thin_line/2, dsc_y_pos-dsc_depth, dsb_height-thin_line])cube([thin_line, dsc_depth, thin_line]);
    translate([dsc_rail_width-dsh_x_pos-thin_line/2, dsc_y_pos+dsc_depth, dsb_height-thin_line])cube([thin_line, dsc_depth, thin_line]);
    translate([dsc_rail_width-dsh_x_pos-thin_line/2, dsc_y_pos-thin_line, dsg_thickness-thin_line]) cube([thin_line, thin_line, dsb_height]);
    translate([dsc_rail_width-dsh_x_pos-thin_line/2, dsc_y_pos+dsc_depth, dsg_thickness-thin_line]) cube([thin_line, thin_line, dsb_height]);
    
}
//translate([-dsc_supporting_surface_width, dsc_y_pos, 0]) cube([dsc_supporting_surface_width, rail_height+move_tolerance, dsg_thickness]);
}

template_straight();
//diagonal_cutout();