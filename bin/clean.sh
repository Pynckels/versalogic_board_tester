#! /usr/bin/env bash
set -euo pipefail

# Determine hardware directory relative to this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HARDWARE_DIR="$SCRIPT_DIR/../hardware"
SOFTWARE_DIR="$SCRIPT_DIR/../software"
ORIGINAL_DIR=$(pwd)

echo "Cleanup: $HARDWARE_DIR"

# Find all directories ending with -backups anywhere under hardware
find "$HARDWARE_DIR" -type d -name "*-backups" | while read -r backup_dir; do
    parent_dir="$(dirname "$backup_dir")"
    backup_basename="$(basename "$backup_dir")"

    # Remove the trailing '-backups' to get the base project name
    proj_name="${backup_basename%-backups}"
    kicad_pro_file="$parent_dir/${proj_name}.kicad_pro"

    if [ -f "$kicad_pro_file" ]; then
        echo "Removing backup directory: $backup_dir (found $proj_name.kicad_pro)"
        rm -rf "$backup_dir"
    else
        echo "Skipping $backup_dir: no matching $proj_name.kicad_pro file in $parent_dir"
    fi
done

echo "Cleanup: $SOFTWARE_DIR"

cd "$SOFTWARE_DIR/design"
make clean > /dev/null
cd "$ORIGINAL_DIR"

echo "Cleanup complete."
