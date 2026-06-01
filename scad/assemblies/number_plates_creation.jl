frame_width = 180
frame_depth = 180
rail_well_spacing = 19.25
np_diameter = rail_well_spacing-2*3



#= step_size = np_diameter+2*move_tolerance
x_start = -(frame_width/2-np_diameter/2-1)
y_start = -(frame_depth/2-np_diameter/2-1) =#

rows = 4
numeration_start = 0
numeration_end = 55
numeration_length = 60
counter = 0
count_step = 5

# Open (or create) the file in write mode ("w") and write all lines in one go
open("./number_plate_code_for_scad.txt", "w") do file
    for i in 0:rows -1
        for j in 0:((numeration_length/count_step)/rows)-1
            # Create a string with variable values using interpolation (with $)
            line = "translate([x_start()+$i*step_size(),y_start()+$j*step_size(),0])number_plate($counter);\n"
            write(file, line)        
            print(counter, ", ")
            global counter += count_step
        end
        println()
    end
    write(file, "\n")
    global counter = 0
    println("counter: ", counter)
    for i in 0:rows -1
        for j in 0:((numeration_length/count_step)/rows)-1
            # Create a string with variable values using interpolation (with $)
            line = "translate([x_start()+$i*step_size(),y_start()+$j*step_size(),0])piece_number($counter);\n"
            write(file, line)        
            print(counter, ", ")
            global counter += count_step
        end
        println()
    end
end