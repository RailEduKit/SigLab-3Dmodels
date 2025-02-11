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
- standardisation of move tolerance
- standard on which part the move tolerance is substracted?
******/

//wood rail specification
wood_thickness_middle = 11.5;
wood_thickness_rail = 5.5;

straight_length = 144.5;

curve_radius = 182; // inner radius
curve_angle = 45; // degree

/*********
switch_blade_optimized
***********/

//blade specification
blade_thickness = 2.5;
blade_cover_thicknes = 0.6; //attention: female blade is thinner -> effect on lever_anchor pins?
blade_length = 45;
blade_width  = 19;

//lever anchor specification
lever_hole_size = 2.7;
lever_anchor_posX = blade_width*1/5;
lever_anchor_posY = blade_length*0.8111;

//pin specification
pin_diameter = 5;
pin_female_diameter = pin_diameter+1.5;
pin_height = wood_thickness_rail+2; //2mm move tolerance
y_pos_first_pin = pin_diameter;
y_pos_second_pin = (blade_length*2/3);
overlap = blade_thickness-blade_cover_thicknes; // height of pin_hole, otherwise the pin_hole doesn't stand on the blade -> bug?

/**********************
overlap_measure
*******************/

