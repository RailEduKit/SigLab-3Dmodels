#!/usr/bin/env sh

# Default list of repositories to install
DEFAULT_REPOS=(
    "https://github.com/BelfrySCAD/BOSL2.git"
    "https://github.com/dotscad/trains.git"
)

# Show help message
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Install or update SCAD dependencies."
    echo
    echo "Options:"
    echo "  -h, --help              Show this help message"
    echo "  -d, --directory DIR     Target directory for dependencies"
    echo "                          If not specified, uses './lib' in current directory"
    echo "  -f, --file FILE         Read repository URLs from file (one URL per line)"
    echo "                          If not specified, uses default repositories"
    echo
    echo "Example:"
    echo "  $0                      # Install default repos in ./lib"
    echo "  $0 -d /path/to/deps     # Install in specified directory"
    echo "  $0 -f repos.txt         # Install repos listed in repos.txt"
    echo "  $0 -d /path/to/deps -f repos.txt  # Install repos from file in specified directory"
}

# Default target directory
TARGET_DIR="$(pwd)/lib"
REPO_FILE=""

# Parse command line arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--directory)
            if [ -z "$2" ]; then
                echo "Error: Directory path required for -d/--directory option"
                exit 1
            fi
            TARGET_DIR="$2"
            shift 2
            ;;
        -f|--file)
            if [ -z "$2" ]; then
                echo "Error: File path required for -f/--file option"
                exit 1
            fi
            REPO_FILE="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check if git is available
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed or not in PATH"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Function to clone or update repository
install_or_update() {
    repo_url=$1
    repo_name=$(basename "$repo_url" .git)
    
    if [ -d "$TARGET_DIR/$repo_name" ]; then
        echo "Repository $repo_name exists, updating..."
        cd "$TARGET_DIR/$repo_name"
        git fetch --depth 1
        git reset --hard origin/HEAD
        cd "$TARGET_DIR"
    else
        echo "Cloning $repo_name..."
        git clone --single-branch --depth 1 "$repo_url" "$TARGET_DIR/$repo_name"
    fi
}

# Get repositories from file or use defaults
if [ -n "$REPO_FILE" ]; then
    if [ ! -f "$REPO_FILE" ]; then
        echo "Error: Repository file '$REPO_FILE' not found"
        exit 1
    fi
    echo "Reading repositories from $REPO_FILE"
    # Read file line by line, skipping empty lines and comments
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip empty lines and comments
        case "$line" in
            ""|\#*) continue ;;
            *) REPOS+=("$line") ;;
        esac
    done < "$REPO_FILE"
else
    REPOS=("${DEFAULT_REPOS[@]}")
fi

# Install or update all repositories
for repo in "${REPOS[@]}"; do
    install_or_update "$repo"
done

echo "Dependencies updated successfully in $TARGET_DIR!" 