#!/usr/bin/env sh

# ===== Default Values =====

# Directory and file settings
INPUT_DIR="../scad/views"
OUTPUT_DIR="../images/renders"
LOG_FILE="render.log"
SINGLE_FILE=""

# Image settings
IMG_WIDTH=8192
IMG_HEIGHT=8192
BLACKLIST="template.scad,config.scad"
FORCE=false

# ImageMagick settings
MAGICK_ENABLED=true
MAGICK_TRANSPARENT_COLOR="#ffffe5"
MAGICK_TRIM=true

# Define views (output_name, translation x,y,z, rotation x,y,z, distance)
VIEWS=(
    "front,0,0,0,35.264,45,0,1"     # Standard isometric view (35.264° = arctan(1/sqrt(2)))
    "back,0,0,0,35.264,-45,0,1"     # Opposite isometric view
    "top,0,0,0,90,0,0,1"            # Top view
    "bottom,0,0,0,-90,0,0,1"        # Bottom view
)

# ===== Initialization Functions =====

# Function to check if OpenSCAD is installed
check_openscad() {
    if ! command -v openscad >/dev/null 2>&1; then
        log "error" "OpenSCAD is not installed or not found in PATH"
        exit 1
    fi
}

# Function to check if ImageMagick is installed
check_imagemagick() {
    if ! command -v magick >/dev/null 2>&1; then
        log "error" "ImageMagick is not installed or not found in PATH"
        exit 1
    fi
}

# Function to check OpenSCAD version
get_openscad_version() {
    local version=$(openscad --version 2>&1)
    case "$version" in
        *"OpenSCAD version 2025"*) echo "2025" ;;
        *"OpenSCAD version 2021"*) echo "2021" ;;
        *"OpenSCAD version 2019"*) echo "2019" ;;
        *) echo "unknown" ;;
    esac
}

# Function to get ImageMagick version
get_imagemagick_version() {
    local version=$(magick --version 2>&1)
    case "$version" in
        *"ImageMagick 7"*) echo "7" ;;
        *"ImageMagick 6"*) echo "6" ;;
        *) echo "unknown" ;;
    esac
}

# ===== Utility Functions =====

# Function to log messages
log() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local level="$1"
    local message="$2"
    
    if [ "$level" = "error" ]; then
        echo "[$timestamp] ERROR: $message" | tee -a "$LOG_FILE" >&2
    else
        echo "[$timestamp] $message" >> "$LOG_FILE"
    fi
}

# Function to show progress
progress() {
    printf "\r\033[K%s" "$1"
    [ "$2" = "final" ] && echo
}

# Function to check if a file is blacklisted
is_blacklisted() {
    local filename="$1"
    local IFS=','
    for blacklisted in $BLACKLIST; do
        [ "$filename" = "$blacklisted" ] && return 0
    done
    return 1
}

# Function to show help message
show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [INPUT]

Options:
    -h, --help                 Show this help message
    -o, --output_dir DIR       Directory for rendered PNG files (default: _assets/renderings)
    -w, --img-width WIDTH      Width of rendered images (default: 8192)
    -H, --img-height HEIGHT    Height of rendered images (default: 8192)
    -b, --blacklist LIST       Comma-separated list of SCAD files to exclude
    -f, --force                Force rebuild all renderings regardless of modification time
    
    ImageMagick Options:
    --no-magick                Disable ImageMagick processing (use raw OpenSCAD output)
    --transparent-color COLOR  Color to make transparent (default: #ffffe5)
    --no-trim                  Disable automatic trimming of transparent edges

Arguments:
    INPUT                      Directory containing SCAD files or a single SCAD file
                               (default: _assets/scad)
EOF
    exit 0
}

