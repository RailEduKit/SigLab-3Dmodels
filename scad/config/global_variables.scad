/* RailEduKit/InteractiveSignallingLaboratory © 2025 by Martin Scheidt and contributors
 * License: CC-BY 4.0 - https://creativecommons.org/licenses/by/4.0/
 * Project description: The Interactive Signalling Laboratory is a tool for training in Rail
 * Applications to enhance the knowledge of control and signalling principles for rail transport systems.
 *
 * Module: config/global_variables.scad
 */

/* 
++++++++++++++++++++++++ Start of New Structure +++++++++++++++++++++++++++++++++++

the structure should orientate on the file structure
but some variables have to stand on the top of the structure


 */

{// assemblies
    {// balise
            
    }
    {// checkbox_route
        
    }
    {// clearing_point_block

    }
    {// clearing_point_route

    }
    {// direction_management_box

    }
    {// direction_management_lever

    }
    {// locking_pin

    }
    {// overlap_measure

    }
    {// position_indicator_number

    }
    {
        
    }
}
{// jigs


}









/* 
++++++++++++++++++++++++ End of New Structure +++++++++++++++++++++++++++++++++++
 */

/*************** resolution ***************/
// number of fragments; default 0;
//When this variable has a value greater than zero, the two variables $fa and $fs are ignored
$fn = $preview ? 32 : 128;

// $fa = 12;// minimum angle for a fragment; default 12; minimum allowed value is 0.01
// $fs = 2;// minimum size of a fragment; default 2; minimum allowed value is 0.01

/*****
To have the dimensions of all components at one place
*******/

/*******
TODO
- standard on which part the move tolerance is substracted?
******/
// ATTENTION: Note the general move_tolerance of 0.5

move_tolerance = 0.5;

nozzle_diameter = 0.4;

{/***************wood rail specification***************/
    // rail instead of wood to prevent duplicate variables with tracklib.scad file
    rail_height = 12;
    rail_width = 40;
    rail_thickness_track = 6;
    rail_well_height = 9; // copy from tracklib
    rail_well_width = 5.7; // copy from tracklib
    rail_well_spacing = 19.25; // copy from tracklib
    rail_groove_depth = rail_height - rail_well_height;

    straight_length = 144;

    curve_inner_radius = 180; // 182; // inner radius
    curve_middle_radius = curve_inner_radius+rail_width/2;
    curve_outer_radius = curve_inner_radius+rail_width;
    curve_angle = 45.7; // degree
    curve_length_middle_radius = (2*PI*curve_middle_radius*curve_angle)/360;
}
{/***************magnet specifications***************/

}
{/***************engraving specifications***************/
    engraving_height = 2;//(block_height-handle_height)/2;
    engraving_thickness = 1.5;
    
  
    fine_line = 0.2;
    thin_line = 0.8;
    regular_line = 1;
}



{/***************basis_component-roundedBox***************/
    body_width = 30;
    body_depth = 50;
    body_height = 13.5; 
    track_arc_inner_radius = 182;
    sagitta = 0.43; //DE: Pfeilhöhe -> 25mm Straighten round edge in the middle
}


{/***************overlap_measure***************/    
}

{/***************straight***************/
    //straight = s
    // pin hole 1 = ph1
    s_ph_xpos = rail_width/2;
    s_ph1_ypos = 30;
    s_ph2_ypos = straight_length/2;
    s_ph3_ypos = straight_length-s_ph1_ypos;
    
    // magnet hole = mh
    s_mh_xpos = rail_width;
    s_mh_zpos = rail_height/2;
    s_mh_ypos1 = 7.5;
    s_mh_ypos2 = straight_length-s_mh_ypos1;
    
    
}

