#! /usr/bin/env bash

outfile="VersaLogic_Board_Tester.pdf"

echo "Creating $outfile"

# Determine hardware directory relative to this script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
hardware_dir="$script_dir/../hardware"
project_dir="$script_dir/.."
tmp_dir="$script_dir/../tmp"

# Create directories, files and variables
mkdir -p tmp

tmp1=$tmp_dir/$(mktemp -u XXXXXX.pdf)
tmp2=$tmp_dir/$(mktemp -u XXXXXX.pdf)

a4_pages_land=()
a4_pages_port=()
a5_pages_land=()
a5_pages_port=()


# Convert README.md to pdf
pandoc -t pdf -V papersize:a4 -o $tmp_dir/README.pdf  -f markdown $project_dir/README.md

# Convert LICENSE to pdf
pandoc -t pdf -V papersize:a4 -o $tmp_dir/LICENSE.pdf -f markdown $project_dir/LICENSE.md

# Print KiCad schematics to pdf
kicad-cli sch export pdf                                    \
    --output $tmp1                                          \
    --pages 1,2,3,4,5,6,7,8,9,10,11,48                      \
    --exclude-pdf-property-popups                           \
    --exclude-pdf-hierarchical-links                        \
    --exclude-pdf-metadata                                  \
    $hardware_dir/design/VersaLogic_Board_Tester.kicad_sch  \
    > /dev/null

# Clean KiCad schematics pdf (erase table of contents)
qpdf --empty --pages $tmp1 -- $tmp2

# Get page sizes and record which pages are A4 or A5
page_count=$(pdfinfo "$tmp2" | grep "Pages:" | awk '{print $2}')

for ((i=1; i<=page_count; i++)); do
    size_line=$(pdfinfo -f $i -l $i $tmp2 | grep -E "^Page[[:space:]]+$i[[:space:]]+size:")

    # Extract width and height in pts
    width=$(echo "$size_line" | awk '{print $4}')
    height=$(echo "$size_line" | awk '{print $6}')

    # A4 is ~595 x 842 pts, A5 is ~420 x 595 pts (approximately)
    # Use bc for floating-point comparisons
    is_a4_land=$(echo "$width >= 830 && $width <= 860 && $height >= 580 && $height <= 610" | bc)
    is_a4_port=$(echo "$width >= 580 && $width <= 610 && $height >= 830 && $height <= 860" | bc)
    is_a5_land=$(echo "$width >= 580 && $width <= 610 && $height >= 410 && $height <= 430" | bc)
    is_a5_port=$(echo "$width >= 410 && $width <= 430 && $height >= 580 && $height <= 610" | bc)

    if [[ "$is_a4_land" -eq 1 ]]; then
        a4_pages_land+=($i)
    elif [[ "$is_a4_port" -eq 1 ]]; then
        a4_pages_port+=($i)
    elif [[ "$is_a5_land" -eq 1 ]]; then
        a5_pages_land+=($i)
    elif [[ "$is_a5_port" -eq 1 ]]; then
        a5_pages_port+=($i)
    else
        echo "ERROR - Page size"
    fi
done

# Extract A4 landscape pages
if [ ${#a4_pages_land[@]} -gt 0 ]; then
    pages=$(IFS=,; echo "${a4_pages_land[*]}")
    qpdf "$tmp2" --pages "$tmp2" $pages -- $tmp_dir/a4_land.pdf
fi

# Extract A4 portrait pages
if [ ${#a4_pages_port[@]} -gt 0 ]; then
    pages=$(IFS=,; echo "${a4_pages_port[*]}")
    qpdf "$tmp2" --pages "$tmp2" $pages -- $tmp_dir/a4_port.pdf
fi


# Extract A5 landscape pages
if [ ${#a5_pages_land[@]} -gt 0 ]; then
    pages=$(IFS=,; echo "${a5_pages_land[*]}")
    qpdf "$tmp2" --pages "$tmp2" $pages -- $tmp_dir/a5_land.pdf
fi

# Extract A5 portrait pages
if [ ${#a5_pages_port[@]} -gt 0 ]; then
    pages=$(IFS=,; echo "${a5_pages_port[*]}")
    qpdf "$tmp2" --pages "$tmp2" $pages -- $tmp_dir/a5_port.pdf
fi

# Group A5 landscape pages
if [ -f $tmp_dir/a5_land.pdf ]; then
    pdfjam --quiet --nup 1x2 --paper a4paper $tmp_dir/a5_land.pdf --outfile $tmp_dir/a5-land-on-a4.pdf
fi

# Group A5 portrait pages
if [ -f $tmp_dir/a5_port.pdf ]; then
    pdfjam --quiet --nup 2x1 --landscape --paper a4paper $tmp_dir/a5_port.pdf --outfile $tmp_dir/a5-port-on-a4.pdf
fi

# Clean tmp directory
rm -f $tmp1
rm -f $tmp2
rm -f $tmp_dir/a5_land.pdf
rm -f $tmp_dir/a5_port.pdf

if [ -f $tmp_dir/a5-land-on-a4.pdf ]; then
    mv $tmp_dir/a5-land-on-a4.pdf $tmp_dir/a5_land.pdf
fi

if [ -f $tmp_dir/a5-port-on-a4.pdf ]; then
    mv $tmp_dir/a5-port-on-a4.pdf $tmp_dir/a5_port.pdf
fi

# Regroup all contents into one single file
# Possibly not all files exist.
files=(
    $tmp_dir/README.pdf
    $tmp_dir/LICENSE.pdf
    $tmp_dir/a5_land.pdf
    $tmp_dir/a5_port.pdf
    $tmp_dir/a4_land.pdf
    $tmp_dir/a4_port.pdf
)

existing_files=()

for f in "${files[@]}"; do
    if [ -f "$f" ]; then
        existing_files+=("$f")
    fi
done

if [ ${#existing_files[@]} -gt 0 ]; then
    pdfunite "${existing_files[@]}" "$outfile"
else
    echo "ERROR - No input files found"
fi

rm -r tmp
