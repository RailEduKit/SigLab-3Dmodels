// Include external libraries
include <BOSL2/std.scad> // Import std from dependency BelfrySCAD/BOSL2.git
include <BOSL2/joiners.scad> // Import joiners from dependency BelfrySCAD/BOSL2.git

include <config/global_variables.scad>

use <assemblies/overlap_pattern_straight.scad>
use <assemblies/overlap_body_straight.scad>
use <assemblies/overlap_body_curve.scad>
include <parts/track_indicator_curve.scad> // access variables
include <parts/track_indicator_straight.scad> // access variables



module pattern_rot(){
    left(600) union(){
        up(om_thickness/2) fwd(straight_length)  union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        left(ric_inner_radius + ris_width/2) overlap_body_curve_rot();
    }

    left(500) union(){
        up(om_thickness/2) fwd(straight_length)  union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle)  overlap_body_curve_rot();
    }

    left(300) union(){
        left(ric_inner_radius + ris_width/2) overlap_body_curve_rot();
        right(ric_inner_radius + ris_width/2) zrot(180) overlap_body_curve_rot();
    }

    left(100) union(){
        left(ric_inner_radius + ris_width/2) zrot(-curve_angle) overlap_body_curve_rot();
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle) overlap_body_curve_rot();
    }


    right(100) union(){
        left(ric_inner_radius + ris_width/2) zrot(-curve_angle) overlap_body_curve_rot();
        left(ric_inner_radius + ris_width/2) zrot(0) overlap_body_curve_rot();
    }

    right(200) union(){
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle) overlap_body_curve_rot();
        right(ric_inner_radius + ris_width/2) zrot(180) overlap_body_curve_rot();
    }

    right(350) union(){
        union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        fwd(ris_length) union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
    }
    right(450) union(){
        union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        zrot(180) union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
    }
}


module pattern_onedirect(){
    left(600) union(){
        up(om_thickness/2) fwd(straight_length)  union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        left(ric_inner_radius + ris_width/2) overlap_body_curve_onedirect();
    }

    left(500) union(){
        up(om_thickness/2) fwd(straight_length)  union(){
            overlap_body_straight();
            overlap_pattern_straight();
        }
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle)  overlap_body_curve_onedirect();
    }

    left(300) union(){
        left(ric_inner_radius + ris_width/2) overlap_body_curve_onedirect();
        right(ric_inner_radius + ris_width/2) zrot(180) overlap_body_curve_onedirect();
    }

    left(100) union(){
        left(ric_inner_radius + ris_width/2) zrot(-curve_angle) overlap_body_curve_onedirect();
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle) overlap_body_curve_onedirect();
    }


    right(100) union(){
        left(ric_inner_radius + ris_width/2) zrot(-curve_angle) overlap_body_curve_onedirect();
        left(ric_inner_radius + ris_width/2) zrot(0) overlap_body_curve_onedirect();
    }

    right(200) union(){
        right(ric_inner_radius + ris_width/2) zrot(180-curve_angle) overlap_body_curve_onedirect();
        right(ric_inner_radius + ris_width/2) zrot(180) overlap_body_curve_onedirect();
    }
}

pattern_rot();
fwd(400) pattern_onedirect();




/* fwd(straight_length)
right(ric_inner_radius + ris_width/2) 
zrot(180) 
overlap_body_curve_rot(); */
//fwd(straight_length) overlap_straight();

