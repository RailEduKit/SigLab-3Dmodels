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
}
{/***************overlap_measure***************/    
}
{/***************straight***************/
}
{/***************curve***************/
}
{/***************switch_blade***************/
}
{/***************switch_body***************/
}
{/***************locking_pin***************/
}
{/***************distant and block signal***************/
}

{/***************drill_template_straight***************/

}

{/***************drill_template_curve***************/

}
{/***************drill_template_switch***************/
    // all needed values in "drill_template_curve" and "drill_template_straight"
}

{/***************magnet_rod***************/
}
{/***************direction_management***************/
}
{/***************number_plate***************/
}
{/***************balise***************/
}
{/***************train integrity***************/
}
{/***************switch locker***************/
}
{/***************route_indicator_straight***************/
}
{/***************route_indicator_curve***************/
}
