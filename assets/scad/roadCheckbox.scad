$fn = 200;
// body specifications
axis_diameter = 2.5; //maybe use the same material as lever anchor
body_width = 30; // material constraint
body_depth = 60;
body_height = 13.5; // material constraint
track_arc_inner_radius = 182;



body();
module body(){
    module box(){
        cube([body_width, body_depth, body_height]);
    }
    module round_edge(){
        cylinder(h=body_height, r=track_arc_inner_radius);
    }
    difference(){
        intersection(){
            intersection(){
                translate([0,0,0])box();
                translate([track_arc_inner_radius,body_depth/2,0])round_edge();
            }
            intersection(){
                translate([0,0,0])box();
                translate([body_width-track_arc_inner_radius,body_depth/2,0])round_edge();
            }
        }
        for (y=[12.5, 25, 37.5]){
            translate([body_width*(2/3),y,5])cylinder(d=3,h=body_height-5);
        }

    }
}