# Function to parse command line arguments
parse_arguments() {
    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                show_help
                ;;
            --output_dir|-o)
                [ -z "$2" ] && log "error" "Directory path required for -o/--output_dir option" && exit 1
                OUTPUT_DIR="$2"
                shift 2
                ;;
            --img-width|-w)
                ! [ "$2" -eq "$2" ] 2>/dev/null && log "error" "--img-width requires a number" && exit 1
                IMG_WIDTH="$2"
                shift 2
                ;;
            --img-height|-H)
                ! [ "$2" -eq "$2" ] 2>/dev/null && log "error" "--img-height requires a number" && exit 1
                IMG_HEIGHT="$2"
                shift 2
                ;;
            --blacklist|-b)
                [ -z "$2" ] && log "error" "--blacklist requires a comma-separated list" && exit 1
                BLACKLIST="$2"
                shift 2
                ;;
            --force|-f)
                FORCE=true
                shift
                ;;
            --no-magick)
                MAGICK_ENABLED=false
                shift
                ;;
            --transparent-color)
                [ -z "$2" ] && log "error" "--transparent-color requires a color value" && exit 1
                MAGICK_TRANSPARENT_COLOR="$2"
                shift 2
                ;;
            --no-trim)
                MAGICK_TRIM=false
                shift
                ;;
            *)
                if [ -f "$1" ] && [ "${1##*.}" = "scad" ]; then
                    SINGLE_FILE="$1"
                    INPUT_DIR=$(dirname "$1")
                elif [ -d "$1" ]; then
                    INPUT_DIR="$1"
                else
                    log "error" "Invalid input: $1 (must be a directory or .scad file)"
                    exit 1
                fi
                shift
                ;;
        esac
    done
}

# ===== Main Functions =====

# Function to construct ImageMagick command
construct_magick_command() {
    local input_file="$1"
    local output_file="$2"
    local version=$(get_imagemagick_version)
    local cmd="magick"
    
    # Base command with common parameters
    cmd="$cmd \"$input_file\""
    
    # Add version-specific parameters
    if [ "$version" = "7" ]; then
        # For ImageMagick 7, use alpha set and transparent
        cmd="$cmd -alpha set -background none"
        cmd="$cmd -transparent \"$MAGICK_TRANSPARENT_COLOR\""
        [ "$MAGICK_TRIM" = true ] && cmd="$cmd -trim"
    else
        # For ImageMagick 6, use transparent directly
        cmd="$cmd -background none"
        cmd="$cmd -transparent \"$MAGICK_TRANSPARENT_COLOR\""
        [ "$MAGICK_TRIM" = true ] && cmd="$cmd -trim"
    fi
    
    # Add anti-aliasing using Lanczos filter
    cmd="$cmd -filter Lanczos -resize 100%"
    
    # Add optimization parameters
    cmd="$cmd -define png:compression-level=9"
    cmd="$cmd -define png:compression-strategy=0"
    cmd="$cmd -define png:exclude-chunk=all"
    cmd="$cmd -define png:compression-filter=5"
    cmd="$cmd -define png:compression-strategy=1"
    cmd="$cmd -define png:compression-method=0"
    cmd="$cmd -define png:color-type=6"
    cmd="$cmd -define png:bit-depth=8"
    
    # Add output file
    cmd="$cmd \"$output_file\""
    
    echo "$cmd"
}

# Function to optimize image with ImageMagick
optimize_image() {
    local input_file="$1"
    local output_file="$2"
    
    # Skip ImageMagick processing if disabled
    if [ "$MAGICK_ENABLED" = false ]; then
        mv "$input_file" "$output_file"
        return 0
    fi
    
    log "info" "Optimizing image: $input_file"
    
    # Construct and execute command
    local cmd=$(construct_magick_command "$input_file" "$output_file")
    log "info" "Executing: $cmd"
    
    local output
    output=$(eval "$cmd" 2>&1)
    local status=$?
    
    echo "$output" >> "$LOG_FILE"
    
    if [ $status -eq 0 ]; then
        log "info" "Image optimized successfully"
        return 0
    else
        log "error" "Failed to optimize image: $output"
        return 1
    fi
}

# Function to construct OpenSCAD command
construct_openscad_command() {
    local input_file="$1"
    local output_file="$2"
    local camera_params="$3"
    local version=$(get_openscad_version)
    local cmd="openscad"
    
    # Base command with common parameters
    cmd="$cmd --o \"$output_file\""
    cmd="$cmd --render"
    cmd="$cmd --imgsize \"$IMG_WIDTH,$IMG_HEIGHT\""
    cmd="$cmd --export-format png"
    
    # Add version-specific parameters
    if [ "$version" = "2021" ] || [ "$version" = "2019" ]; then
        cmd="$cmd --camera=$camera_params"
        cmd="$cmd --viewall"
        cmd="$cmd --autocenter"
    else
        cmd="$cmd --backend Manifold"
        cmd="$cmd --camera=$camera_params"
        cmd="$cmd --viewall"
        cmd="$cmd --autocenter"
        cmd="$cmd --summary all"
    fi
    
    # Add input file
    cmd="$cmd \"$input_file\""
    
    echo "$cmd"
}

