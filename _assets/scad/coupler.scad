// Copyright 2020 Martin Scheidt (Attribution 4.0 International, CC-BY 4.0)
//
// You are free to copy and redistribute the material in any medium or format.
// You are free to remix, transform, and build upon the material for any purpose, even commercially.
// You must give appropriate credit, provide a link to the license, and indicate if changes were made.
// You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
// No warranties are given.

include<./specification_of_components.scad>

$fn = 50;// number of fragments

//coupler("back");
train_tail_symbol();
//train_headlight_symbol();

//triangle();
//train_headlight_symbol();
//cube([shield_width, shield_depth, shield_thickness]);
module triangle(){
    cylinder_diameter = 0.1;
    hull(){
        translate([cylinder_diameter/2,cylinder_diameter/2,0])cylinder(d=cylinder_diameter, h=number_height);
        translate([cylinder_diameter/2, shield_depth-cylinder_diameter/2,0]) cylinder(d=cylinder_diameter, h=number_height);
        translate([(shield_width-cylinder_diameter)/2, (shield_depth-cylinder_diameter)/2,0])cylinder(d=cylinder_diameter, h=number_height);
    }
}

module train_headlight_symbol(){
    translate([-shield_width/2,-(shield_depth)/2-coupling_radius+1,-shield_thickness]) union(){
        translate([(1/12)*shield_width+headlight_d/2,(shield_depth+(1/6)*shield_width+headlight_d)/2,0]) cylinder(d= headlight_d, h=number_height);
        translate([(11/12)*shield_width-headlight_d/2,(shield_depth+(1/6)*shield_width+headlight_d)/2,0]) cylinder(d= headlight_d, h=number_height);
        translate([(1/2)*shield_width,(shield_depth-(1/6)*shield_width-headlight_d)/2,0]) cylinder(d= headlight_d, h=number_height);
    }

}

module train_tail_symbol(){
    translate([-shield_width/2,-(shield_depth)/2-coupling_radius+1,-shield_thickness]) triangle();
    translate([shield_width/2,-(shield_depth)/2-coupling_radius+1,-shield_thickness+number_height]) rotate([0,180,0]) triangle();
}



module coupler(position){
    difference(){ // coupling
        // outer ring
        cylinder(h = coupling_depth, r = coupling_radius + move_tolerance/2 + coupler_thickness);
        // inner ring
        translate([0,0,-coupler_thickness/2]) cylinder(h = coupling_depth + coupler_thickness, r = coupling_radius + move_tolerance/2);
        // cutting the lower edge
        translate([-coupling_radius*1.3,coupling_cut_pos,-coupler_thickness/2]) cube([coupling_radius*2.6,coupling_radius*1.2,coupling_depth + coupler_thickness]);
    }

    union(){// upper board
        // beam
        translate([-boogie_width/2,-(coupling_radius + coupler_thickness + move_tolerance/2),0]) cube([boogie_width,coupler_thickness,coupling_depth]);
        // lipp
        hull(){
            translate([-boogie_width/2,-(coupling_radius + move_tolerance/2 + coupler_thickness - lipp_width),coupling_depth]) cube([boogie_width,thinnest_layer,lipp_height/4]);
            translate([-boogie_width/2,-(coupling_radius + move_tolerance/2 + coupler_thickness),coupling_depth]) cube([boogie_width,thinnest_layer,lipp_height]);
        }
    }

    /* difference(){// old front shield
        union(){
            #hull(){
                // plate - upper part
                translate([-boogie_width/2,-(coupling_radius + coupler_thickness + move_tolerance/2),-shield_thickness]) cube([boogie_width,coupler_thickness,shield_thickness]);
                // plate - lower part
                difference(){
                    translate([0,0,-shield_thickness]) cylinder(h = shield_thickness, r = coupling_radius + move_tolerance/2 + coupler_thickness);
                    translate([-coupling_radius*1.3,coupling_cut_pos,-shield_thickness]) cube([coupling_radius*2.6,coupling_radius*1.2,shield_thickness]);
                }
                translate([0,0,-shield_thickness]) cylinder(h = shield_thickness, r = coupling_radius + move_tolerance/2);
            }
        }
        // inlay
        #translate([0,0,-inlay_thickness]) cylinder(h = inlay_thickness*1.1, r = inlay_radius);
    } */

    difference(){ // new front shield
        translate([-shield_width/2,-(shield_depth)/2-coupling_radius+1,-shield_thickness]) cube([shield_width, shield_depth, shield_thickness]);
        translate([0,0,-inlay_thickness]) cylinder(h = inlay_thickness*1.1, r = inlay_radius);
        if (position == "back"){
            train_tail_symbol();
        }
        if (position == "front"){
           train_headlight_symbol(); 
        }
    }
}