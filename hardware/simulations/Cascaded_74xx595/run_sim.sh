#!/bin/bash

# Define VHDL files and entity
VHDL_FILES=("IC_74xx595.vhd" "tb_cascaded_74xx595.vhd")
ENTITY_NAME="tb_cascaded_74xx595"
WAVE_FILE="tb_cascaded_74xx595.vcd"

# 1. Compile the VHDL files in the correct order
echo "Compiling VHDL files..."
ghdl -a --std=08 "${VHDL_FILES[@]}"

# 2. Elaborate the testbench design
echo "Elaborating design for entity: $ENTITY_NAME"
ghdl -e --std=08 $ENTITY_NAME

# 3. Run the simulation and generate a VCD file
echo "Running simulation..."
ghdl -r --std=08 $ENTITY_NAME --vcd=$WAVE_FILE

# 4. Remove unnecessary files
rm work-obj08.cf

# 5. Check if the waveform file exists and open it with GTKWave
echo "Checking for waveform file: $WAVE_FILE"
if [ -f "$WAVE_FILE" ]; then
    echo "Opening GTKWave..."
    gtkwave $WAVE_FILE
else
    echo "Error: Waveform file '$WAVE_FILE' not found."
fi