# Function to render a single SCAD file
render_file() {
    local input_file="$1"
    local base_name=$(basename "$input_file" .scad)
    
    # Skip if file is blacklisted
    if is_blacklisted "$(basename "$input_file")"; then
        log "info" "Skipping blacklisted file: $input_file"
        progress "Skipping blacklisted file: $(basename "$input_file")" "final"
        return 0
    fi
    
    # Check if we need to render
    local needs_rendering=false
    for view in "${VIEWS[@]}"; do
        IFS=',' read -r -a view_params <<< "$view"
        local view_name="${view_params[0]}"  # Get output name
        local output_file="$OUTPUT_DIR/${base_name}_${view_name}.png"
        if [ "$FORCE" = true ] || [ ! -f "$output_file" ] || [ "$(stat -f %m "$input_file")" -gt "$(stat -f %m "$output_file")" ]; then
            needs_rendering=true
            break
        fi
    done
    
    if [ "$needs_rendering" = false ]; then
        log "info" "Skipping $input_file - no changes detected"
        progress "Skipping $(basename "$input_file") - no changes" "final"
        return 0
    fi
    
    log "info" "=== Starting render of $input_file ==="
    progress "Rendering $(basename "$input_file")..."
    
    # Render each view
    local success=true
    
    for view in "${VIEWS[@]}"; do
        IFS=',' read -r -a view_params <<< "$view"
        local view_name="${view_params[0]}"  # Get output name
        local camera_params="${view_params[1]},${view_params[2]},${view_params[3]},${view_params[4]},${view_params[5]},${view_params[6]},${view_params[7]}"
        local temp_file="$OUTPUT_DIR/${base_name}_${view_name}_temp.png"
        local output_file="$OUTPUT_DIR/${base_name}_${view_name}.png"
        
        # Skip if file exists and no force flag
        if [ "$FORCE" = false ] && [ -f "$output_file" ] && [ "$(stat -f %m "$input_file")" -le "$(stat -f %m "$output_file")" ]; then
            continue
        fi
        
        log "info" "--- Rendering view: $view_name ---"
        progress "Rendering $(basename "$input_file") (view: $view_name)..."
        
        # Construct and execute command
        local cmd=$(construct_openscad_command "$input_file" "$temp_file" "$camera_params")
        log "info" "Executing: $cmd"
        
        local output
        output=$(eval "$cmd" 2>&1)
        local status=$?
        
        echo "$output" >> "$LOG_FILE"
        
        if [ $status -ne 0 ]; then
            echo "$output" >&2
            success=false
            break
        fi
        
        # Optimize the rendered image
        if ! optimize_image "$temp_file" "$output_file"; then
            success=false
            break
        fi
        
        # Remove temporary file
        rm "$temp_file"
    done
    
    if [ "$success" = true ]; then
        log "info" "=== Finished render of $input_file (Status: Success) ==="
        progress "✓ $(basename "$input_file")" "final"
        return 0
    else
        log "info" "=== Finished render of $input_file (Status: Failed) ==="
        progress "✗ $(basename "$input_file")" "final"
        return 1
    fi
}

# Main function
main() {
    # Initialize environment
    check_openscad
    check_imagemagick
    
    # Parse command line arguments
    parse_arguments "$@"
    
    # Create output directory
    mkdir -p "$OUTPUT_DIR"
    
    # Initialize log file
    echo "=== New render session started at $(date '+%Y-%m-%d %H:%M:%S') ===" > "$LOG_FILE"
    log "info" "Input directory: $INPUT_DIR"
    log "info" "Output directory: $OUTPUT_DIR"
    log "info" "Image size: ${IMG_WIDTH}x${IMG_HEIGHT}"
    
    progress "Starting render session..." "final"
    
    # Process files
    if [ -n "$SINGLE_FILE" ]; then
        # Single file mode
        if [ -f "$SINGLE_FILE" ] && [ "${SINGLE_FILE##*.}" = "scad" ]; then
            render_file "$SINGLE_FILE"
        fi
    else
        # Directory mode
        for scad_file in "$INPUT_DIR"/*.scad; do
            [ -f "$scad_file" ] || continue
            render_file "$scad_file"
        done
    fi
    
    log "info" "=== Render session completed ==="
    progress "Render session completed" "final"
}

# Run the script
main "$@" 