{/***************curve***************/
    

    // curve = c
    // pin hole 1 = ph1
    c_alpha = (s_ph1_ypos * 360)/(2*PI*curve_middle_radius);
    c_ph1_ypos = sin(c_alpha) * curve_middle_radius;
    c_ph1_xpos = curve_outer_radius - cos(c_alpha) * curve_middle_radius;
    // pin hole 2 = ph2
    c_beta = curve_angle/2;
    c_ph2_ypos = sin(c_beta) * curve_middle_radius;
    c_ph2_xpos = curve_outer_radius - cos(c_beta) * curve_middle_radius;
    // pin hole 3 = ph3
    c_gamma = curve_angle - c_alpha;
    c_ph3_ypos = sin(c_gamma) * curve_middle_radius;
    c_ph3_xpos = curve_outer_radius - cos(c_gamma) * curve_middle_radius;

    // echo("  ");
    // echo("c_ph1_ypos", c_ph1_ypos);
    // echo("c_ph1_xpos", c_ph1_xpos);
    // echo("  ");
    // echo("c_ph2_ypos", c_ph2_ypos);
    // echo("c_ph2_xpos", c_ph2_xpos);
    // echo("  ");
    // echo("c_ph3_ypos", c_ph3_ypos);
    // echo("c_ph3_xpos", c_ph3_xpos);
    // echo("  ");

    c_mh_zpos = rail_height/2;
    // magnet hole 4 = mh1
    c_mh4_xpos = 0.1;
    c_mh4_ypos = 7.7;
    c_mh4_zrot = -2;
    // magnet hole 5 = mh1
    c_mh5_xpos = 40.3;
    c_mh5_ypos = 7.5;
    c_mh5_zrot = -2.4;
    // magnet hole 6 = mh1
    c_mh6_xpos = 61;
    c_mh6_ypos = 152;
    c_mh6_zrot = -43.7;
    // magnet hole 7 = mh1
    c_mh7_xpos = 89.05;
    c_mh7_ypos = 123.35;
    c_mh7_zrot = -43.3;
    
}



{/***************switch_blade***************/
    // Configuration for the mechanical switch of BRIO
    //blade specification
    blade_thickness = 2.5;
    blade_cover_thicknes = 0.6; //attention: female blade is thinner -> effect on lever_anchor pins?
    blade_length = 46;
    blade_width  = 19;

    //lever anchor specification
    lever_hole_size = 2.6;
    lever_anchor_posX = blade_width*1/5;
    lever_anchor_posY = blade_length*0.8111;

    //pin specification
    wall_thickness = 1.5;
    pin_female_diameter = 7.5; //pin_diameter+move_tolerance+wall_thickness;
    pin_diameter = pin_female_diameter - move_tolerance - wall_thickness;//om_pin_diameter+move_tolerance+wall_thickness;
    pin_height = rail_thickness_track+move_tolerance;
    y_pos_first_pin = pin_female_diameter/2+1;
    y_pos_second_pin = 30.75;//(blade_length*2/3);
    overlap = blade_thickness-blade_cover_thicknes; // height of pin_hole, otherwise the pin_hole doesn't stand on the blade -> bug?

    
/*     //blade specification
    blade_thickness = 2.5;
    blade_cover_thicknes = 0.6; //attention: female blade is thinner -> effect on lever_anchor pins?
    blade_length = 46;
    blade_width  = 19;

    //lever anchor specification
    lever_hole_size = 2.6;
    lever_anchor_posX = blade_width*1/5;
    lever_anchor_posY = blade_length*0.8111;

    //pin specification
    wall_thickness = 1.5;
    pin_female_diameter = pin_diameter+move_tolerance+wall_thickness;
    pin_diameter = om_pin_diameter+move_tolerance+wall_thickness;
    pin_height = rail_thickness_track+move_tolerance;
    y_pos_first_pin = pin_female_diameter/2+1;
    y_pos_second_pin = (blade_length*2/3);
    overlap = blade_thickness-blade_cover_thicknes; // height of pin_hole, otherwise the pin_hole doesn't stand on the blade -> bug? */
}
{/***************switch_body***************/
    //holes_for_blade
    pivot_center_x = rail_width/2;
    pivot_center_y= s_ph1_ypos;
    
    //switchblade_space -> sbs
    sbs_gap_to_wood = 1.5;
    sbs_width = rail_width;
    sbs_radius = blade_length+2*sbs_gap_to_wood;
    sbs_height = rail_height-rail_well_height;
    sbs_xpos = -rail_well_width-2;
    sbs_ypos = pivot_center_y - y_pos_first_pin-sbs_gap_to_wood;
}

