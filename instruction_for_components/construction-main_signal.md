+++
title = "SigLab main signal"
+++

# Instruction Main Signal

The main signal consists of two parts - color\_block and signal\_body, which are connected with a brass rod. 
The signal term can be changed by flipping the color\_block. The red signal term can be locked with a [Locking Pin](/instruction_for_components/construction-locking_pin/).
The magnets on the side attach the signal to the track. The body has magnets on both sides to attach several components at one place.

~~~<div class="grid-container">~~~
\figenv{all parts}{/assets/images/test_picture-main_signal.png}{width:50%}
\figenv{free ride}{/assets/images/test_picture-main_signal.png}{width:50%}
\figenv{stop}{/assets/images/test_picture-main_signal.png}{width:50%}
\figenv{stop locked}{/assets/images/test_picture-main_signal.png}{width:50%}
~~~</div>~~~

## Material
- PLA red
- PLA green
- PLA black
- Superglue (transparent)
- brass rod (&#8960; = 2 mm; l = 29 mm)
- neodym magnets (&#8960; = 5 mm; h = 3 mm)
- [magnet rod](/instruction_for_components/construction-magnet_rod)
- color\_block-main.stl ([Github](https://github.com/RailEduKit/InteractiveSignallingLaboratory-construction/tree/26da9a3ef2bb5dd24fbcce4d757b15be189f7ef6/_assets) | [direct download](/assets/stl-files/color_block-main.stl))
- signal\_body-main.stl ([Github](https://github.com/RailEduKit/InteractiveSignallingLaboratory-construction/tree/26da9a3ef2bb5dd24fbcce4d757b15be189f7ef6/_assets) | [direct download](/assets/stl-files/color_block-main.stl))

## Production Steps

Each set of the BRIOgame needs 10 main signals. Each part has to be printed separate from one another. It is recommended to print several pieces of one part at the same time.

### Color Block 3D Print

1. Open color\_block-main.stl in a Slicing-Software of your choice (e.g. Bambu Studio).
1. Dye the color block as shown abov. The middle has to be black, the bottom third green and the top third red. 
    > **Note**: There are to fine lines at one side. These lines divide the block in three parts. Red and green shouldn't cross these lines. Otherwise there would be one PLA switch to often.
    
    > This [instruction](/instruction_for_components/dye-instruction/) schows how to dye components layer by layer in Bambu Studio.
1. Copy the colored color block as often as you want to print it.
1. Enable support.
1. Change all other parameters, as you like.
1. Prepare your printer for a multicolor print.
1. Start printing.

### Signal Body 3D Print

1. Open signal\_body-main.stl in a Slicing-Software of your choice (e.g. Bambu Studio).
1. Dye the signal body black
1. Copy the black signal body as often as you want to print it.
1. Enable support if needed.
1. Change all other parameters, as you like.
1. Start printing.

### Assemble Parts

1. Saw the brass rod
1. Lay the color block in the signal body. Here, the right alignment is important:
    1. Red at the top &rarr; The hole in the ground has to be under the handle.
    1. Green at the top &rarr; The pin has to go through the handle.
1. Stick the brass rod through the axis holes of the signal body and the color block. The brass rod sits tight in the hole of the signal body, so that nothing has to be glued. 

