# InteractiveSignallingLaboratory - 3Dmodels

## About

The 3D model repository serves as the primary source for all 3D-printable components of the Interactive Signalling Laboratory. The components are created in OpenSCAD. OpenSCAD is a script-based 3D CAD modeler used to create precise 3D models for manufacturing and prototyping.

### Structure

The repository is organized into several key components:

```
InteractiveSignallingLaboratory-scad/
├── README.md                    # Overview and printing instructions
├── scad/
│   ├── config/                  # Configuration files
│   │   ├── global_variables.scad    # Global variables
│   │   └── colors.scad              # Color definitions for views
│   │
│   ├── components/             # Reusable components
│   │
│   ├── parts/                  # Main models
│   │
│   └── views/                  # Various views
│
├── stl-files/                  # Generated STL files
│
├── images/                     # Rendered images and photos
│   ├── renders/                # OpenSCAD renders
│   └── photos/                 # Photos of printed parts
│
├── documentation/              # Technical documentation
│   ├── assembly_guide.md       # Assembly instructions
│   ├── print_settings.md       # Print settings
│   └── materials.md            # Material recommendations
│
└── scripts/                    # Build automation
    ├── build_stl.sh            # Generate all STL files
    ├── render_images.sh        # Render all images
    └── install_dependencies.sh # Model validation
```

1. **Core Components**
   - `config/` - Configuration files containing global parameters and settings
   - `components/` - Reusable component library
   - `parts/` - Main model components

2. **Track Components**
   - `track_straight.scad` - Straight track segment design
   - `track_curve.scad` - Curved track segment design
   - `switch_body.scad` - Switch mechanism body
   - `switch_blade.scad` - Switch blade components
   - `direction_management.scad` - Direction control mechanisms
   - `overlap_measure.scad` - Overlap measurement components

3. **Signalling Components**
   - `signal_distant.scad` - Distant signal designs
   - `signal_block.scad` - Block signal components
   - `signal_route.scad` - Route signal components
   - `balise.scad` - Balise (track-side beacon) components
   - `clearing_point.scad` - Clearing point indicators
   - `train_integrity.scad` - Train integrity components

4. **Supporting Components**
   - `number_plate.scad` - Number plate generation
   - `magnet_rod.scad` - Magnetic components
   - `locking_pin.scad` - Locking mechanism components

5. **Templates and Tools**
   - `drill_template_straight.scad` - Drilling templates for straight tracks
   - `drill_template_curve.scad` - Drilling templates for curved tracks
   - `drill_template_switch.scad` - Drilling templates for switches

6. **Testing and Development**
   - `test_code.scad` - General testing file
   - `test_magnets.scad` - Magnet component testing
   - `test_pins.scad` - Pin component testing

## config

The `config/global_variables.scad` file serves as the central configuration file for the entire project. It contains all the essential parameters and measurements needed for the various components of the Interactive Signalling Laboratory.

### Key Attributes

1. **Global Parameters**
   - Resolution settings for 3D printing (`$fn`, `$fa`, `$fs`)
   - General move tolerance for component fitting (`move_tolerance`)
   - Copyright and licensing information

2. **Track Specifications**
   - Rail dimensions (height, width, thickness)
   - Track well specifications
   - Straight track length
   - Curve parameters (radius, angles)

3. **Component Specifications**
   - Magnet specifications (thickness, diameter, positioning)
   - Engraving parameters (height, thickness, line weights)
   - Basis component dimensions
   - Overlap measure specifications
   - Switch blade and body parameters
   - Signal and clearing point dimensions
   - Drill template measurements
   - Number plate and balise specifications

### Important Notes

- All measurements are in millimeters
- Parameters are organized by component type
- The file includes detailed comments for each section
- Some parameters are calculated based on other values to maintain consistency

## dependencies

This project requires several OpenSCAD libraries to render the models correctly. The dependencies can be installed automatically using the provided `scripts/install_dependencies.sh` script or manually following the instructions below.

### Official OpenSCAD Library Installation

For general information about installing OpenSCAD libraries, please refer to the official documentation:
- [OpenSCAD User Manual - Libraries](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries)
- [OpenSCAD Libraries Directory](https://openscad.org/libraries.html)

The official OpenSCAD library path can be found by running:
```bash
openscad --info
```

### Required Libraries

1. **BOSL2 (Belfry OpenSCAD Library)**
   - Repository: https://github.com/BelfrySCAD/BOSL2
   - Required for: Connector/joiner functionality
   - Documentation: 
     - Installation: https://github.com/BelfrySCAD/BOSL2/wiki#installation
     - Joiners: https://github.com/BelfrySCAD/BOSL2/wiki/joiners.scad

2. **dotscad/trains**
   - Repository: https://github.com/dotscad/trains
   - Required for: Track library functionality
   - Dependencies: Requires the dotscad base library

3. **dotscad (Base Library)**
   - Repository: https://github.com/dotscad/dotscad
   - Required for: Supporting the trains library

### Installation Methods

#### Automatic Installation (Recommended)

The `scripts/install_dependencies.sh` script provides an automated way to install all required dependencies. It will:
- Check for required tools (OpenSCAD and git)
- Determine the OpenSCAD library path
- Install/update all required repositories

To use the script:
```bash
# Basic usage (installs to OpenSCAD library path)
./scripts/install_dependencies.sh

# Install to a specific directory
./scripts/install_dependencies.sh -d /path/to/directory

# Install from a custom repository list
./scripts/install_dependencies.sh -f repositories.txt

# Show help
./scripts/install_dependencies.sh --help
```

#### Manual Installation

If you prefer to install manually:

1. Clone BOSL2:
   ```bash
   git clone https://github.com/BelfrySCAD/BOSL2.git
   ```

2. Clone dotscad base library:
   ```bash
   git clone https://github.com/dotscad/dotscad.git
   ```

3. Clone dotscad/trains:
   ```bash
   git clone https://github.com/dotscad/trains.git
   ```

Place all cloned repositories in your OpenSCAD library path or in the same directory as your SCAD files.

### System Requirements

- OpenSCAD installed and available in PATH
- Git installed and available in PATH
- Unix-like operating system (OS X, BSD, Linux) for the installation script