{/***************locking_pin***************/
    
}
{/***************distant and block signal***************/
}

{/***************drill_template_straight***************/
    drill_move_tolerance = 0.3;
    // drill straight ground
    dsg_thickness = 5;
    dsg_hole_depth = 5;
    // drill straight cutout = dsc
    dsc_connector_width = 15;
    dsc_connector_height = 15;
    dsc_y_pos = 12;
    dsc_depth = rail_height+drill_move_tolerance;

    dsc_connector_z_pos = dsg_thickness+12;
    dsc_supporting_surface_width = 50;

    // drill straight hole
    dsh_y_pos = dsc_depth/2;
    dsh_x_pos = 7.5;

    // drill straigth base = dsb
    dsb_depth = 2*dsc_y_pos+dsc_depth;
    dsb_height = dsg_thickness+rail_width;//27;
}

{/***************drill_template_curve***************/
    // drill template curve = dtc
    dtc_cutout_middle_angle = 45+5;

    dtc_cutout_z_pos = 12;
    dtc_cutout_height = dsc_depth;
    dtc_outer_radius = curve_inner_radius+rail_width;
    dtc_side_radius = curve_inner_radius + 28;
    dtc_middle_radius = curve_inner_radius + 12;
    dtc_inner_radius = curve_inner_radius;

    dtc_height = 2*dtc_cutout_z_pos+dtc_cutout_height;

    // drill template curve hole
    dtch_z_pos = dsc_depth/2;
    dtch_y_pos = 7.5;

    dtc_switch_hole_y_pos = straight_length-dtch_y_pos;
    
    // horizontal template = ht
    origin_shift = 10;
    ht_scope = 0.1;
    ht_male_connector_angle = 1.8; //6mm
    ht_height = rail_height/2;
    ht_beta = curve_angle+ht_male_connector_angle;
    male_connector_space_xpos = (curve_outer_radius)-cos(ht_beta)*curve_middle_radius;
    male_connector_space_ypos = sin(ht_beta)*curve_middle_radius;
    
    grip_hole_left_xpos = (curve_outer_radius)-cos(ht_beta/2)*curve_outer_radius;
    grip_hole_left_ypos = sin(ht_beta/2)*curve_outer_radius;
    grip_hole_right_xpos = (curve_outer_radius)-cos(ht_beta/2)*curve_inner_radius;
    grip_hole_right_ypos = sin(ht_beta/2)*curve_inner_radius;
}
{/***************drill_template_switch***************/
    // all needed values in "drill_template_curve" and "drill_template_straight"
}

{/***************magnet_rod***************/
    //magnet rod = mr
    mr_diameter = 20;
    mr_height = 100;
    
}



{/***************direction_management***************/
}

{/***************number_plate***************/
    // om oin variables now in parts/track_indicator_flexible
    
    // number_plate = np
    np_diameter = rail_well_spacing-2*3;
    np_height = 1;
    number_height = 0.6;
/*  om_pin variables are defined in track_indicator flexible   
    np_pin_diameter = om_pin_diameter;
    np_pin_height = om_pin_height; */
    frame_width = 180;
    frame_depth = 180;
    step_size = np_diameter+2*move_tolerance;
    x_start = -(frame_width/2-np_diameter/2-1);
    y_start = -(frame_depth/2-np_diameter/2-1);
}

{/***************balise***************/
}

{/***************train integrity***************/
}

{/***************switch locker***************/
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
}

{/***************route_indicator_straight***************/
    
}

{/***************route_indicator_curve***************/
    
}
