// Copyright 2020 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.
    
$fn = 50;// number of fragments

//material
thinnest_layer     = 0.1;
sqeeze_tolerance   = 0.6;

//dimensions
coupling_radius    = 13/2;
coupling_depth     = 8;
coupling_curvature = 2;
coupling_cut_pos   = coupling_radius*1/2;
boogie_width       = 20;
thickness          = 1.5;
lipp_height        = 4;
lipp_width         = thickness - sqeeze_tolerance;
shield_thickness   = 2;
inlay_thickness    = 0.45;
inlay_radius       = 10.5/2;

union(){
    difference(){ // coupling
        // outer ring
        cylinder(h = coupling_depth, r = coupling_radius + sqeeze_tolerance/2 + thickness);
        // inner ring
        translate([0,0,-thickness/2]) cylinder(h = coupling_depth + thickness, r = coupling_radius + sqeeze_tolerance/2);
        // cutting the lower edge
        translate([-coupling_radius*1.3,coupling_cut_pos,-thickness/2]) cube([coupling_radius*2.6,coupling_radius*1.2,coupling_depth + thickness]);
    }

    union(){// upper board
        // beam
        translate([-boogie_width/2,-(coupling_radius + thickness + sqeeze_tolerance/2),0]) cube([boogie_width,thickness,coupling_depth]);
        // lipp
        hull(){
            translate([-boogie_width/2,-(coupling_radius + sqeeze_tolerance/2 + thickness - lipp_width),coupling_depth]) cube([boogie_width,thinnest_layer,lipp_height/4]);
            translate([-boogie_width/2,-(coupling_radius + sqeeze_tolerance/2 + thickness),coupling_depth]) cube([boogie_width,thinnest_layer,lipp_height]);
        }
    }

    difference(){// front shield
        union(){
            hull(){
                // plate - upper part
                translate([-boogie_width/2,-(coupling_radius + thickness + sqeeze_tolerance/2),-shield_thickness]) cube([boogie_width,thickness,shield_thickness]);
                // plate - lower part
                difference(){
                    translate([0,0,-shield_thickness]) cylinder(h = shield_thickness, r = coupling_radius + sqeeze_tolerance/2 + thickness);
                    translate([-coupling_radius*1.3,coupling_cut_pos,-shield_thickness]) cube([coupling_radius*2.6,coupling_radius*1.2,shield_thickness]);
                }
                translate([0,0,-shield_thickness]) cylinder(h = shield_thickness, r = coupling_radius + sqeeze_tolerance/2);
            }
        }
        // inlay
        translate([0,0,-inlay_thickness]) cylinder(h = inlay_thickness*1.1, r = inlay_radius);
    }
}