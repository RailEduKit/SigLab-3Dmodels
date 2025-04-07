frame_width = 180
frame_depth = 180
rail_well_spacing = 19.25
np_diameter = rail_well_spacing-2*3



#= step_size = np_diameter+2*move_tolerance
x_start = -(frame_width/2-np_diameter/2-1)
y_start = -(frame_depth/2-np_diameter/2-1) =#
numeration_start = 0
numeration_end = 59
numeration_length = 60
counter = 1

for i in 0:11
    for j in 0:(60/12)-1
        print(counter, ", ")
        global counter += 1
    end
    println()
end