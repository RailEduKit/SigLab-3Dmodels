// Copyright 2020,2024 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

/*****
To have the dimensions of all components at one place
*******/

/*******
TODO
- standard on which part the move tolerance is substracted?
******/
// ATTENTION: Note the general move_tolerance of 0.5

move_tolerance = 0.5;

{/***************wood rail specification***************/
    // rail instead of wood to prevent duplicate variables with tracklib.scad file
    rail_height = 12;
    rail_width = 40;
    rail_thickness_track = 6;
    rail_well_height = 9; // copy from tracklib
    rail_well_width = 5.7; // copy from tracklib
    rail_well_spacing = 19.25; // copy from tracklib

    straight_length = 144;

    curve_radius = 182; // inner radius
    curve_angle = 45; // degree
}
{/***************magnet specifications***************/
    magnet_thickness = 3;
    magnet_diameter = 5;
    magnet_distance_to_middle = 7.5;
    magnet_z = 5.75;
}
{/***************engraving specifications***************/
    engraving_height = 2;//(block_height-handle_height)/2;
    engraving_thickness = 1.5;
}

{/***************basis_component-roundedBox***************/
    body_width = 30;
    body_depth = 50;
    body_height = 13.5; 
    track_arc_inner_radius = 182;
    sagitta = 0.43; //DE: Pfeilhöhe -> 25mm Straighten round edge in the middle
}


{/***************overlap_measure***/ //-> not integrated yet
    // overlap measure -> om
    om_thickness = 2;
    // pin specifications
    om_pin_height = 5;
    om_pin_diameter = 4.5;
    om_pin_y_pos = 25;
    
    // track guidance
    om_track_guidance_width = 0.8;
    om_track_guidance_height = 2.5;
    
    //dovetail connector specifications
    om_dovetail_width = 10;
    om_dovetail_depth = 5;
    
    
}
{/***************switch_blade_optimized***************/
    //blade specification
    blade_thickness = 2.5;
    blade_cover_thicknes = 0.6; //attention: female blade is thinner -> effect on lever_anchor pins?
    blade_length = 45;
    blade_width  = 19;

    //lever anchor specification
    lever_hole_size = 2.6;
    lever_anchor_posX = blade_width*1/5;
    lever_anchor_posY = blade_length*0.8111;

    //pin specification
    wall_thickness = 1.5;
    pin_diameter = om_pin_diameter+move_tolerance+wall_thickness;
    pin_female_diameter = pin_diameter+move_tolerance+wall_thickness;
    pin_height = rail_thickness_track+move_tolerance;
    y_pos_first_pin = pin_diameter;
    y_pos_second_pin = (blade_length*2/3);
    overlap = blade_thickness-blade_cover_thicknes; // height of pin_hole, otherwise the pin_hole doesn't stand on the blade -> bug?
}
{/***************switch_body***************/
    //holes_for_blade
    pivot_center_x = rail_width/2;
    pivot_center_y=25;
    
    //switchblade_space -> sbs
    sbs_gap_to_wood = 4;
    sbs_width = rail_width;
    sbs_radius = blade_length+2*sbs_gap_to_wood;
    sbs_height = rail_height-rail_well_height;
    sbs_xpos = -rail_well_width-2;
    sbs_ypos = pivot_center_y - pin_diameter - sbs_gap_to_wood;
}

{/***************locking_pin***************/
    locker_width = 14;
    locker_height = 25;
    lever_height = 10;
    lever_thickness_switch = 4;
    rounding = 0.5;
}
{/***************distant-main_signal***************/
    block_width=undef;

    // body specifications
    axis_diameter = 2.5; //maybe use the same material as lever anchor
    wall_thickness_x = (body_width-block_width)/2-move_tolerance;//5;
    wall_thickness_y = lever_thickness_switch;
    wall_thickness_z = 2;
    z_pos_axis = 10; // the block_height=13.5 lies a bit heigher, previous: block_height/2+wall_thickness_z

    // Locking Part specifications
    lock_lever_depth = 9.5;
    lock_lever_thickness = 2.5;
    lock_lever_height = 10;
    foot_width = 2.5;

    // color_block specifications
    block_width = 20; //material constraint //body_width-2*wall_thickness_x-move_tolerance;
    block_depth = (body_depth-2*wall_thickness_y)/2-3*move_tolerance;
    block_height = 13.5; // material constraint
    //block_height =(body_height-wall_thickness_z)*1.4; //the heigher the value, the more color_block comes out of the body. BUT also: the higher will be the axis hole
    overhang = block_height/2-2*move_tolerance; //the circle has to be flattend at one side with move_tolerance
    handle_depth = 10+wall_thickness_y;
    handle_height = 3;

    //Symbol Specifications
    signal_symbol_side_space = 4;
    signal_symbol_size = block_width-2*signal_symbol_side_space;
    signal_triangle_height = (sqrt(3)*signal_symbol_size)/2;
}
{/***************FZS_SZS***************/
    zs_with = 25;
    zs_depth = 10;
    zs_height = 15;

    cp_symbol_side_space = 2;
    cp_symbol_size = zs_depth-2*cp_symbol_side_space;
}

{/***************drill_template_straight***************/
    line_thickness = 0.8;
    // drill straight ground
    dsg_thickness = 5;
    dsg_hole_depth = 5;
    // drill straight cutout = dsc
    dsc_connector_width = 19;
    dsc_rail_width = 73;
    dsc_y_pos = 12;
    dsc_depth = rail_height+move_tolerance;

    dsc_connector_z_pos = dsg_thickness+12;
    dsc_supporting_surface_width = 50;

    // drill straight hole
    dsh_y_pos = (rail_height+move_tolerance)/2;
    dsh_x_pos = 7.5;



    // drill straigth base = dsb
    dsb_width = dsc_rail_width+dsc_connector_width;
    dsb_depth = 2*dsc_y_pos+dsc_depth;
    dsb_height = 27;
}

{/***************drill_template_curve***************/
    // drill template curve = dtc
    dtc_cutout_middle_angle = 45+5;

    dtc_cutout_z_pos = 12;
    dtc_cutout_height = dsc_depth;
    dtc_outer_radius = curve_radius+rail_width;
    dtc_side_radius = curve_radius + 30;
    dtc_middle_radius = curve_radius + 12;
    dtc_inner_radius = curve_radius;

    dtc_height = 2*dtc_cutout_z_pos+dtc_cutout_height;

    // drill template curve hole
    dtch_z_pos = (rail_height+move_tolerance)/2;
    dtch_y_pos = 7.5;

    dtc_switch_hole_y_pos = 136.5;
}
{/***************drill_template_switch***************/
    // all needed values in "drill_template_curve" and "drill_template_straight"
}

{/***************magnet_rod***************/
    //magnet rod = mr
    mr_diameter = 10;
    mr_height = 100;
    
}



{/***************roadCheckbox***************/
    // used "basis_component-roundedBox" and "locking_pin"
    //road Checkbox -> rc
    rc_symbol_side_space = 2;
    rc_symbol_size = body_width*(2/3)-locker_width/2-2*rc_symbol_side_space;
    echo("rc_symbol_size: ", rc_symbol_size);
    rc_symbol_xpos = body_width - (body_width - (body_width*(1/3)+locker_width/2))/2;
    straight_thickness = 0.8;
}

{/***************direction_management***************/
    arrow_depth = 6.5; //5 for onePiece
    arrowline_length = 6.5; //5 for onePiece
    
    arrow_block_height = block_height-engraving_height;
    
}









